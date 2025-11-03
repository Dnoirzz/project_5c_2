<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Content-Type: application/json");

require_once 'config.php';

try {
    // Query untuk mengambil data mahasiswa beserta status verifikasi dokumen
    $query = "
        SELECT 
            dm.id_mahasiswa,
            dm.nama_lengkap,
            dm.email,
            dm.jenis_kelamin,
            da.jurusan,
            da.kode_prodi,
            COALESCE(
                CASE 
                    WHEN COUNT(CASE WHEN dd.status_verifikasi = 'Ditolak Verifikasi' THEN 1 END) > 0 
                        THEN 'Ditolak Verifikasi'
                    WHEN COUNT(CASE WHEN dd.status_verifikasi = 'Lulus Verifikasi' THEN 1 END) = COUNT(dd.id_dokumen) 
                        AND COUNT(dd.id_dokumen) > 0 
                        THEN 'Lulus Verifikasi'
                    WHEN COUNT(dd.id_dokumen) > 0 
                        THEN 'Menunggu Verifikasi'
                    ELSE 'Belum Upload Dokumen'
                END,
                'Belum Upload Dokumen'
            ) AS status_verifikasi
        FROM data_mahasiswa dm
        LEFT JOIN data_akademik da ON dm.id_mahasiswa = da.id_mahasiswa
        LEFT JOIN data_dokumen dd ON dm.id_mahasiswa = dd.id_mahasiswa
        GROUP BY dm.id_mahasiswa, dm.nama_lengkap, dm.email, dm.jenis_kelamin, da.jurusan, da.kode_prodi
        ORDER BY dm.tanggal_daftar DESC
    ";

    $result = mysqli_query($conn, $query);
    
    if (!$result) {
        throw new Exception("Query error: " . mysqli_error($conn));
    }

    $mahasiswaList = [];
    $lakiLakiCount = 0;
    $perempuanCount = 0;
    $terverifikasiCount = 0;
    $belumVerifikasiCount = 0;
    $unverifiedList = [];

    while ($row = mysqli_fetch_assoc($result)) {
        $mahasiswaList[] = $row;
        
        // Hitung berdasarkan jenis kelamin
        if (strtolower($row['jenis_kelamin']) == 'laki-laki') {
            $lakiLakiCount++;
        } else if (strtolower($row['jenis_kelamin']) == 'perempuan') {
            $perempuanCount++;
        }
        
        // Hitung berdasarkan status verifikasi
        if ($row['status_verifikasi'] == 'Lulus Verifikasi') {
            $terverifikasiCount++;
        } else {
            $belumVerifikasiCount++;
            // Tambahkan ke daftar yang belum terverifikasi
            $unverifiedList[] = [
                'id_mahasiswa' => $row['id_mahasiswa'],
                'nama_mahasiswa' => $row['nama_lengkap'],
                'email' => $row['email'],
                'jurusan' => $row['jurusan'] ?? '-',
                'prodi' => $row['kode_prodi'] ?? '-',
                'status_verifikasi' => $row['status_verifikasi']
            ];
        }
    }

    // Query tambahan untuk distribusi per jurusan
    $queryJurusan = "
        SELECT 
            da.jurusan,
            COUNT(DISTINCT dm.id_mahasiswa) as jumlah
        FROM data_mahasiswa dm
        LEFT JOIN data_akademik da ON dm.id_mahasiswa = da.id_mahasiswa
        WHERE da.jurusan IS NOT NULL AND da.jurusan != ''
        GROUP BY da.jurusan
    ";
    
    $resultJurusan = mysqli_query($conn, $queryJurusan);
    $distribusiJurusan = [];
    
    if ($resultJurusan) {
        while ($row = mysqli_fetch_assoc($resultJurusan)) {
            $distribusiJurusan[] = [
                'jurusan' => $row['jurusan'],
                'jumlah' => (int)$row['jumlah']
            ];
        }
    }

    // Response JSON
    echo json_encode([
        "success" => true,
        "message" => "Data berhasil dimuat",
        "jumlahMahasiswa" => count($mahasiswaList),
        "lakiLakiCount" => $lakiLakiCount,
        "perempuanCount" => $perempuanCount,
        "jumlahTerverifikasi" => $terverifikasiCount,
        "jumlahBelumVerifikasi" => $belumVerifikasiCount,
        "unverified" => $unverifiedList,
        "data_mahasiswa_user" => $mahasiswaList,
        "distribusiJurusan" => $distribusiJurusan
    ], JSON_PRETTY_PRINT);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "success" => false,
        "message" => "Error: " . $e->getMessage()
    ]);
}

mysqli_close($conn);
?>
