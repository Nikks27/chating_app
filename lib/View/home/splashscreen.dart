import 'dart:async';

import 'package:flutter/material.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
      duration:  Duration(seconds: 2);

    Timer(
       Duration(seconds: 2),
          () {
        Navigator.of(context).pushNamed('/Auth');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xff19277f),
      body: Center(
        child: Image.asset(
          'assets/chat-app-logo-design-template-can-be-used-icon-chat-application-logo_605910-1724.avif',
          color: Colors.white,
        ),
      ),
    );
  }
}