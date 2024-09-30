import 'dart:async';

import 'package:chating_app/services/firebase_cloud_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  RxString receiverEmail = "".obs;
  RxString receiverName = "".obs;
  RxBool receiverOnline = false.obs;
  RxBool receiverTyping = false.obs;
  RxString receiverLastSeen = "".obs;
  TextEditingController txtMessage = TextEditingController();
  TextEditingController txtUpdateMessage = TextEditingController();

  void getReceiver(String email, String name, bool isOnline, int? lastSeen, bool isTyping) {
    receiverEmail.value = email;
    receiverName.value = name;
    receiverOnline.value = isOnline;
    receiverLastSeen.value = lastSeen != null ? DateTime.fromMillisecondsSinceEpoch(lastSeen).toString() : "";
    receiverTyping.value = isTyping;
  }

  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    String amPm = hour >= 12 ? 'PM' : 'AM';
    hour = hour % 12;
    hour = hour == 0 ? 12 : hour; // Convert 0 to 12 for 12-hour format

    String minuteStr = minute < 10
        ? '0$minute'
        : minute.toString(); // Add leading zero if needed
    return '$hour:$minuteStr $amPm';
  }
}
