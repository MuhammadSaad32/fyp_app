import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ChatController extends GetxController{
  TextEditingController messageController= TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  sendMessage({required String groupId,required String otherUserId,required String otherUserName}) async {
    await getCurrentUserName();
    var timeStamp = DateTime.now().microsecondsSinceEpoch.toString();
    firestore.collection('chat').doc(groupId).collection('messages').doc(timeStamp).set({
      'message':messageController.text,
      'id':FirebaseAuth.instance.currentUser!.uid,
      'time':timeStamp,
      'name':currentUserName
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .collection("myUsers")
        .get()
        .then((value) {
      if (value.docs.contains(otherUserId)) {
        print("user is  available");
      } else {
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid.toString())
            .collection("myUsers")
            .doc(otherUserId)
            .set({
          'id': otherUserId,
          'message': messageController.text,
          'time':timeStamp,
          'name':otherUserName
        });
      }
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(otherUserId)
        .collection("myUsers")
        .get()
        .then((value) {
      if (value.docs
          .contains(FirebaseAuth.instance.currentUser!.uid.toString())) {
        print("user is  available");
      } else {
        //for (var element in value.docs) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(otherUserId)
            .collection("myUsers")
            .doc(FirebaseAuth.instance.currentUser!.uid.toString())
            .set({
          'id': FirebaseAuth.instance.currentUser!.uid.toString(),
          'message': messageController.text,
          'time': timeStamp,
          'name':currentUserName
        });
        // }
      }
    });
    messageController.clear();
  }
  var currentUserName='';
  getCurrentUserName() async {
    var data = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    currentUserName = data['first_name'] + data['last_name'].toString();
    Get.log("Current User Name is $currentUserName");
  }
  String formatTimestamp(DateTime timestamp) {
    return '${timestamp.hour}:${timestamp.minute} ${timestamp.hour > 11 ? 'PM' : 'AM'}';
  }


  void deleteMessage({required String groupId,required String messageId}) {
    firestore
        .collection('chat')
        .doc(groupId)
        .collection('messages')
        .doc(messageId)
        .delete();
  }

  Future<void> showDeleteDialog({required BuildContext context ,required String messageId,required String groupId}) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Message'),
          content: const Text('Are you sure you want to delete this message?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                deleteMessage(groupId:groupId,messageId: messageId);
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
