import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  RxString userAddress = RxString('');
  TextEditingController searchController= TextEditingController();
  var searchTerm = ''.obs;
  void updateSearchTerm(String term) {
    searchTerm.value = term;
  }
  bool isSearching = false;
  void toggleSearch() {
      isSearching = !isSearching;
      update();
      searchController.clear();
    }
  List<String> categories = [
    'All',
    'Cats',
    'Dogs',
    'Doves',
    'Ducks',
    'Fertile Eggs',
    'Finches',
    'Fish',
    'Hens',
    'Horses',
    'LiveStocks',
    'Parrots',
    'PeaCocks',
    'Pet Food & Accessories',
    'Pigeons',
    'Rabbits',
    'Others'
  ];
  int selectedIndex = 0;
  final CollectionReference adsCollection = FirebaseFirestore.instance.collection('ads');
  final Map<String, bool> likedAds = {};
  List<Map<String, dynamic>> ads = [];
  List? storage = GetStorage().read('list');
/// Fetch All Ads
  Future<List<Map<String, dynamic>>> fetchAllAds() async {
    try {
      final adsCollection = FirebaseFirestore.instance.collection('ads');
      final adsSnapshot = await adsCollection.get();
      return adsSnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      Get.log('Error fetching ads: $e');
      return [];
    }
  }
/// Fetch Ads by Category
  Future<List<Map<String, dynamic>>> fetchAdsByCategory(String category) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await adsCollection.where('category', isEqualTo: category).get() as QuerySnapshot<Map<String, dynamic>>;
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      Get.log("Error fetching ads by category: $e");
      return [];
    }
  }
/// Search ads by title
  Future<List<Map<String, dynamic>>> searchAdsByTitle(String searchTerm) async {
    final adsRef = FirebaseFirestore.instance.collection('ads');
    final querySnapshot = await adsRef
        .where('title', isGreaterThanOrEqualTo: searchTerm)
        .get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  /// Add to Favourites
  void addToFavorites(Map<String, dynamic> adData) {
    String userId= FirebaseAuth.instance.currentUser!.uid;
    String adId = adData['adId'];
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(adId)
        .set(adData);
    likedAds[adId] = true;
    update();
  }
  /// Remove From Favourites
  void removeFromFavorites(Map<String, dynamic> adData) {
    String userId= FirebaseAuth.instance.currentUser!.uid;
    String adId = adData['adId'];
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(adId)
        .delete();

    // Update liked status in the Map
    likedAds[adId] = false;
    update();
  }

  bool isAdLiked(String adId) {
    return likedAds[adId] ?? false;
  }

  /// Display Favourite adds
  Future<List<DocumentSnapshot>> getFavouritesAds() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .get();
    return querySnapshot.docs;
  }
  /// current Address
  Future<void> getCurrentUserAddress() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // The user has denied the location permission. Prompt them to grant it again.
      await Geolocator.requestPermission();
      permission = await Geolocator.checkPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      // The user has permanently denied the location permission.
      userAddress.value = "Location permission permanently denied";
    } else if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
        if (placemarks.isNotEmpty) {
          Placemark placemark = placemarks.first;
          String address =
              "${placemark.subLocality ?? ''}, ${placemark.locality ??
              ''}, ${placemark.administrativeArea ?? ''}";
          userAddress.value = address;
        } else {
          userAddress.value = "Address not found";
        }
      } catch (e) {
        userAddress.value = "Error getting address: $e";
        print(e);
      }
    }
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentUserAddress();

}
}
