<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') { http_response_code(200); exit; }

require_once 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
  echo json_encode(['status'=>'error','message'=>'Gunakan metode POST']); exit;
}

$raw = file_get_contents('php://input');
$data = json_decode($raw, true);
if (!$data) {
  echo json_encode(['status'=>'error','message'=>'Body JSON tidak valid']); exit;
}

$userId   = isset($data['user_id']) ? (int)$data['user_id'] : 0;
$formData = isset($data['form_data']) ? $data['form_data'] : [];

if ($userId <= 0) {
  echo json_encode(['status'=>'error','message'=>'User ID tidak valid']); exit;
}

/* Cek user exist */
$stmt = $conn->prepare("SELECT id_pengguna FROM user WHERE id_pengguna = ?");
$stmt->bind_param("i", $userId);
$stmt->execute();
$stmt->store_result();
if ($stmt->num_rows === 0) {
  echo json_encode(['status'=>'error','message'=>'User tidak ditemukan']); exit;
}
$stmt->close();

/* Ambil field yang mau disimpan (sesuaikan nama kolom di tabel kamu) */
$page_0 = $data['page_0'] ?? [];
$nama_lengkap = $page_0['namaLengkap'] ?? '';
$nik = $page_0['nik'] ?? '';
$tempat_lahir = $page_0['tempatLahir'] ?? '';
$tanggal_lahir = isset($page_0['tanggalLahir']) ? date('Y-m-d', strtotime($page_0['tanggalLahir'])) : null;
$jenis_kelamin = $page_0['jenisKelamin'] ?? '';
$agama = $page_0['agama'] ?? '';
$no_hp = $page_0['noHp'] ?? '';
$email = $page_0['email'] ?? '';
$alamat = $page_0['alamat'] ?? '';
$provinsi = $page_0['provinsi'] ?? null;
$kabupaten = $page_0['kabupaten'] ?? null;
$kecamatan = $page_0['kecamatan'] ?? null;
$kelurahan = $page_0['kelurahan'] ?? null;
$kode_pos = $page_0['kodePos'] ?? '';


/* UPSERT berbasis id_pengguna (harus UNIQUE) */
$sql = "INSERT INTO mahasiswa (
  id_pengguna, nama_lengkap, nik, tempat_lahir, tanggal_lahir, jenis_kelamin, agama,
  no_hp, email, alamat_mahasiswa, provinsi, kabupaten, kecamatan, kelurahan, kode_pos, tanggal_daftar
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";

$stmt = $conn->prepare($sql);
$stmt->bind_param(
  "issssssssssssss",
  $user_id, $nama_lengkap, $nik, $tempat_lahir, $tanggal_lahir, $jenis_kelamin,
  $agama, $no_hp, $email, $alamat, $provinsi, $kabupaten, $kecamatan, $kelurahan, $kode_pos
);


if (!$stmt->execute()) {
  echo json_encode(['status'=>'error','message'=>'Query error: '.$stmt->error]); exit;
}

echo json_encode(['status'=>'success','message'=>'Data tersimpan','affected'=>$stmt->affected_rows]);
