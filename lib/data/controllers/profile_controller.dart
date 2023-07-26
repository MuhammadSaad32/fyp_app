import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
class ProfileController extends GetxController{
  Future<DocumentSnapshot> getUserData() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return await FirebaseFirestore.instance.collection('users').doc(userId).get();
  }
  Future<List<DocumentSnapshot>> getMyAds() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('myAds')
        .get();
    return querySnapshot.docs;
  }
}