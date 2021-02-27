// To parse this JSON data, do
//
//     final chat = chatFromJson(jsonString);

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

Chat chatFromJson(String str) => Chat.fromJson(json.decode(str));

String chatToJson(Chat data) => json.encode(data.toJson());

class Chat {
  Chat({
    this.idSender,
    this.message,
    this.time,
  });

  int idSender;
  String message;
  int time;

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    idSender: json["id_sender"] == null ? null : json["id_sender"],
    message: json["message"] == null ? null : json["message"],
    time: json["time"] == null ? null : json["time"],
  );

  factory Chat.fromSnapshot(DataSnapshot snapshot) => Chat(
    idSender: snapshot.value["id_sender"] == null ? null : snapshot.value["id_sender"],
    message: snapshot.value["message"] == null ? null : snapshot.value["message"],
    time: snapshot.value["time"] == null ? null : snapshot.value["time"],
  );

  Map<String, dynamic> toJson() => {
    "id_sender": idSender == null ? null : idSender,
    "message": message == null ? null : message,
    "time": time == null ? null : time,
  };
}
