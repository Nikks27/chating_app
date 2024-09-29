import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService._();

  static AuthService authService = AuthService._();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   Account Create
  Future<void> createAccountWithEmailAndPassword(
      String email, String password) async {
    print("Create > $email & $password");
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print("Error >> $e");
    }
  }

//  Login
  Future<String> signInwithEmailAndPassword(
      String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "success";
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> singOutUser() async {
    await _firebaseAuth.signOut();
  }

  User? getCurrentUser() {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      log("email:${user.email}");
    }
    return user;
  }
}

// Clear All Chat


// import 'dart:developer';
//
// import 'package:firebase_auth/firebase_auth.dart';
//
//
// class AuthService {
//   AuthService._();
//   static AuthService authService = AuthService._();
//
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//
//   // Account create
//   Future<void> createAcountWithEmailAndPassword(String email, String password) async {
//     await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
//   }
//
//   // Login - Sign in
//   Future<String> signInWithEmailAndPassword(String email, String password) async {
//     try {
//       await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
//       return "successfully";
//     } catch (e) {
//       return e.toString(); // Return the error as a string
//     }
//   }
//
//   // Sign out
//   Future<void> signOutUser() async {
//     await _firebaseAuth.signOut();
//   }
//
//   // Get current user
//   User? getCurrentUser() {
//     User? user = _firebaseAuth.currentUser;
//     if (user != null) {
//       // Log user email
//       log("email : ${user.email}");
//     }
//     // else {
//     //   // Log when user is null
//     //   log("No user is currently signed in.");
//     // }
//     return user;
//   }
// }
