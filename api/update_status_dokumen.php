<?php
// Enable error reporting untuk debugging
error_reporting(E_ALL);
ini_set('display_errors', 0);
ini_set('log_errors', 1);

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

// Cek apakah config.php ada
if (!file_exists('config.php')) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Config file tidak ditemukan'
    ]);
    exit;
}

require_once 'config.php';

// Cek apakah variabel database sudah didefinisikan
if (!isset($host) || !isset($user) || !isset($db)) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Konfigurasi database tidak lengkap'
    ]);
    exit;
}

// Hanya terima POST request
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode([
        'success' => false,
        'message' => 'Method not allowed. Use POST.'
    ]);
    exit;
}

// Ambil data dari POST
$id_mahasiswa = isset($_POST['id_mahasiswa']) ? trim($_POST['id_mahasiswa']) : '';
$jenis_dokumen = isset($_POST['jenis_dokumen']) ? trim($_POST['jenis_dokumen']) : '';
$status_verifikasi = isset($_POST['status_verifikasi']) ? trim($_POST['status_verifikasi']) : '';

// Validasi input
if (empty($id_mahasiswa)) {
    echo json_encode([
        'success' => false,
        'message' => 'ID mahasiswa tidak boleh kosong'
    ]);
    exit;
}

if (empty($jenis_dokumen)) {
    echo json_encode([
        'success' => false,
        'message' => 'Jenis dokumen tidak boleh kosong'
    ]);
    exit;
}

if (empty($status_verifikasi)) {
    echo json_encode([
        'success' => false,
        'message' => 'Status verifikasi tidak boleh kosong'
    ]);
    exit;
}

// Validasi status_verifikasi sesuai enum di database
$validStatus = ['Menunggu Verifikasi', 'Lulus Verifikasi', 'Ditolak Verifikasi'];
if (!in_array($status_verifikasi, $validStatus)) {
    echo json_encode([
        'success' => false,
        'message' => 'Status verifikasi tidak valid. Harus: Menunggu Verifikasi, Lulus Verifikasi, atau Ditolak Verifikasi'
    ]);
    exit;
}

try {
    // Convert id_mahasiswa ke integer
    $id_mahasiswa_int = intval($id_mahasiswa);
    
    if ($id_mahasiswa_int <= 0) {
        throw new Exception("ID mahasiswa tidak valid");
    }
    
    // Koneksi database menggunakan variabel dari config.php
    $conn = new mysqli($host, $user, $pass, $db);
    
    if ($conn->connect_error) {
        throw new Exception("Koneksi database gagal: " . $conn->connect_error);
    }
    
    // Set charset
    $conn->set_charset("utf8mb4");
    
    // Debug: Cek apakah data dokumen ada dan cek semua jenis dokumen yang tersedia
    $check_stmt = $conn->prepare("
        SELECT id_dokumen, jenis_dokumen, status_verifikasi 
        FROM dokumen 
        WHERE id_mahasiswa = ? AND jenis_dokumen = ?
    ");
    
    if ($check_stmt) {
        $check_stmt->bind_param("is", $id_mahasiswa_int, $jenis_dokumen);
        $check_stmt->execute();
        $result = $check_stmt->get_result();
        $check_stmt->close();
        
        if ($result->num_rows == 0) {
            // Cek semua jenis dokumen yang ada untuk mahasiswa ini
            $list_stmt = $conn->prepare("
                SELECT DISTINCT jenis_dokumen 
                FROM dokumen 
                WHERE id_mahasiswa = ?
            ");
            
            $available_docs = [];
            if ($list_stmt) {
                $list_stmt->bind_param("i", $id_mahasiswa_int);
                $list_stmt->execute();
                $list_result = $list_stmt->get_result();
                while ($row = $list_result->fetch_assoc()) {
                    $available_docs[] = $row['jenis_dokumen'];
                }
                $list_stmt->close();
            }
            
            $conn->close();
            
            $available_docs_str = !empty($available_docs) 
                ? 'Jenis dokumen yang tersedia: ' . implode(', ', $available_docs)
                : 'Tidak ada dokumen untuk mahasiswa ini';
            
            echo json_encode([
                'success' => false,
                'message' => 'Dokumen tidak ditemukan untuk id_mahasiswa: ' . $id_mahasiswa_int . ' dan jenis_dokumen: "' . $jenis_dokumen . '". ' . $available_docs_str
            ]);
            exit;
        }
    }
    
    // Update status_verifikasi di tabel dokumen
    // WHERE id_mahasiswa = ? AND jenis_dokumen = ?
    $stmt = $conn->prepare("
        UPDATE dokumen 
        SET status_verifikasi = ? 
        WHERE id_mahasiswa = ? AND jenis_dokumen = ?
    ");
    
    if (!$stmt) {
        throw new Exception("Prepare statement gagal: " . $conn->error);
    }
    
    $stmt->bind_param("sis", $status_verifikasi, $id_mahasiswa_int, $jenis_dokumen);
    
    if (!$stmt->execute()) {
        throw new Exception("Execute statement gagal: " . $stmt->error);
    }
    
    // Cek apakah ada baris yang terupdate
    $affected_rows = $stmt->affected_rows;
    
    if ($affected_rows > 0) {
        // Berhasil update
        echo json_encode([
            'success' => true,
            'message' => 'Status dokumen berhasil diupdate',
            'data' => [
                'id_mahasiswa' => $id_mahasiswa_int,
                'jenis_dokumen' => $jenis_dokumen,
                'status_verifikasi' => $status_verifikasi,
                'affected_rows' => $affected_rows
            ]
        ]);
    } else {
        // Tidak ada baris yang terupdate (kemungkinan status sudah sama)
        echo json_encode([
            'success' => false,
            'message' => 'Status dokumen sudah sama atau tidak ada perubahan. Status saat ini mungkin sudah: ' . $status_verifikasi
        ]);
    }
    
    $stmt->close();
    $conn->close();
    
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Error: ' . $e->getMessage()
    ]);
} catch (Error $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Fatal Error: ' . $e->getMessage()
    ]);
}
?>

