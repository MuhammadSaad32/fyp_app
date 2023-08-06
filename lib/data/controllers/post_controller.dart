import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:fyp_app_olx/data/controllers/home_controller.dart';
import 'package:fyp_app_olx/ui/bottom_navigation/bottom_navigation_screen.dart';
import 'package:fyp_app_olx/ui/home/home_screen.dart';
import 'package:fyp_app_olx/widgets/progress_bar.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../widgets/custom_toasts.dart';
class PostController extends GetxController {
  final FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  List<File> selectedImages = [];
  RxString selectedCity = 'Select City'.obs;
  void updateSelectedCity(String city) {
    selectedCity.value = city;
  }
  final List<String> cities = [
    'Karachi',
    'Lahore',
    'Islamabad',
    'Attock',
    'Bahawalpur',
    'Burewala',
    'Chakwal',
    'Chiniot',
    'Dera Ghazi Khan',
    'Faisalabad',
    'Gujar Khan',
    'Gujranwala',
    'Gujrat',
    'Jhang',
    'Jhelum',
    'Kasur',
    'Khanewal',
    'Kharian',
    'Lahore',
    'Mandi Bahauddin',
    'Mianwali',
    'Multan',
    'Murree',
    'Okara',
    'Rahim Yar Khan',
    'Rawalpindi',
    'Sadiqabad',
    'Sahiwal',
    'Sargodha',
    'Sheikhupura',
    'Sialkot',
    'Taxila',
    'Toba Tek Singh',
    'Badin',
    'Hyderabad',
    'Jacobabad',
    'Karachi',
    'Khairpur',
    'Kotri',
    'Larkana',
    'Mirpur Khas',
    'Nawabshah',
    'Sukkur',
    'Thatta',
    'Abbottabad',
    'Bannu',
    'Battagram',
    'Chitral',
    'Charsadda',
    'D.I.Khan',
    'Haripur',
    'Kohat',
    'Mansehra',
    'Mardan',
    'Nowshera',
    'Peshawar',
    'Swat',
    'Swabi',
    'Timergara',
    'Tank',
    'Chaman',
    'Gwadar',
    'Khuzdar',
    'Quetta',
    'Ziarat',
    'Bagh',
    'Bhimber',
    'Kotli',
    'Mirpur',
    'Muzaffarabad',
    'Rawalakot',
    'Gilgit',
    'Skardu',
  ];
  List<String> categoriesPets = [
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

  var selectedContainer = 'Male'.obs;
  TextEditingController priceController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  void selectContainer(selection) {
    selectedContainer.value = selection;
  }
  bool isLoading = false;
  final picker =ImagePicker();

  Future<void> pickImages() async {
    final pickedFiles = await picker.pickMultiImage();
    selectedImages
        .addAll(pickedFiles.map((file) => File(file.path)).toList());
    update();
  }


/// next Button Functionality
  nextButton({required String category}) async {
    if(selectedImages.isEmpty){
      CustomToast.failToast(msg: 'Please Upload Images');
    }
    else if(titleController.text.isEmpty){
      CustomToast.failToast(msg: 'Please Enter Title');
    }
    else if(selectedCity.value=='Select City'){
      CustomToast.failToast(msg: 'Please Select City');
    }
    else if(priceController.text.isEmpty){
      CustomToast.failToast(msg: 'Please Enter Price');
    }
    else if(descriptionController.text.isEmpty){
      CustomToast.failToast(msg: 'Please Enter Description');
    }
    else if (phoneController.text.isEmpty){
      CustomToast.failToast(msg: 'Please Enter Phone Number');
    }
    else {
      Get.dialog(ProgressBar(), barrierDismissible: false);
      update();
      List<String> imageUrls = [];
      await currentUser();
      try {
        for (var image in selectedImages) {
          final fileName = DateTime.now().millisecondsSinceEpoch.toString();
          final reference = storage.ref().child('images').child('$fileName.jpg');
          final uploadTask = reference.putFile(image);
          final snapshot = await uploadTask.whenComplete(() {});
          if (snapshot.state == firebase_storage.TaskState.success) {
            final downloadUrl = await reference.getDownloadURL();
            imageUrls.add(downloadUrl);
          }
        }
        Get.log("Image Url is $imageUrls");
        var uuid = const Uuid();
        var randomId = uuid.v4();
        await Get.find<HomeController>().getCurrentUserAddress();
        var address =Get.find<HomeController>().userAddress.value.toString();
        Get.log("Address is $address");
        final addDetails = {
          'price': priceController.text,
          'title': titleController.text,
          'description':descriptionController.text,
          'phoneNumber':phoneController.text,
          'category':category,
          'type':selectedContainer.value,
          'id': FirebaseAuth.instance.currentUser!.uid,
          'adId':randomId,
          'name':userName,
          'city':selectedCity.value,
          'address':address,
          'imageUrls': imageUrls,
        };
        Get.log("Data is $addDetails");

        CustomToast.successToast(msg: 'Data Added Successfully');
        Future.wait([
          fireStore
              .collection('ads')
              .add(addDetails)
        ]);
        Future.wait([
          fireStore
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('myAds')
              .add(addDetails)
        ]);
        Get.back();
        selectedImages = [];
        Get.off(()=>const BottomNavigationScreen());
      } catch (error) {
        Get.back();
        CustomToast.failToast(msg: 'Failed to add data');
      } finally {
        Get.back();
        update();
      }
    }

  }
  String userName='';
  /// Current user data
  currentUser() async {
    var data = await fireStore.collection('users').doc(auth.currentUser!.uid).get();
    userName = '${data['first_name']}${data['last_name']}';
    Get.log("user name is $userName");
  }
}