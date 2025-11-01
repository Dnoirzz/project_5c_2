<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once 'koneksi.php';

// Validasi method
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['status' => 'error', 'message' => 'Gunakan metode POST']);
    exit();
}

// Ambil JSON dari body
$json = file_get_contents('php://input');
$data = json_decode($json, true);
file_put_contents("debug_upload.log", date("Y-m-d H:i:s") . " | RAW JSON: " . $json . "\n", FILE_APPEND);

if (!is_array($data) || empty($data)) {
    echo json_encode(['status' => 'error', 'message' => 'Data tidak valid (JSON kosong atau rusak)']);
    exit();
}

// Ambil user_id
$user_id = intval($data['user_id'] ?? 0);
if ($user_id <= 0) {
    echo json_encode(['status' => 'error', 'message' => 'User ID tidak valid']);
    exit();
}

// Ambil form_data
$form_data = $data['form_data'] ?? [];
$page_0 = $form_data['0'] ?? [];
$page_1 = $form_data['1'] ?? [];
$page_2 = $form_data['2'] ?? [];
$page_3 = $form_data['3'] ?? [];

// Cek user_id di tabel user
$check_user = $conn->prepare("SELECT id_pengguna FROM user WHERE id_pengguna = ?");
$check_user->bind_param("i", $user_id);
$check_user->execute();
$res_user = $check_user->get_result();
if ($res_user->num_rows === 0) {
    echo json_encode([
        'status' => 'error',
        'message' => "User ID ($user_id) tidak ditemukan di tabel user",
        'hint' => 'Pastikan user sudah login dan SharedPreferences menyimpan user_id'
    ]);
    exit();
}

