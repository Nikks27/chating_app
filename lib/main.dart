import 'package:chating_app/View/home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'View/home/authchek..dart';
import 'View/home/splashscreen.dart';
import 'View/sign_in.dart';
import 'View/sign_up.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/Auth', page: () => const AuthCheack()),
        GetPage(name: '/signIn', page: () => const SignIn()),
        GetPage(name: '/SignUp', page: () => const SignUp()),
        GetPage(name: '/home', page: () => const HomePage()),
      ],
    );
  }
}

