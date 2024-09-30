import 'package:chating_app/View/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modal/user_modal.dart';
import '../../services/auth_services.dart';
import '../../services/firebase_cloud_services.dart';
import '../../services/google_services.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: CloudFireStoreService.cloudFireStoreService
            .readCurrentUserFromFireStore(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final userModel = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage('${userModel?.image}'),
                          radius: 35,
                        ),
                        GestureDetector(
                            onTap: () async {},
                            child: Padding(
                              padding: const EdgeInsets.only(left: 42, top: 35),
                              child: Icon(
                                CupertinoIcons.camera_fill,
                                color: Colors.black,
                                size: 20,
                              ),
                            )),
                      ],
                    ),
                    title: Text(
                      '   ${userModel?.name}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      '    ${userModel?.email}',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 25,
                  ),
                  SettingsTile(
                      icon: Icons.vpn_key,
                      title: 'Account',
                      subtitle: 'Security notifications, change number'),
                  SettingsTile(
                      icon: Icons.lock,
                      title: 'Privacy',
                      subtitle: 'Block contacts, disappearing messages'),
                  SettingsTile(
                      icon: Icons.icecream_outlined,
                      title: 'Theme',
                      subtitle: 'Light Theme,  Dark Theme'),
                  SettingsTile(
                      icon: Icons.favorite,
                      title: 'Favourites',
                      subtitle: 'Add, reorder, remove'),
                  SettingsTile(
                      icon: Icons.chat,
                      title: 'Chats',
                      subtitle: 'Theme, wallpapers, chat history'),
                  SettingsTile(
                      icon: Icons.notifications,
                      title: 'Notifications',
                      subtitle: 'Message, group & call tones'),
                  SettingsTile(
                      icon: Icons.data_usage,
                      title: 'Storage and data',
                      subtitle: 'Network usage, auto-download'),
                  SettingsTile(
                      icon: Icons.language,
                      title: 'App language',
                      subtitle: 'English (device\'s language)'),
                  InkWell(
                    onTap: () async {
                      // user
                      await setUserStatus(isOnline: false);
                      await AuthService.authService.singOutUser();
                      await GoogleAuthService.googleAuthService
                          .signOutFromGoogle();
                      // user = null
                      User? user = AuthService.authService.getCurrentUser();
                      if (user == null) {
                        Get.offAndToNamed('/signIn');
                      }
                    },
                    child: SettingsTile(
                        icon: Icons.logout,
                        title: 'Log out',
                        subtitle: 'Log out to your device'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

ListTile SettingsTile(
    {required IconData icon, required String title, required String subtitle}) {
  return ListTile(
    leading: Icon(icon, color: Colors.black),
    title: Text(
      title,
      style: TextStyle(fontSize: 18),
    ),
    subtitle: Text(subtitle),
  );
}
