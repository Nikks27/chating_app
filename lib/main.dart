import 'package:chating_app/View/auth_manager.dart';
import 'package:chating_app/View/home/chat_page.dart';
import 'package:chating_app/View/home/home_page.dart';
import 'package:chating_app/services/Local_Notification_Services.dart';
import 'package:chating_app/services/firebase_masseging_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'View/Call/Call_Page.dart';
import 'View/Profile/Profile_Page.dart';
import 'View/Status/Status.dart';
import 'View/bottombar/Bottombar.dart';
import 'View/sign_in.dart';
import 'View/sign_up.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest_all.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LocalNotificationService.localNotificationService
      .initNotificationService();
  tz.initializeTimeZones();
  await FirebaseMessagingService.fm.requestPermission();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => AuthManager()),
        GetPage(name: '/signIn', page: () => SignIn()),
        GetPage(name: '/signUp', page: () => SignUp()),
        GetPage(name: '/navigator', page: () => NavigationMenu()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/chat', page: () => ChatPage()),
        GetPage(name: '/status', page: () => StatusScreen()),
        GetPage(name: '/call', page: () => CallPage()),
        GetPage(name: '/profile', page: () => ProfilePage()),
        // GetPage(name: '/Auth', page: () =>  AuthCheack()),
        // GetPage(name: '/signIn', page: () =>  SignIn()),
        // GetPage(name: '/SignUp', page: () =>  SignUp()),
        // GetPage(name: '/home', page: () =>  HomeScreen()),
      ],
    );
  }
}
