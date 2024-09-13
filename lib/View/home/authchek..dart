import 'package:flutter/material.dart';
import '../../services/auth_services.dart';
import '../sign_in.dart';
import 'home_page.dart';


class AuthCheack extends StatelessWidget {
  const AuthCheack({super.key});

  @override
  Widget build(BuildContext context) {
    return (AuthService.authService.getCurrentUser() == null)
        ? const SignIn()
        : const HomePage();
  }
}