import 'package:cloud_firestore/cloud_firestore.dart';
import '../modal/user_modal.dart';

class CloudFireStoreService {
  CloudFireStoreService._();

  static CloudFireStoreService cloudFireStoreService =
  CloudFireStoreService._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  void insertUserIntoFireStore(UserModel user) {
    fireStore.collection("users").doc(user.email).set({
      'email': user.email,
      'name' :user.name,
      'token' : user.token,
      'image' : user.image
    });
  }
}