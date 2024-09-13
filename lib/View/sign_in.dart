import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/auth_controller.dart';
import '../services/auth_services.dart';
import '../services/google_services.dart';
class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Log In',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 130),
          child: Column(
            children: [
              TextField(
                controller: controller.txtEmail,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(6),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 27,
              ),
              TextField(
                controller: controller.txtPassword,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(6),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 27,
              ),
              GestureDetector(
                onTap: () async {
                  String response = await AuthService.authService.signInWithEmailAndPassword(
                    controller.txtEmail.text,
                    controller.txtPassword.text,
                  );
                  User? user = AuthService.authService.getCurrentUser();
                  if(user!=null && response=="success")
                  {
                    Get.offAndToNamed('/home');
                  }
                  else
                  {
                    Get.snackbar('Sign In Failed', response);
                  }
                },
                child: Container(
                  height: 55,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(6),
                    ),
                    color: Color(0xff98a7cf,),
                  ),
                  child: const Center(
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 58,),
              Text(
                '- Or sign in with -',
                style: GoogleFonts.exo(
                  wordSpacing: -0.5,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await GoogleAuthService.googleAuthService.signInWithGoogle();
                      User? user = AuthService.authService.getCurrentUser();
                      if(user!=null)
                      {
                        Get.offAndToNamed('/home');
                      }
                    },
                    child: Image.asset(
                      'assets/google.png',
                      height: 40,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don`t have an account?',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/SignUp');
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        // color: Colors.blue,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}