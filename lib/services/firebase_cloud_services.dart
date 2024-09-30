import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../modal/ChatModal.dart';
import '../modal/user_modal.dart';
import 'auth_services.dart';

class CloudFireStoreService {
  // collection :doc-set-update/add
  CloudFireStoreService._();

  static CloudFireStoreService cloudFireStoreService =
      CloudFireStoreService._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  void insertUserIntoFireStore(UserModel user) =>
      fireStore.collection("user").doc(user.email).set(user.toMap());

  // READ DATA FOR CURRENT USER - PROFILE

  Future<UserModel?> readCurrentUserFromFireStore() async {
    User? user = AuthService.authService.getCurrentUser();
    final userData =
        (await fireStore.collection("user").doc(user!.email).get()).data();
    if (userData != null) return UserModel.fromMap(userData);
    return null;
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

  // UPDATE Typing

  Future<void> updateTyping(String receiver, bool isTyping) async {
    String sender = AuthService.authService.getCurrentUser()!.email!;
    List doc = [sender, receiver];
    doc.sort;
    String docId = doc.join("_");
    final typingList = ((await fireStore.collection("chatroom").doc(docId).get())
        .data()?["typing"] as List?) ?? [];
    isTyping
        ? (typingList.contains(sender) ? typingList : typingList
      .add(sender))
        : typingList
      .remove(sender);
    await fireStore.collection("chatroom").doc(docId).set(
      {
        'typing': typingList
      },
    );
  }

  //Stream For Typing

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamTyping(String receiver) {
    String sender = AuthService.authService.getCurrentUser()!.email!;
    List doc = [sender, receiver];
    doc.sort;
    String docId = doc.join("_");
    return fireStore.collection("chatroom").doc(docId).snapshots();
  }

  //Stream For User Status

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUserStatus(String receiver) {
    return fireStore.collection("user").doc(receiver).snapshots();
  }

  // DELET MESSAGE

  Future<void> removeChat(String dcId, String receiver) async {
    String sender = AuthService.authService.getCurrentUser()!.email!;
    List doc = [sender, receiver];
    doc.sort;
    String docId = doc.join("_");
    await fireStore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .doc(dcId)
        .delete();
  }

  // Read MASSEGE

  Future<void> updateMessageReadStatus(String receiver, String dcId) async {
    String? sender = AuthService.authService.getCurrentUser()!.email;
    List<String> doc = [sender!, receiver];
    doc.sort();
    String docId = doc.join("_");

    await fireStore
        .collection('chatroom')
        .doc(docId)
        .collection('chat')
        .doc(dcId)
        .update({'isRead': true});
  }

  // Clear All Chat

  Future<void> clearChatHistory(String receiverEmail) async {
    try {
      String sender = AuthService.authService.getCurrentUser()!.email!;
      List doc = [sender, receiverEmail];
      doc.sort;
      String docId = doc.join("_");
      CollectionReference chatCollection = FirebaseFirestore.instance
          .collection('chatroom')
          .doc(docId)
          .collection('chat');
      QuerySnapshot querySnapshot = await chatCollection.get();
      WriteBatch batch = FirebaseFirestore.instance.batch();

      for (var doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
      print("All chat messages cleared successfully.");
    } catch (e) {
      print("Error clearing chat history: $e");
    }
  }
}
