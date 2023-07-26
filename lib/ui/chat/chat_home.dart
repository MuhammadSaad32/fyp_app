import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_app_olx/data/controllers/chat_controller.dart';
import 'package:fyp_app_olx/ui/chat/chat_page.dart';
import 'package:fyp_app_olx/utils/colors_utils.dart';
import 'package:get/get.dart';

import '../../utils/size_config.dart';

class ChatHomeScreen extends StatelessWidget {
  const ChatHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text("Chat"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth(10),vertical: getHeight(10)),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('myUsers')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error occurred: ${snapshot.error}"),
                  );
                } else if (snapshot.data?.docs.isEmpty ?? true) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.sentiment_very_dissatisfied,
                            color: Colors.grey,
                            size: 48,
                          ),
                          SizedBox(height: getHeight(16)),
                          Text(
                            "No Chats",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          SizedBox(height: getHeight(8)),
                          Text(
                            "Oops! There are no Chats available at the moment.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  final userData =
                      snapshot.data!.docs.first.data() as Map<String, dynamic>;
                  final userName = userData['name'] as String;
                  final userMessage = userData['message'] as String;
                  final timestampString = userData['time'] as String;
                  final timestampMicros = int.tryParse(
                      timestampString); // Parse the timestamp as microseconds
                  final timestampMillis = timestampMicros != null
                      ? timestampMicros ~/ 1000
                      : null; // Convert to milliseconds
                  if (timestampMillis != null) {
                    final timestamp =
                        DateTime.fromMillisecondsSinceEpoch(timestampMillis);
                    final formattedTime =
                        Get.find<ChatController>().formatTimestamp(timestamp);
                    return GestureDetector(
                      onTap: () async {
                        await Get.find<ChatController>().getCurrentUserName();
                        var groupId= (FirebaseAuth.instance.currentUser!.uid.hashCode + userData['id'].hashCode).toString();
                        Get.log("group id is $groupId");
                        Get.log("other user name ${userData['name']}");
                        Get.log("current user name ${Get.find<ChatController>().currentUserName}");
                        Get.to(()=>ChatPage(groupId: groupId, name: userData['name'], otherId: userData['id']));
                      },
                      child: Container(
                        // Customize container styling here
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: whiteColor, // Use your preferred color
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            // Customize circle avatar properties here
                            backgroundColor: Colors.blue, // Use your preferred color
                            child: Text(
                              userName[0],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            userName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(userMessage),
                          trailing: Text(formattedTime),
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Container(
                        // Custom container styling for "Invalid timestamp" message
                        padding: const EdgeInsets.all(16),
                        child: const Text(
                          "Invalid timestamp",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red, // Use your preferred color
                          ),
                        ),
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
