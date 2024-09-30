import 'package:chating_app/modal/user_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';
import '../services/auth_services.dart';
import '../services/firebase_cloud_services.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Authcontroller());
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller.txtName,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Name'),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: controller.txtEmail,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Email'),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: controller.txtPhone,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Phone'),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: controller.txtPassword,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Password'),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: controller.txtConfirmPassword,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: ' Confirm Password'),
            ),
            SizedBox(
              height: 15,
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Allready Have A Acount? Sign In'),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (controller.txtPassword.text ==
                      controller.txtConfirmPassword.text) {
                    await AuthService.authService
                        .createAccountWithEmailAndPassword(
                            controller.txtEmail.text,
                            controller.txtPassword.text);

                    UserModel user = UserModel(
                        name: controller.txtName.text,
                        email: controller.txtEmail.text,
                        image: "https://pngtree.com/so/profile",
                        phone: controller.txtPhone.text,
                        token: "-------");
                    CloudFireStoreService.cloudFireStoreService
                        .insertUserIntoFireStore(user);
                    Get.back();

                    // controller clear
                    controller.txtEmail.clear();
                    controller.txtPassword.clear();
                    controller.txtName.clear();
                    controller.txtConfirmPassword.clear();
                  }
                },
                child: Text('Sign Up'))
          ],
        ),
      ),
    );
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../controller/auth_controller.dart';
// import '../modal/user_modal.dart';
// import '../services/auth_services.dart';
// import '../services/firebase_cloud_services.dart';
// import '../services/google_services.dart';
//
//
// class SignUp extends StatelessWidget {
//   const SignUp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var controller = Get.put(Authcontroller());
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('Sign Up',style: TextStyle(fontWeight: FontWeight.bold),),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.only(left: 20, right: 20, top: 110),
//           child: Column(
//             children: [
//               TextField(
//                 controller: controller.txtName,
//                 decoration: InputDecoration(
//                   hintStyle: TextStyle(color: Colors.grey),
//                   hintText: 'Name',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(6),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 22),
//               TextField(
//                 controller: controller.txtEmail,
//                 cursorColor: Colors.grey,
//                 decoration:  InputDecoration(
//                   hintStyle: TextStyle(color: Colors.grey),
//                   hintText: 'Email',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(6),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 22),
//               TextField(
//                 controller: controller.txtPassword,
//                 decoration: InputDecoration(
//                   hintStyle: TextStyle(color: Colors.grey),
//                   hintText: 'Password',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(6),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 22),
//               TextField(
//                 controller: controller.txtConfirmPassword,
//                 decoration: InputDecoration(
//                   hintStyle: TextStyle(color: Colors.grey),
//                   hintText: 'Confirm Password',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(6),
//                     ),
//                   ),
//                 ),
//               ),
//                SizedBox(height: 22),
//               GestureDetector(
//                 onTap: () {
//                   if (controller.txtPassword.text == controller.txtConfirmPassword.text) {
//                     AuthService.authService.createAccountWithEmailAndPassword(
//                         controller.txtEmail.text, controller.txtPassword.text);
//                     UserModel user = UserModel(
//                       name: controller.txtName.text,
//                       email: controller.txtEmail.text,
//                       image: "https://png.pngtree.com/png-clipart/20230927/original/pngtree-man-avatar-image-for-profile-png-image_13001882.png",
//                       token:  "---",
//                       // phone: controller.txtPhone,
//                     );
//                     CloudFireStoreService.cloudFireStoreService
//                         .insertUserIntoFireStore(user);
//                     Get.back();
//                     controller.txtEmail.clear();
//                     controller.txtName.clear();
//                     controller.txtPassword.clear();
//                     controller.txtConfirmPassword.clear();
//                   }
//                 },
//                 child: Container(
//                   height: 55,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(6),
//                     ),
//                     color: Color(0xff98a7cf),
//                   ),
//                   child: Center(
//                     child: Text(
//                       'Sign up',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//                SizedBox(height: 35),
//               Text(
//                 '- Or sign up with -',
//                 style: GoogleFonts.exo(
//                   wordSpacing: -0.5,
//                   color: Colors.grey[500],
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//                SizedBox(height: 17),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   GestureDetector(
//                     onTap: () async {
//                       await GoogleAuthService.googleAuthService
//                           .signInWithGoogle();
//                       User? user = AuthService.authService.getCurrentUser();
//                       if (user != null) {
//                         Get.offAndToNamed('/home');
//                       }
//                     },
//                     child: Image.asset('assets/google.png', height: 40),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
