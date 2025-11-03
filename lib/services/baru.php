<?php

require_once 'koneksi.php';// sesuaikan path jika koneksi.php di root project

header('Content-Type: application/json; charset=utf-8');

$destination = null;
$id_mahasiswa = intval($_POST['id_mahasiswa'] ?? 0);

try {
    if ($id_mahasiswa <= 0) {
        throw new Exception('id_mahasiswa tidak dikirim atau nol. Jika mendaftar baru, insert data mahasiswa dulu.');
    }

    // cek apakah id_mahasiswa ada pada tabel mahasiswa
    $chk = $conn->prepare("SELECT 1 FROM mahasiswa WHERE id_mahasiswa = ?");
    $chk->bind_param('i', $id_mahasiswa);
    $chk->execute();
    $chk->store_result();
    if ($chk->num_rows === 0) {
        $chk->close();
        throw new Exception('id_mahasiswa tidak ditemukan di tabel mahasiswa (foreign key gagal).');
    }
    $chk->close();

    $conn->begin_transaction();

    // 1) INSERT dokumen (file upload) — jika ada file
    if (isset($_FILES['file_dokumen']) && $_FILES['file_dokumen']['error'] === UPLOAD_ERR_OK) {
        $file = $_FILES['file_dokumen'];
        $originalName = $file['name'];
        $ext = pathinfo($originalName, PATHINFO_EXTENSION);
        $safeName = time() . '_' . bin2hex(random_bytes(6)) . '.' . $ext;
        $uploadDir = __DIR__ . '/uploads/';
        if (!is_dir($uploadDir)) mkdir($uploadDir, 0755, true);
        $destination = $uploadDir . $safeName;
        if (!move_uploaded_file($file['tmp_name'], $destination)) {
            throw new Exception('Gagal memindahkan file.');
        }
        $jenis = $_POST['jenis_dokumen'] ?? 'lainnya';
        $format = $ext;
        $path_rel = 'lib/services/uploads/' . $safeName; // path relatif sesuai struktur Anda

        $stmt = $conn->prepare("INSERT INTO dokumen (id_mahasiswa, jenis_dokumen, nama_file, format_file, path_file) VALUES (?,?,?,?,?)");
        $stmt->bind_param('issss', $id_mahasiswa, $jenis, $originalName, $format, $path_rel);
        if (!$stmt->execute()) throw new Exception('Gagal insert dokumen: ' . $stmt->error);
        $stmt->close();
    }

    // 2) INSERT data_akademik
    $id_jurusan = intval($_POST['id_jurusan'] ?? 0);
    $id_prodi = intval($_POST['id_prodi'] ?? 0);
    $asal_sekolah = $_POST['asal_sekolah'] ?? '';
    $tahun_lulus = $_POST['tahun_lulus'] ?? '';
    $nilai_rata_rata = $_POST['nilai_rata_rata'] !== null ? floatval($_POST['nilai_rata_rata']) : null;

    $stmt = $conn->prepare("INSERT INTO data_akademik (id_mahasiswa, id_jurusan, id_prodi, asal_sekolah, tahun_lulus, nilai_rata_rata) VALUES (?,?,?,?,?,?)");
    // i i i s s d
    $stmt->bind_param('iiissd', $id_mahasiswa, $id_jurusan, $id_prodi, $asal_sekolah, $tahun_lulus, $nilai_rata_rata);
    if (!$stmt->execute()) throw new Exception('Gagal insert data_akademik: ' . $stmt->error);
    $stmt->close();

    // 3) INSERT data_orangtua
    $nama_ayah = $_POST['nama_ayah'] ?? '';
    $nik_ayah = $_POST['nik_ayah'] ?? '';
    $pekerjaan_ayah = $_POST['pekerjaan_ayah'] ?? '';
    $penghasilan_ayah = $_POST['penghasilan_ayah'] ?? '';
    $nohp_ayah = $_POST['nohp_ayah'] ?? '';
    $alamat_ayah = $_POST['alamat_ayah'] ?? '';

    $nama_ibu = $_POST['nama_ibu'] ?? '';
    $nik_ibu = $_POST['nik_ibu'] ?? '';
    $pekerjaan_ibu = $_POST['pekerjaan_ibu'] ?? '';
    $penghasilan_ibu = $_POST['penghasilan_ibu'] ?? '';
    $nohp_ibu = $_POST['nohp_ibu'] ?? '';
    $alamat_ibu = $_POST['alamat_ibu'] ?? '';

    $stmt = $conn->prepare("INSERT INTO data_orangtua (id_mahasiswa, nama_ayah, nik_ayah, pekerjaan_ayah, penghasilan_ayah, nohp_ayah, alamat_ayah, nama_ibu, nik_ibu, pekerjaan_ibu, penghasilan_ibu, nohp_ibu, alamat_ibu) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)");
    $stmt->bind_param(
        'issssssssssss',
        $id_mahasiswa,
        $nama_ayah,
        $nik_ayah,
        $pekerjaan_ayah,
        $penghasilan_ayah,
        $nohp_ayah,
        $alamat_ayah,
        $nama_ibu,
        $nik_ibu,
        $pekerjaan_ibu,
        $penghasilan_ibu,
        $nohp_ibu,
        $alamat_ibu
    );
    if (!$stmt->execute()) throw new Exception('Gagal insert data_orangtua: ' . $stmt->error);
    $stmt->close();

    $conn->commit();

    echo json_encode(['success' => true, 'message' => 'Data berhasil disimpan.']);
} catch (Exception $e) {
    if ($conn && $conn->errno) {
        $conn->rollback();
    }
    if (!empty($destination) && file_exists($destination)) @unlink($destination);
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
// ...existing code...