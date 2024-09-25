import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../modal/ChatModal.dart';
import '../modal/user_modal.dart';
import 'auth_services.dart';
import 'package:flutter/material.dart';

class CloudFireStoreService {
  // collection :doc-set-update/add
  CloudFireStoreService._();

  static CloudFireStoreService cloudFireStoreService =
      CloudFireStoreService._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  void insertUserIntoFireStore(UserModel user) {
    fireStore.collection("user").doc(user.email).set({
      'email': user.email,
      'name': user.name,
      'phone': user.phone,
      'image': user.image,
      'token': user.token,
      'isRead':user.isRead,
    });
  }

  // READ DATA FOR CURRENT USER - PROFILE

  Future<DocumentSnapshot<Map<String, dynamic>>>
      readCurrentUserFromFireStore() async {
    User? user = AuthService.authService.getCurrentUser();
    return await fireStore.collection("user").doc(user!.email).get();
  }

  // READ ALL USER FROM FIRE STORE

  Future<QuerySnapshot<Map<String, dynamic>>>
      readAllUserFromCloudFireStore() async {
    User? user = AuthService.authService.getCurrentUser();
    return await fireStore
        .collection("user")
        .where("email", isNotEqualTo: user!.email)
        .get();
  }

  // ADD CHAT IN FIRE STORE

  Future<void> addChatInFireStore(ChatModel chat) async {
    String? sender = chat.sender;
    String? receiver = chat.receiver;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("_");

    await fireStore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .add(chat.toMap(chat));
  }

  // READ CHAT FOR USER

  Stream<QuerySnapshot<Map<String, dynamic>>> readChatFromFireStore(
      String receiver) {
    String sender = AuthService.authService.getCurrentUser()!.email!;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("_");
    return fireStore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .orderBy("time", descending: false)
        .snapshots();
  }

  // UPDATE CHATE

  Future<void> updateChat(String receiver, String message, String dcId) async {
    String sender = AuthService.authService.getCurrentUser()!.email!;
    List doc = [sender, receiver];
    doc.sort;
    String docId = doc.join("_");
    await fireStore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .doc(dcId)
        .update(
      {'message': message},
    );
  }

  // DELET MESSAGE

  Future<void> removeChat(String dcId,String receiver)
  async {
    String sender= AuthService.authService.getCurrentUser()!.email!;
    List doc=[sender,receiver];
    doc.sort;
    String docId=doc.join("_");
    await fireStore.collection("chatroom").doc(docId).collection("chat").doc(dcId).delete();
  }

  // Read MASSEGE

  Future<void> updateMessageReadStatus(String receiver, String dcId) async {
    String? sender = AuthService.authService.getCurrentUser()!.email;
    List<String> doc = [sender!, receiver];
    doc.sort();
    String docId = doc.join("_");

    await fireStore.collection('chatroom').doc(docId).collection('chat')
        .doc(dcId).update({'isRead': true});
  }




}
