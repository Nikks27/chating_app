import 'dart:developer';
import 'package:chating_app/View/home/home_page.dart';
import 'package:chating_app/modal/ChatModal.dart';
import 'package:chating_app/services/Local_Notification_Services.dart';
import 'package:chating_app/services/auth_services.dart';
import 'package:chating_app/services/firebase_cloud_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global/global.dart';


class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chatController.receiverName.value),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch(value)
                  {
                    case 'Edit':log('Edit');
                    case "Wallpaper":log('Wallpaper');
                    case "Clear Chat":CloudFireStoreService.cloudFireStoreService.clearChatHistory(chatController.receiverEmail.value);
                    case "Block":log('Block');
                    case "Report":log('Report');
                  }
            },
            itemBuilder: (BuildContext context) {
              return [
                buildPopupMenuItem('Edit',),
                buildPopupMenuItem('Wallpaper',),
                buildPopupMenuItem('Clear Chat',),
                buildPopupMenuItem('Block',),
                buildPopupMenuItem('Report'),
              ];
            },
            icon: Icon(Icons.more_vert),),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder(
              stream: CloudFireStoreService.cloudFireStoreService
                  .readChatFromFireStore(chatController.receiverEmail.value),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString(),),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List data = snapshot.data!.docs;
                List<ChatModel> chatList = [];
                List<String> docIdList =[];
                for (QueryDocumentSnapshot snap in data) {
                  docIdList.add(snap.id);
                  chatList.add(ChatModel.fromMap(snap.data() as Map));
                }

                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: List.generate(
                      chatList.length,
                        (index) {
                          if (chatList[index].isRead == false &&
                              chatList[index].receiver == AuthService.authService.getCurrentUser()!.email) {
                           CloudFireStoreService.cloudFireStoreService.updateMessageReadStatus(
                                chatController.receiverEmail.value, docIdList[index]);
                          }
                        return GestureDetector(
                          onLongPress: () {
                            if(chatList[index].sender == AuthService.authService.getCurrentUser()!.email!)
                              {
                                chatController.txtUpdateMessage = TextEditingController(text: chatList[index].message);
                                showDialog(context: context, builder:(context) {
                                  return AlertDialog(
                                    title:Text("Update"),
                                    content: TextField(
                                      controller: chatController.txtUpdateMessage,
                                    ),
                                    actions: [
                                      TextButton(onPressed: () {
                                        String dcId = docIdList[index];
                                        CloudFireStoreService.cloudFireStoreService.updateChat(chatController.receiverEmail.value,chatController.txtUpdateMessage.text, dcId);
                                        Get.back();
                                      }, child: Text("Update"),),
                                    ],
                                  );

                                },

                                );
                              }
                          },
                          onDoubleTap: () {
                            CloudFireStoreService.cloudFireStoreService
                                .removeChat(docIdList[index],
                                chatController.receiverEmail.value);
                          },
                          child:
                          Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8, right: 14, left: 14),
                              child: Container(
                                alignment: (chatList[index].sender ==
                                    AuthService.authService
                                        .getCurrentUser()!
                                        .email!)
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: (chatList[index].sender ==
                                          AuthService.authService
                                              .getCurrentUser()!
                                              .email!)
                                          ? Colors.purple
                                          : Colors.blue.shade200,
                                      borderRadius: (chatList[index].sender ==
                                          AuthService.authService
                                              .getCurrentUser()!
                                              .email!)
                                          ? BorderRadius.only(
                                        topLeft: Radius.circular(13),
                                        bottomLeft: Radius.circular(13),
                                        bottomRight: Radius.circular(13),
                                      )
                                          : BorderRadius.only(
                                        topRight: Radius.circular(13),
                                        bottomLeft: Radius.circular(13),
                                        bottomRight: Radius.circular(13),
                                      ),
                                    ),
                                    child:Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          chatList[index].message!,
                                          style: TextStyle(
                                            color: chatList[index].sender ==
                                                AuthService.authService
                                                    .getCurrentUser()!
                                                    .email!
                                                ? Colors
                                                .white // Text color for sent messages
                                                : Colors.black,
                                            // Text color for received messages
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2,
                                          width: 9,
                                        ),
                                        Text(
                                          chatController.formatTimestamp(
                                              chatList[index].time),
                                          style: TextStyle(
                                            color: chatList[index].sender ==
                                                AuthService.authService
                                                    .getCurrentUser()!
                                                    .email!
                                                ? Colors
                                                .white // Time color for sent messages
                                                : Colors.grey.shade600,
                                            // Time color for received messages
                                            fontSize: 13, // Font size
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        if (chatList[index].isRead &&
                                            chatList[index].sender ==
                                                AuthService.authService
                                                    .getCurrentUser()!
                                                    .email!)
                                          Icon(
                                            Icons.done_all_rounded,
                                            // Read status icon
                                            color: Colors.blue.shade400,
                                            size: 18,
                                          ),
                                      ],
                                    ),),
                              )

                          ),
                          // Container(
                          //   margin: EdgeInsets.symmetric(
                          //     horizontal: 8,vertical: 2),
                          //   alignment: (chatList[index].sender == AuthService.authService.getCurrentUser()!.email!)?Alignment.centerRight:Alignment.centerLeft,
                          //   child: Text(chatList[index].message.toString(),),
                          //   ),
                        );}
                        ),
                    ),
                );
              },
            )),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: chatController.txtMessage,
                      decoration: InputDecoration(
                        hintText: 'Message',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () async {
                            ChatModel chat = ChatModel(
                                sender: AuthService.authService.getCurrentUser()!.email,
                                receiver: chatController.receiverEmail.value,
                                message: chatController.txtMessage.text,
                                time: Timestamp.now());

                            await CloudFireStoreService.cloudFireStoreService
                                .addChatInFireStore(chat);
                           await LocalNotificationService.localNotificationService.showNotification(AuthService.authService.getCurrentUser()!.email!,chatController.txtMessage.text);
                            chatController.txtMessage.clear();
                          },
                          icon: Icon(Icons.send),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 7,),
                  Container(
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                      shape:  BoxShape.circle,
                      color: Colors.grey.shade300,
                    ),
                    child: Icon(Icons.mic_outlined,size: 32,),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