try {
    $conn->begin_transaction();

    // ========== DATA PRIBADI ==========
    $nama_lengkap = $page_0['namaLengkap'] ?? '';
    $nik = $page_0['nik'] ?? '';
    $tempat_lahir = $page_0['tempatLahir'] ?? '';
    $tanggal_lahir = !empty($page_0['tanggalLahir']) ? date('Y-m-d', strtotime($page_0['tanggalLahir'])) : null;
    $jenis_kelamin = $page_0['jenisKelamin'] ?? '';
    $agama = $page_0['agama'] ?? '';
    $no_hp = $page_0['noHp'] ?? '';
    $email = $page_0['email'] ?? '';
    $alamat = $page_0['alamat'] ?? '';
    $kode_pos = $page_0['kodePos'] ?? '';
    $id_provinsi = $page_0['province']['id'] ?? null;
    $id_kabupaten = $page_0['regency']['id'] ?? null;
    $id_kecamatan = $page_0['district']['id'] ?? null;
    $id_kelurahan = $page_0['village']['id'] ?? null;

    $check_stmt = $conn->prepare("SELECT id_mahasiswa FROM mahasiswa WHERE id_pengguna=?");
    $check_stmt->bind_param("i", $user_id);
    $check_stmt->execute();
    $res = $check_stmt->get_result();

    if ($res->num_rows > 0) {
        // UPDATE mahasiswa
        $row = $res->fetch_assoc();
        $id_mahasiswa = $row['id_mahasiswa'];
        $sql = "UPDATE mahasiswa SET
            nama_lengkap=?, nik=?, tempat_lahir=?, tanggal_lahir=?, jenis_kelamin=?, agama=?,
            no_hp=?, email=?, alamat_mahasiswa=?, id_provinsi=?, id_kabupaten=?, id_kecamatan=?,
            id_kelurahan=?, kode_pos=?, tanggal_daftar=NOW()
            WHERE id_mahasiswa=?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param(
            "ssssssssssiiiisi",
            $nama_lengkap, $nik, $tempat_lahir, $tanggal_lahir, $jenis_kelamin, $agama,
            $no_hp, $email, $alamat, $id_provinsi, $id_kabupaten, $id_kecamatan,
            $id_kelurahan, $kode_pos, $id_mahasiswa
        );
        $stmt->execute();
        $action = "updated";
    } else {
        // INSERT mahasiswa
        $sql = "INSERT INTO mahasiswa (
            id_pengguna, nama_lengkap, nik, tempat_lahir, tanggal_lahir, jenis_kelamin, agama,
            no_hp, email, alamat_mahasiswa, id_provinsi, id_kabupaten, id_kecamatan, id_kelurahan, kode_pos, tanggal_daftar
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param(
            "isssssssssiiiss",
            $user_id, $nama_lengkap, $nik, $tempat_lahir, $tanggal_lahir, $jenis_kelamin,
            $agama, $no_hp, $email, $alamat, $id_provinsi, $id_kabupaten,
            $id_kecamatan, $id_kelurahan, $kode_pos
        );
        $stmt->execute();
        $id_mahasiswa = $conn->insert_id;
        $action = "created";
    }

    // ========== DATA AKADEMIK ==========
    $asal_sekolah = $page_1['asalSekolah'] ?? '';
    $tahun_lulus = $page_1['tahunLulus'] ?? '';
    $nilai_rata = $page_1['nilaiRata'] ?? '';
    $id_jurusan = $page_1['idJurusan'] ?? null;
    $id_prodi = $page_1['idProdi'] ?? null;

    $check_ak = $conn->prepare("SELECT id_akademik FROM data_akademik WHERE id_mahasiswa=?");
    $check_ak->bind_param("i", $id_mahasiswa);
    $check_ak->execute();
    $res_ak = $check_ak->get_result();

    if ($res_ak->num_rows > 0) {
        $sql = "UPDATE data_akademik SET asal_sekolah=?, tahun_lulus=?, nilai_rata_rata=?, id_jurusan=?, id_prodi=? WHERE id_mahasiswa=?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("sssiii", $asal_sekolah, $tahun_lulus, $nilai_rata, $id_jurusan, $id_prodi, $id_mahasiswa);
    } else {
        $sql = "INSERT INTO data_akademik (id_mahasiswa, asal_sekolah, tahun_lulus, nilai_rata_rata, id_jurusan, id_prodi)
                VALUES (?, ?, ?, ?, ?, ?)";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("isssii", $id_mahasiswa, $asal_sekolah, $tahun_lulus, $nilai_rata, $id_jurusan, $id_prodi);
    }
    $stmt->execute();

    // ========== DATA ORANG TUA ==========
    // Data orang tua
$nama_ayah = $page_2['namaAyah'] ?? '';
$pekerjaan_ayah = $page_2['pekerjaanAyah'] ?? '';
$penghasilan_ayah = $page_2['penghasilanAyah'] ?? '';
$nohp_ayah = $page_2['noTlpAyah'] ?? '';
$alamat_ayah = $page_2['alamatAyah'] ?? '';
$nama_ibu = $page_2['namaIbu'] ?? '';
$pekerjaan_ibu = $page_2['pekerjaanIbu'] ?? '';
$penghasilan_ibu = $page_2['penghasilanIbu'] ?? '';
$nohp_ibu = $page_2['noTlpIbu'] ?? '';
$alamat_ibu = $page_2['alamatIbu'] ?? '';

$check_ortu = $conn->prepare("SELECT id_orangtua FROM data_orangtua WHERE id_mahasiswa=?");
$check_ortu->bind_param("i", $id_mahasiswa);
$check_ortu->execute();
$result_ortu = $check_ortu->get_result();

if ($result_ortu->num_rows > 0) {
    $sql = "UPDATE data_orangtua 
            SET nama_ayah=?, pekerjaan_ayah=?, penghasilan_ayah=?, nohp_ayah=?, alamat_ayah=?, 
                nama_ibu=?, pekerjaan_ibu=?, penghasilan_ibu=?, nohp_ibu=?, alamat_ibu=? 
            WHERE id_mahasiswa=?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param(
        "ssssssssssi",
        $nama_ayah, $pekerjaan_ayah, $penghasilan_ayah, $nohp_ayah, $alamat_ayah,
        $nama_ibu, $pekerjaan_ibu, $penghasilan_ibu, $nohp_ibu, $alamat_ibu, $id_mahasiswa
    );
} else {
    $sql = "INSERT INTO data_orangtua 
            (id_mahasiswa, nama_ayah, pekerjaan_ayah, penghasilan_ayah, nohp_ayah, alamat_ayah,
             nama_ibu, pekerjaan_ibu, penghasilan_ibu, nohp_ibu, alamat_ibu)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param(
        "issssssssss",
        $id_mahasiswa, $nama_ayah, $pekerjaan_ayah, $penghasilan_ayah, $nohp_ayah, $alamat_ayah,
        $nama_ibu, $pekerjaan_ibu, $penghasilan_ibu, $nohp_ibu, $alamat_ibu
    );
}
$stmt->execute();


    // ========== DOKUMEN ==========
    $files = [
        'ijazah' => $page_3['ijazah'] ?? '',
        'kk' => $page_3['kk'] ?? '',
        'akta' => $page_3['akta'] ?? '',
        'foto' => $page_3['foto'] ?? ''
    ];

    foreach ($files as $jenis => $path) {
        if (!empty($path)) {
            $nama_file = basename($path);
            $format_file = pathinfo($path, PATHINFO_EXTENSION);
            $stmt = $conn->prepare("INSERT INTO dokumen (id_mahasiswa, nama_file, format_file, tanggal_upload, status_verifikasi)
                VALUES (?, ?, ?, NOW(), 'Menunggu Verifikasi')");
            $stmt->bind_param("iss", $id_mahasiswa, $nama_file, $format_file);
            $stmt->execute();
        }
    }

    $conn->commit();
    echo json_encode([
        'status' => 'success',
        'message' => "Data berhasil $action",
        'id_mahasiswa' => $id_mahasiswa
    ]);

} catch (Exception $e) {
    $conn->rollback();
    echo json_encode(['status' => 'error', 'message' => 'Gagal menyimpan: ' . $e->getMessage()]);
}

$conn->close();
?>
