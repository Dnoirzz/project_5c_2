<?php
$host = "localhost";
$user = "remoteuser";
$pass = "passwordku123";
$db   = "pmb";

$conn = mysqli_connect($host, $user, $pass, $db);

if (!$conn) {
    die(json_encode([
        "status" => "error",
        "message" => "Koneksi database gagal: " . mysqli_connect_error()
    ]));
}
?>