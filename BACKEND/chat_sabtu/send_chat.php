<?php

    require "koneksi.php";

    $idSender = $_POST['id_sender'];
    $idOrder = $_POST['id_order'];

    /// Get Order Detail
    $cek = "SELECT * FROM tb_order WHERE id = $idOrder";
    $result = mysqli_query($connect, $cek);

    $order;
    while ($row = mysqli_fetch_assoc($result)) {
        $order = $row;
    }
    
    /// Check sender apakah customer atau seller
    $isCustomer = false;
    if ($idSender == $order['id_customer']) {
        $isCustomer = true;
    }

    /// Set id lawan chat / Opponent
    $idOpponent;
    if ($isCustomer) {
        $idOpponent = $order['id_seller'];
    } else {
        $idOpponent = $order['id_customer'];
    }

    /// Get Token lawan chat
    $cek = "SELECT * FROM users WHERE id = $idOpponent";
    $result = mysqli_query($connect, $cek);

    $opponent; // User
    while ($row = mysqli_fetch_assoc($result)) {
        $opponent = $row;
    }

    /// Send Notification dan Add ke Firebase
    /// Bisa melalui Androidnya atau Backend

    /// Balikin Token dan id User lawan chat, 
    /// karena disini handlenya lewat android aja
    if ($opponent != null) {
        $res['is_success'] = true;
        $res['message'] = "Berhasil";
        $res['data'] = $opponent;
    } else {
        $res['is_success'] = false;
        $res['message'] = "Gaga;";
    }

    echo json_encode($res);

?>