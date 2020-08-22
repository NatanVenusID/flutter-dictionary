<?php
require "koneksi.php";
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
$response = array();
$istilah= $_POST['istilah'];
// langkah 2
$cek = "SELECT * FROM tb_kamus WHERE istilah='$istilah;
$result = mysqli_fetch_array(mysqli_query($connect, $cek));
if (isset($result)) {
$response['value'] = 1;
$response['message'] = "pencarian berhasil";
$response['istilah'] = $result['istilah'];
$response['arti'] = $result['arti_kata'];
echo json_encode($response);
} else {
$response['value'] = 0;
$response['message'] = "pencarian gagal";
echo json_encode($response);
}
}
?>
