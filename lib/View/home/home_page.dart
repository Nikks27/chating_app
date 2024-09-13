import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/auth_services.dart';
import '../../services/google_services.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
              onPressed: () async {
                await AuthService.authService.signOutUser();
                await GoogleAuthService.googleAuthService.signOutFromGoogle();
                User? user = AuthService.authService.getCurrentUser();
                if (user == null) {
                  Get.offAndToNamed('/signIn');
                }
              },
              icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
