import 'dart:async';
import 'dart:convert';

import 'package:chat_sabtu/model/chat.dart';
import 'package:chat_sabtu/model/res_get_opponent.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ChatPage extends StatefulWidget {
  final int idOrder;
  final idUser;

  ChatPage(this.idOrder, this.idUser);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController message = TextEditingController();
  FirebaseMessaging fcm = FirebaseMessaging();
  FirebaseDatabase db = FirebaseDatabase.instance;
  List<Chat> chats = [];

  StreamSubscription<Event> streamChatAdded;

  Future<void> sendMessage(String msg) async {
    /// INI BISA DIBUAT DISERVER UNTUK NAMBAHIN CHAT DAN KIRIM NOTIFIKASINYA

    /// Get Lawan Chat
    Response res = await post(
      "http://192.168.10.43/chat_sabtu/send_chat.php",
      body: {
        "id_order": widget.idOrder.toString(),
        "id_sender": widget.idUser.toString(),
      },
    );
    if (res.statusCode == 200) {
      ResGetOpponent opponent = resGetOpponentFromJson(res.body);

      /// Nambahin chat ke firebase
      await db
          .reference()
          .child("message")
          .child("${widget.idOrder}")
          .push()
          .set({
        "id_sender": int.parse(widget.idUser.toString()),
        "message": msg,
        "time": DateTime.now().millisecondsSinceEpoch,
      });

      /// Send Notifikasi
      Response response = await post(
        "https://fcm.googleapis.com/fcm/send",
        headers: {
          "Authorization":
              "key=AAAAXz8HoTY:APA91bHuku2iMKrm7pyQ4C6Hdus3ACn_6zyLiDIZMqKZH7DFc-0NuU1fJLMbULTWs4_NmzX72YdD37hbY_AAEzHHnjA7ZZmAEH9hbrKtEV5JSOkSxMkfL3MA1bP-gUaS1vKUIyJbUaRT",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "registration_ids": [opponent.data.firebaseToken],
          "notification": {"title": "Chat baru", "body": msg},
          "data": {
            "id_sender": widget.idUser,
            "id_order": widget.idOrder,
            "body": msg,
          }
        }),
      );
      print(response.body);
    }
  }

  Future<void> getChats() async {
    streamChatAdded = db
        .reference()
        .child("message")
        .child("${widget.idOrder}")
        .onChildAdded
        .listen((event) {
      setState(() {
        chats.add(Chat.fromSnapshot(event.snapshot));
      });
    });
  }

  @override
  void initState() {
    getChats();
    fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    streamChatAdded?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 70,
            child: Container(
              child: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  bool isOpponent = false;
                  if (chats[index].idSender.toString() !=
                      widget.idUser.toString()) {
                    isOpponent = true;
                  }

                  if (isOpponent) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Text(
                            chats[index].message,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Text(
                            chats[index].message,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: message,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () async {
                      if (message.text.trim().isNotEmpty) {
                        await sendMessage(message.text.trim());
                        message.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
