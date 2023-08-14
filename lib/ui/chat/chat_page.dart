import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_app_olx/data/controllers/chat_controller.dart';
import 'package:fyp_app_olx/utils/colors_utils.dart';
import 'package:fyp_app_olx/utils/text_utils.dart';
import 'package:get/get.dart';
import '../../utils/size_config.dart';
import '../../widgets/custom_toasts.dart';

class ChatPage extends StatelessWidget {
  final ChatController controller = Get.find();
  final String groupId;
  final String name;
  final String otherId;
  ChatPage({super.key, required this.groupId, required this.name, required this.otherId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(onTap:(){
          controller.getCurrentUserName();
        },child: Text(name)),
        backgroundColor: primaryColor,
      ),
      body:Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
        child: Column(
          children: [
            Flexible(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('chat')
                    .doc(groupId)
                    .collection('messages').orderBy('time')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.data?.docs.isEmpty ?? true) {
                    return const Center(
                      child: Text("No Messages Yet"),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final message = snapshot.data!.docs[index].get('message');
                        final userId = snapshot.data!.docs[index].get('id');
                        final time = snapshot.data!.docs[index].get('time');
                        return GestureDetector(
                          onLongPress: (){
                            controller.showDeleteDialog(messageId:time,context: context,groupId: groupId );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: getWidth(10), vertical: getHeight(10)),
                            child: Align(
                              alignment: userId == FirebaseAuth.instance.currentUser!.uid
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: getWidth(200),
                                  minHeight: getHeight(45),
                                  minWidth: getWidth(100),
                                ),
                                decoration: BoxDecoration(
                                  color: userId == FirebaseAuth.instance.currentUser!.uid
                                      ? primaryColor
                                      : blackColor,
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(0),
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Center(
                                    child: Text(
                                      message.toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: whiteColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      // textAlign: TextAlign.center
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Container(
              width: double.infinity,
              height: getHeight(60),
              decoration: BoxDecoration(
                color: whiteColor,
                border: Border.all(color: primaryColor)
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: TextField(
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Type your message...',
                          hintStyle: TextStyle(color: Colors.grey,decoration: TextDecoration.overline,wordSpacing: 3),
                        ),
                        controller: controller.messageController,
                        maxLines: null,
                        expands: true,
                        textAlign: TextAlign.justify,

                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                         if(controller.messageController.text.isNotEmpty){
                           controller.sendMessage(groupId:groupId,otherUserId: otherId,otherUserName:name);
                           controller.update();
                         }
                         else{
                           CustomToast.failToast(msg: 'Type Something');
                         }
                        },
                        child: const Icon(Icons.send))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
