<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

require_once 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['status' => 'error', 'message' => 'Gunakan metode POST']);
    exit;
}

$raw = file_get_contents('php://input');
$data = json_decode($raw, true);

if (!$data) {
    echo json_encode(['status' => 'error', 'message' => 'JSON tidak valid']);
    exit;
}

$userId = $data['user_id'] ?? 0;
$formData = $data['form_data'] ?? [];

if ($userId <= 0) {
    echo json_encode(['status' => 'error', 'message' => 'User ID tidak valid']);
    exit;
}

// =========================
// 1️⃣ Simpan ke tabel mahasiswa
// =========================
$nama_lengkap  = $formData['namaLengkap'] ?? '';
$nik           = $formData['nik'] ?? '';
$tempat_lahir  = $formData['tempatLahir'] ?? '';
$tanggal_lahir = isset($formData['tanggalLahir']) ? date('Y-m-d', strtotime($formData['tanggalLahir'])) : null;
$jenis_kelamin = $formData['jenisKelamin'] ?? '';
$agama         = $formData['agama'] ?? ($formData['selectedAgama'] ?? '');
$no_hp         = $formData['noHp'] ?? '';
$email         = $formData['email'] ?? '';
$alamat        = $formData['alamat'] ?? '';
$provinsi      = is_array($formData['provinsi']) ? ($formData['provinsi']['name'] ?? '') : ($formData['provinsi'] ?? '');
$kabupaten     = is_array($formData['kabupaten']) ? ($formData['kabupaten']['name'] ?? '') : ($formData['kabupaten'] ?? '');
$kecamatan     = is_array($formData['kecamatan']) ? ($formData['kecamatan']['name'] ?? '') : ($formData['kecamatan'] ?? '');
$kelurahan     = is_array($formData['kelurahan']) ? ($formData['kelurahan']['name'] ?? '') : ($formData['kelurahan'] ?? '');
$kode_pos      = $formData['kodePos'] ?? '';

$sql = "INSERT INTO mahasiswa (
    id_pengguna, nama_lengkap, nik, tempat_lahir, tanggal_lahir, jenis_kelamin, agama,
    no_hp, email, alamat_mahasiswa, provinsi, kabupaten, kecamatan, kelurahan, kode_pos, tanggal_daftar
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";

$stmt = $conn->prepare($sql);
$stmt->bind_param("issssssssssssss",
    $userId, $nama_lengkap, $nik, $tempat_lahir, $tanggal_lahir, $jenis_kelamin,
    $agama, $no_hp, $email, $alamat, $provinsi, $kabupaten, $kecamatan, $kelurahan, $kode_pos
);
$stmt->execute();
$id_mahasiswa = $conn->insert_id;


// =========================
// 2️⃣ Simpan ke tabel data_akademik
// =========================
$id_jurusan   = $formData['id_jurusan'] ?? null;
$id_prodi     = $formData['id_prodi'] ?? null;
$asal_sekolah = $formData['asalSekolah'] ?? '';
$tahun_lulus  = $formData['tahunLulus'] ?? null;
$nilai_rata   = $formData['nilaiRataRata'] ?? null;

if ($asal_sekolah || $id_prodi || $id_jurusan) {
    $sql = "INSERT INTO data_akademik (id_mahasiswa, id_jurusan, id_prodi, asal_sekolah, tahun_lulus, nilai_rata_rata)
            VALUES (?, ?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("iiisis", $id_mahasiswa, $id_jurusan, $id_prodi, $asal_sekolah, $tahun_lulus, $nilai_rata);

    $stmt->execute();
}

// =========================
// 3️⃣ Simpan ke tabel data_orangtua
// =========================
$nama_ayah = $formData['namaAyah'] ?? '';
$nik_ayah  = $formData['nikAyah'] ?? '';
$pekerjaan_ayah = $formData['pekerjaanAyah'] ?? '';
$penghasilan_ayah = $formData['penghasilanAyah'] ?? '';
$nohp_ayah = $formData['noTlpAyah'] ?? '';
$alamat_ayah = $formData['alamatAyah'] ?? '';

$nama_ibu = $formData['namaIbu'] ?? '';
$nik_ibu  = $formData['nikIbu'] ?? '';
$pekerjaan_ibu = $formData['pekerjaanIbu'] ?? '';
$penghasilan_ibu = $formData['penghasilanIbu'] ?? '';
$nohp_ibu = $formData['noTlpIbu'] ?? '';
$alamat_ibu = $formData['alamatIbu'] ?? '';

if ($nama_ayah || $nama_ibu) {
    $sql = "INSERT INTO data_orangtua (
        id_mahasiswa, nama_ayah, nik_ayah, pekerjaan_ayah, penghasilan_ayah, nohp_ayah, alamat_ayah,
        nama_ibu, nik_ibu, pekerjaan_ibu, penghasilan_ibu, nohp_ibu, alamat_ibu
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("issssssssssss",
    $id_mahasiswa,
    $nama_ayah, $nik_ayah, $pekerjaan_ayah, $penghasilan_ayah, $nohp_ayah, $alamat_ayah,
    $nama_ibu, $nik_ibu, $pekerjaan_ibu, $penghasilan_ibu, $nohp_ibu, $alamat_ibu
);

    $stmt->execute();
}

// =========================
// 4️⃣ Simpan ke tabel dokumen
// =========================
$ijazah = $formData['ijazah'] ?? null;
$kk     = $formData['kk'] ?? null;
$akta   = $formData['akta'] ?? null;
$foto   = $formData['foto'] ?? null;

$dokumen = [
    ['Ijazah/SKL', $ijazah],
    ['Kartu Keluarga', $kk],
    ['Akta Kelahiran', $akta],
    ['Pas Foto', $foto]
];

foreach ($dokumen as $dok) {
    if (!empty($dok[1])) {
        $sql = "INSERT INTO dokumen (id_mahasiswa, jenis_dokumen, nama_file, format_file, path_file, status_verifikasi)
                VALUES (?, ?, ?, ?, ?, 'Menunggu Verifikasi')";
        $stmt = $conn->prepare($sql);
        $nama_file = basename($dok[1]);
        $format_file = pathinfo($dok[1], PATHINFO_EXTENSION);
        $stmt->bind_param("issss", $id_mahasiswa, $dok[0], $nama_file, $format_file, $dok[1]);
        $stmt->execute();
    }
}
if ($stmt->error) {
    echo json_encode(['status' => 'error', 'message' => $stmt->error]);
    exit;
}

echo json_encode([
    'status' => 'success',
    'message' => 'Data mahasiswa, akademik, orangtua, dan dokumen berhasil disimpan',
    'id_mahasiswa' => $id_mahasiswa
]);
?>
