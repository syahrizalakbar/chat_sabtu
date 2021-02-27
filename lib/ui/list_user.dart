// import 'dart:convert';
//
// import 'package:chat_sabtu/ui/chat_page.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
//
// class ListUser extends StatefulWidget {
//   final String idUser;
//
//   const ListUser(this.idUser);
//
//   @override
//   _ListUserState createState() => _ListUserState();
// }
//
// class _ListUserState extends State<ListUser> {
//   List otherUser = [];
//
//   GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
//
//   ///
//   /// 1. Simpan Token FCM User Ke Database
//   ///
//
//
//   Future<void> getOtherUser() async {
//     Response res = await post(
//       "http://192.168.10.43/chat_sabtu/get_other_user.php",
//       body: {
//         "id": widget.idUser,
//       },
//     );
//
//     print(res.body);
//     if (res.statusCode == 200) {
//       otherUser = jsonDecode(res.body);
//
//       if (otherUser.length > 0) {
//         setState(() {});
//       } else {
//         key.currentState.showSnackBar(SnackBar(content: Text("Tidak ada user")));
//       }
//     } else {
//       key.currentState.showSnackBar(SnackBar(content: Text("Error get Other User")));
//     }
//   }
//
//   @override
//   void initState() {
//     getOtherUser();
//
//     fcm.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         print("onMessage: $message");
//
//       },
//       onLaunch: (Map<String, dynamic> message) async {
//         print("onLaunch: $message");
//
//       },
//       onResume: (Map<String, dynamic> message) async {
//         print("onResume: $message");
//
//       },
//     );
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: key,
//       appBar: AppBar(
//         title: Text("List Your Contacts"),
//       ),
//       body: ListView.builder(
//         itemCount: otherUser.length,
//         itemBuilder: (context, index) {
//           return Card(
//             child: ListTile(
//               title: Text(otherUser[index]['username']),
//               onTap: () {
//                 // pindah ke chat personal
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ChatPage(otherUser[index]),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
