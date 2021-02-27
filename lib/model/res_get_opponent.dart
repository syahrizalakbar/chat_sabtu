// To parse this JSON data, do
//
//     final resGetOpponent = resGetOpponentFromJson(jsonString);

import 'dart:convert';

ResGetOpponent resGetOpponentFromJson(String str) => ResGetOpponent.fromJson(json.decode(str));

String resGetOpponentToJson(ResGetOpponent data) => json.encode(data.toJson());

class ResGetOpponent {
  ResGetOpponent({
    this.isSuccess,
    this.message,
    this.data,
  });

  bool isSuccess;
  String message;
  User data;

  factory ResGetOpponent.fromJson(Map<String, dynamic> json) => ResGetOpponent(
    isSuccess: json["is_success"] == null ? null : json["is_success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : User.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "is_success": isSuccess == null ? null : isSuccess,
    "message": message == null ? null : message,
    "data": data == null ? null : data.toJson(),
  };
}

class User {
  User({
    this.id,
    this.username,
    this.password,
    this.firebaseToken,
  });

  String id;
  String username;
  String password;
  String firebaseToken;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    username: json["username"] == null ? null : json["username"],
    password: json["password"] == null ? null : json["password"],
    firebaseToken: json["firebase_token"] == null ? null : json["firebase_token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "username": username == null ? null : username,
    "password": password == null ? null : password,
    "firebase_token": firebaseToken == null ? null : firebaseToken,
  };
}
