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

    // _animationController = AnimationController(
      duration:  Duration(seconds: 2);
      // vsync: this,


    // _animation = CurvedAnimation(
    //   parent: _animationController,
    //   curve: Curves.easeInExpo,

    // _animationController.forward();

    Timer(
      const Duration(seconds: 2),
          () {
        Navigator.of(context).pushNamed('/Auth');
      },
    );
  }

  // @override
  // void dispose() {
  //   _animationController.dispose();
  //   super.dispose();
  // }

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