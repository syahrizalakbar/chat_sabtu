<?php

    require "koneksi.php";

    $id = $_POST['id'];

    $cek = "SELECT * FROM tb_order WHERE id = $id";
    $result = mysqli_query($connect, $cek);

    $order;
    while ($row = mysqli_fetch_assoc($result)) {
        $order = $row;
    }

    if ($order != null) {
        $res['is_success'] = true;
        $res['message'] = "Berhasil";
        $res['data'] = $order;
    } else {
        $res['is_success'] = false;
        $res['message'] = "Gagal";
    }

    echo json_encode($res);

?>