import 'package:chating_app/modal/user_modal.dart';
import 'package:chating_app/services/firebase_cloud_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/ChatController.dart';
import '../../global/global.dart';
import '../../services/Local_Notification_Services.dart';

var chatController = Get.put(ChatController());

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(
      //   child: FutureBuilder(
      //     future: CloudFireStoreService.cloudFireStoreService
      //         .readCurrentUserFromFireStore(),
      //     builder: (context, snapshot) {
      //       if (snapshot.hasError) {
      //         return Center(child: Text(snapshot.error.toString()));
      //       }
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         return Center(child: CircularProgressIndicator());
      //       }
      //
      //       Map? data = snapshot.data!.data();
      //       UserModel userModel = UserModel.fromMap(data!);
      //       return Column(
      //         children: [
      //           DrawerHeader(
      //               child: CircleAvatar(
      //                 radius: 45,
      //                 backgroundImage: NetworkImage(userModel.image!),
      //               )),
      //           Text(userModel.name!),
      //           Text(userModel.email!),
      //           Text(userModel.phone!),
      //         ],
      //       );
      //     },
      //   ),
      // ),
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
              onPressed: () async {
                await LocalNotificationService.localNotificationService
                    .scheduledNotification();
              },
              icon: Icon(Icons.notification_add_outlined)),
    PopupMenuButton<String>(
    onSelected: (value) {
    print('Selected: $value');
    },
    itemBuilder: (BuildContext context) {
    return [
    buildPopupMenuItem('New group',),
    buildPopupMenuItem('New broadcast',),
    buildPopupMenuItem('Linked devices', ),
    buildPopupMenuItem('Payments', ),
    buildPopupMenuItem('Settings',),
    ];
    },
    icon: Icon(Icons.more_vert),),
        ],
      ),
      body: FutureBuilder(
        future: CloudFireStoreService.cloudFireStoreService
            .readAllUserFromCloudFireStore(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List data = snapshot.data!.docs;
          List<UserModel> userList = [];
          for (var user in data) {
            userList.add(
              UserModel.fromMap(
                user.data(),
              ),
            );
          }
          return ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  chatController.getReceiver(
                      userList[index].email!, userList[index].name!);
                  Get.toNamed("/chat");
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(userList[index].image!),
                ),
                title: Text(userList[index].name!),
                subtitle: Text(userList[index].email!),
              );
            },
          );
        },
      ),

      // bottomNavigationBar: NavigationBarTheme(
      //     data:NavigationBarThemeData(
      //       indicatorColor: Colors.blueAccent.shade200,
      //       labelTextStyle: MaterialStateProperty.all(
      //         TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
      //       )
      //     ),
      //     child:NavigationBar(
      //       height: 70,
      //         selectedIndex: index,
      //         // onDestinationSelected: (index) => setState(() => this.index = index),
      //         onDestinationSelected: (index) => setState(() => this.index = index),
      //         destinations: [
      //           NavigationDestination(icon: GestureDetector( onTap: () {
      //             Get.toNamed('/home');
      //           },child: Icon(Icons.home)), label: 'Home'),
      //           NavigationDestination(icon: GestureDetector( onTap: () {
      //             Get.toNamed('/status');
      //           },child: Icon(Icons.upload_file)), label: 'Status'),
      //           NavigationDestination(icon: GestureDetector( onTap: () {
      //             Get.toNamed('/call');
      //           },child: Icon(Icons.call)), label: 'Call'),
      //           NavigationDestination(icon: GestureDetector( onTap: () {
      //             Get.toNamed('/profile');
      //           },child: Icon(Icons.person)), label: 'Profile'),
      //           // NavigationDestination(icon: Icon(Icons.upload_file), label: 'Status'),
      //           // NavigationDestination(icon: Icon(Icons.call), label: 'Call'),
      //           // NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
      //         ]
      //     )),
    );
  }
}

// class NavigationMenu extends StatelessWidget{
//   const NavigationMenu ({super.key});
//   @override
//   Widget build(BuildContext context){
//     final controller = Get.put(NavigationController());
//     return Scaffold(
//       bottomNavigationBar: Obx(
//           ()=> NavigationBar(
//             height: 80,
//             elevation: 0,
//             selectedIndex: controller.selectedIndex.value,
//             onDestinationSelected: (index) => controller.selectedIndex.value = index,
//             destinations:[
//               NavigationDestination(icon: Icon(Icons.home), label:'Home'),
//               NavigationDestination(icon: Icon(Icons.upload_file), label:'Status'),
//               NavigationDestination(icon: Icon(Icons.call), label:'Call'),
//               NavigationDestination(icon: Icon(Icons.person), label:'Profile'),
//             ],
//       ),
//     )
//     );
//   }
// }
//
// class NavigationController extends GetxController{
//   final Rx<int> selectedIndex = 0.obs;
//
//   final Screen = [ HomePage(), StatusScreen(),CallPage(),ProfilePage(),];
// }

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controller/ChatController.dart';
// import '../../modal/user_modal.dart';
// import '../../services/auth_services.dart';
// import '../../services/firebase_cloud_services.dart';
// import '../../services/google_services.dart';
// import '../sign_in.dart';
//
//
// var chatController=Get.put(ChatController());
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         drawer: Drawer(
//           child: FutureBuilder(
//               future: CloudFireStoreService.cloudFireStoreService
//                   .readCurrentUserFromFireStore(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) {
//                   return Center(
//                     child: Text(snapshot.error.toString()),
//                   );
//                 }
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//
//                 Map? data = snapshot.data!.data();
//                 UserModel userModel = UserModel.fromMap(data!);
//                 return Center(
//                   child: Column(
//                     children: [
//                       DrawerHeader(
//                           child: CircleAvatar(
//                             radius: 40,
//                             backgroundImage: NetworkImage(userModel.image!),
//                           )),
//                       Text(userModel.name!),
//                       Text(userModel.email!),
//                       Text(userModel.phone!),
//                     ],
//                   ),
//                 );
//               }),
//         ),
//         appBar: AppBar(
//           title: Text("Homepage"),
//           actions: [
//             IconButton(
//                 onPressed: () async {
//                   await AuthService.authService.singOutUser();
//                   await GoogleAuthService.googleAuthService.signOutFromGoogle();
//                   User? user = AuthService.authService.getCurrentUser();
//                   if (user == null) {
//                     Get.off(const SignIn());
//                   }
//                 },
//                 icon: Icon(Icons.logout))
//           ],
//         ),
//         body: FutureBuilder(
//             future: CloudFireStoreService.cloudFireStoreService
//                 .readAllUserFromCloudFireStore(),
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return Center(
//                   child: Text(snapshot.error.toString()),
//                 );
//               }
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//               List data = snapshot.data!.docs;
//               List<UserModel> userList = [];
//               for (var user in data) {
//                 userList.add(UserModel.fromMap(user.data()));
//               }
//               return ListView.builder(
//                   itemCount: userList.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       onTap: () {
//                         chatController.getReceiver(userList[index].email!, userList[index].name!);
//                         Get.toNamed('/chat');
//                       },
//                       leading: CircleAvatar(backgroundImage: NetworkImage(userList[index].image!),),
//
//                       title: Text(userList[index].name!),
//                       subtitle: Text(userList[index].email!),
//
//                     );
//                   });
//             })
//
//       // Column(
//       //   children: [
//       //
//       //
//       //   ],
//       // ),
//     );
//   }
// }





