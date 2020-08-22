<?php
require "koneksi.php";
if ($_SERVER['REQUEST_METHOD'] == "POST") {
$response = array();
$istilah = $_POST['istilah'];
$arti = $_POST['arti'];
// langkah 2
$cek = "SELECT * FROM tb_kamus WHERE istilah='$istilah'";
$result = mysqli_fetch_array(mysqli_query($connect, $cek));
if (isset($result)) {
$response['value'] = 2;
$response['message'] = "Istilah telah didaftarkan";
echo json_encode($response);
} else {
$insert = "INSERT INTO tb_kamus VALUE(NULL,
'$istilah','$arti')";
if (mysqli_query($connect, $insert)) {
$response['value'] = 1;
$response['message'] = "Berhasil didaftarkan";
echo json_encode($response);
} else {
$response['value'] = 0;
$response['message'] = "Gagal didaftarkan";
echo json_encode($response);
}
}
}
?>
