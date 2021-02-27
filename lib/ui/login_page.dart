import 'dart:convert';

import 'package:chat_sabtu/ui/chat_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  FirebaseMessaging fcm = FirebaseMessaging();


  Future<void> updateTokenFirebase(String idUser) async {
    /// Get Token FCM, dan simpan ke database sesuai dengan id usernya
    /// Fungsinya untuk mengirim notifikasi ke user ini
    String tokenFcm = await fcm.getToken();

    Response res = await post(
      "http://192.168.10.43/chat_sabtu/update_token.php",
      body: {
        "id_user": idUser,
        "token": tokenFcm,
      },
    );

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);

      if (data['is_success'] == true) {
        print("Berhasil token $tokenFcm");
      } else {
        print("Gagal update token");
      }
    } else {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Error update token")));
    }
  }

  Future<void> login() async {
    String uname = username.text;
    String pass = password.text;

    Response res = await post(
      "http://192.168.10.43/chat_sabtu/login.php",
      body: {
        "username": uname,
        "password": pass,
      },
    );

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      if (data['value'] == 1) {

        await updateTokenFirebase(data['id']);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(1, data['id']), // 340 ID Order dummy
          ),
        );
      } else {
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text("Username atau password tidak tepat")));
      }
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Error Login")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              controller: username,
            ),
            TextFormField(
              controller: password,
            ),
            MaterialButton(
              child: Text("Login"),
              onPressed: login,
            ),
          ],
        ),
      ),
    );
  }
}