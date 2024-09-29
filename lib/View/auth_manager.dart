import 'package:chating_app/View/bottombar/Bottombar.dart';
import 'package:chating_app/View/sign_in.dart';
import 'package:chating_app/services/auth_services.dart';
import 'package:flutter/material.dart';

class AuthManager extends StatelessWidget {
  const AuthManager({super.key});

  @override
  Widget build(BuildContext context) {
    return (AuthService.authService.getCurrentUser() == null)
        ? SignIn()
        : NavigationMenu();
  }
}