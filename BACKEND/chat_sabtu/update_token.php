<?php

    require "koneksi.php";

    $idUser = $_POST['id_user'];
    $token = $_POST['token'];

    $query = "UPDATE users SET firebase_token = '$token' WHERE id = $idUser";

    $result = mysqli_query($connect, $query);

    if ($result > 0) {
        $res['is_success'] = true;
        $res['message'] = "Berhasil";
    } else {
        $res['is_success'] = false;
        $res['message'] = "Gaga;";
    }

    echo json_encode($res);

?>