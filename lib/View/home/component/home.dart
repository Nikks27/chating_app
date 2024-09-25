// import 'package:chating_app/services/firebase_cloud_services.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../modal/user_modal.dart';
// import '../home_page.dart';
//
// FutureBuilder<QuerySnapshot<Map<String, dynamic>>> Home() {
//   return FutureBuilder(
//     future: CloudFireStoreService.cloudFireStoreService
//         .readAllUserFromCloudFireStore(),
//     builder: (context, snapshot) {
//       if (snapshot.hasError) {
//         return Center(child: Text(snapshot.error.toString()),);
//       }
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return Center(child: CircularProgressIndicator(),);
//       }
//       List data = snapshot.data!.docs;
//       List<UserModel> userList = [];
//       for (var user in data) {
//         userList.add(UserModel.fromMap(user.data(),),);
//       }
//       return ListView.builder(
//         itemCount: userList.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             onTap: () {
//               chatController.getReceiver(userList[index].email!,userList[index].name!);
//               Get.toNamed("/chat");
//             },
//             leading: CircleAvatar(backgroundImage: NetworkImage(userList[index].image!),),
//             title: Text(userList[index].name!),
//             subtitle: Text(userList[index].email!),
//           );
//         },
//       );
//
//     },
//   );
// }
