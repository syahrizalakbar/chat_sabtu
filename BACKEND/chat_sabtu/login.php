<?php
 require "koneksi.php";

$response = array();
$username = $_POST['username'];
$password = $_POST['password'] ;


$cek = "SELECT * FROM users WHERE username='$username' AND password='$password'";
$result = mysqli_fetch_array(mysqli_query($connect, $cek));

if (isset($result)) {
	$response['value'] = 1;
	$response['message'] = "Login Berhasil";
	$response['id'] = $result['id'];
	$response['username'] = $result['username'];

	echo json_encode($response);
} else {
	$response['value'] = 0;
	$response['message'] = "Login Gagal";
	echo json_encode($response);
}


?>
