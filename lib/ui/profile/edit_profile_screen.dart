import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_app_olx/ui/bottom_navigation/bottom_navigation_screen.dart';
import 'package:fyp_app_olx/utils/colors_utils.dart';
import 'package:fyp_app_olx/utils/size_config.dart';
import 'package:fyp_app_olx/utils/toast_utils.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textField.dart';

class EditProfileScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String userImage;
  final String phoneNumber;

  const EditProfileScreen({super.key,
    required this.firstName,
    required this.lastName,
    required this.userImage,
    required this.phoneNumber,
  });

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  File? _selectedImage;
  String? _uploadedImageUrl;
  bool isImageUploading = false;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }
  void updateUserData() async {
    setState(() {
      isImageUploading = true;
    });

    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String phoneNumber = _phoneNumberController.text;
    String imageUrl;
    if (_selectedImage != null) {
      // Upload the image to Firebase Storage
      imageUrl = await _uploadImageToFirebaseStorage();
      Get.log("In if $imageUrl");
    } else {
      // Use the existing user image URL
      imageUrl = widget.userImage;
      Get.log("In else $imageUrl");

    }

    // Implement the update logic here, including the image URL
    // For example, using Firestore to update user data
    // Make sure to replace 'users' and 'currentUserId' with the appropriate collection and user ID in your Firestore database
    FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
      'first_name': firstName,
      'last_name': lastName,
      'phone': phoneNumber,
      'image': imageUrl,
    }).then((_) {
      setState(() {
        isImageUploading = false;
      });
      CustomSnackBar.successSnackBar(text: 'Success',mess:  'User data updated successfully!');
      Get.to(()=>const BottomNavigationScreen());
    }).catchError((error) {
      setState(() {
        isImageUploading = false;
      });
      Get.snackbar('Error', 'Failed to update user data: $error');
    });
  }
  Future<String> _uploadImageToFirebaseStorage() async {
    // Replace 'user_images' with the appropriate folder name in Firebase Storage
    String storageFolder = 'user_images';
    String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

    firebase_storage.Reference storageReference =
    firebase_storage.FirebaseStorage.instance.ref().child('$storageFolder/$fileName');

    try {
      // Upload the file to Firebase Storage
      await storageReference.putFile(_selectedImage!);

      // Get the download URL of the uploaded image
      String downloadURL = await storageReference.getDownloadURL();
      return downloadURL;
    } catch (error) {
      print('Error uploading image: $error');
      return '';
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the current user data
    _firstNameController.text = widget.firstName;
    _lastNameController.text = widget.lastName;
    _phoneNumberController.text = widget.phoneNumber;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // // Display the user's image
            // CircleAvatar(
            //   radius: 40,
            //   backgroundImage: NetworkImage(widget.userImage),
            // ),
            GestureDetector(
              onTap: () {
                // Handle the tap to select the user's image
                _pickImage();
              },
              child: isImageUploading
                  ? const CircularProgressIndicator() // Display progress indicator while uploading
                  : _selectedImage != null
                  ? CircleAvatar(
                radius: 40,
                backgroundImage: FileImage(_selectedImage!),
              )
                  : CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(widget.userImage),
              ),
            ),
            SizedBox(height: getHeight(20)),

            // Form fields for editing profile information
            CustomTextField(
              keyboardType: TextInputType.text,
              controller: _firstNameController,
              length: 50,
              text: 'First Name',
            ),
            SizedBox(height: getHeight(20)),
            CustomTextField(
              keyboardType: TextInputType.text,
              controller: _lastNameController,
              length: 50,
              text: 'Last Name',
            ),
            SizedBox(height: getHeight(20)),
            CustomTextField(
              keyboardType: TextInputType.phone,
              controller: _phoneNumberController,
              length: 11,
              text: 'Phone Number',
            ),
            SizedBox(height: getHeight(20)),
            CustomButton(
              function: () {
                Get.log('First Name: ${_firstNameController.text}');
                Get.log('Last Name: ${_lastNameController.text}');
                Get.log('Phone Number: ${_phoneNumberController.text}');
                updateUserData();
              },
              title: 'Update',
            ),
          ],
        ),
      ),
    );
  }
}
