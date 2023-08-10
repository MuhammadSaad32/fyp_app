import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp_app_olx/widgets/custom_toasts.dart';
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

  Future<void> deleteAd(BuildContext context, String adId, String userId) async {
    bool confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this ad?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _deleteDocumentFromCollection('ads', 'adId', adId);
      await _deleteDocumentFromSubcollection('users', userId, 'myAds',adId);
      await _deleteFromUserFavorites(userId, adId);

      // Show a success message
      CustomToast.successToast(msg: 'Ad Deleted Successfully');
    }
  }

  Future<void> _deleteDocumentFromCollection(
      String collectionName, String fieldName, String fieldValue) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(collectionName)
        .where(fieldName, isEqualTo: fieldValue)
        .get();

    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      await docSnapshot.reference.delete();
    }
  }

  Future<void> _deleteDocumentFromSubcollection(
      String parentCollection, String parentId,
      String subcollectionName,String fieldValue,) async {
    QuerySnapshot querySnapshot= await FirebaseFirestore.instance
        .collection(parentCollection)
        .doc(parentId)
        .collection(subcollectionName)
        .where('adId', isEqualTo: fieldValue)
        .get();
    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      await docSnapshot.reference.delete();
    }
  }

  Future<void> _deleteFromUserFavorites(String userId, String adId) async {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(adId)
        .get();

    if (userSnapshot.exists) {
      // If the document exists, delete it
      await userSnapshot.reference.delete();
    }
  }

}