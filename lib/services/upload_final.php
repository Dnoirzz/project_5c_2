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

// Pastikan metode POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['status' => 'error', 'message' => 'Gunakan metode POST']);
    exit;
}

// Ambil JSON dari Flutter
$raw = file_get_contents('php://input');
$data = json_decode($raw, true);

if (!$data) {
    echo json_encode(['status' => 'error', 'message' => 'Body JSON tidak valid']);
    exit;
}

$userId   = isset($data['user_id']) ? intval($data['user_id']) : 0;
$formData = isset($data['form_data']) ? $data['form_data'] : [];

if ($userId <= 0) {
    echo json_encode(['status' => 'error', 'message' => 'User ID tidak valid']);
    exit;
}

// 🔹 Pastikan user ada
$checkUser = $conn->prepare("SELECT id_pengguna FROM user WHERE id_pengguna = ?");
$checkUser->bind_param("i", $userId);
$checkUser->execute();
$checkUser->store_result();
if ($checkUser->num_rows === 0) {
    echo json_encode(['status' => 'error', 'message' => 'User tidak ditemukan']);
    exit;
}
$checkUser->close();

// 🔹 Ambil field dari formData (gabungan dari semua halaman Flutter)
$nama_lengkap   = $formData['namaLengkap'] ?? '';
$nik            = $formData['nik'] ?? '';
$tempat_lahir   = $formData['tempatLahir'] ?? '';
$tanggal_lahir  = isset($formData['tanggalLahir']) ? date('Y-m-d', strtotime($formData['tanggalLahir'])) : null;
$jenis_kelamin  = $formData['jenisKelamin'] ?? '';
$agama = $page_0['agama'] ?? ($page_0['selectedAgama'] ?? '');
$no_hp          = $formData['noHp'] ?? '';
$email          = $formData['email'] ?? '';
$alamat         = $formData['alamat'] ?? '';
$provinsiData  = $formData['provinsi'] ?? null;

$kecamatanData = $formData['kecamatan'] ?? null;
$kelurahanData = $formData['kelurahan'] ?? null;
$kabupatenData = $formData['kabupaten'] ?? ($formData['city'] ?? null);

$kabupaten = is_array($kabupatenData) ? ($kabupatenData['name'] ?? null) : $kabupatenData;

$provinsi  = is_array($provinsiData)  ? ($provinsiData['name'] ?? null)  : $provinsiData;

$kecamatan = is_array($kecamatanData) ? ($kecamatanData['name'] ?? null) : $kecamatanData;
$kelurahan = is_array($kelurahanData) ? ($kelurahanData['name'] ?? null) : $kelurahanData;

$kode_pos       = $formData['kodePos'] ?? '';

// 🔹 Simpan ke tabel mahasiswa
$sql = "INSERT INTO mahasiswa (
    id_pengguna, nama_lengkap, nik, tempat_lahir, tanggal_lahir,
    jenis_kelamin, agama, no_hp, email, alamat_mahasiswa,
    provinsi, kabupaten, kecamatan, kelurahan, kode_pos, tanggal_daftar
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";

$stmt = $conn->prepare($sql);
$stmt->bind_param(
    "issssssssssssss",
    $userId, $nama_lengkap, $nik, $tempat_lahir, $tanggal_lahir,
    $jenis_kelamin, $agama, $no_hp, $email, $alamat,
    $provinsi, $kabupaten, $kecamatan, $kelurahan, $kode_pos
);

if (!$stmt->execute()) {
    echo json_encode(['status' => 'error', 'message' => 'Query error: ' . $stmt->error]);
    exit;
}

echo json_encode([
    'status' => 'success',
    'message' => 'Data berhasil disimpan ke tabel mahasiswa',
    'affected_rows' => $stmt->affected_rows
]);
