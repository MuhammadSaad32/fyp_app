import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp_app_olx/ui/auth/login_screen.dart';
import 'package:fyp_app_olx/ui/bottom_navigation/bottom_navigation_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../services/get_services.dart';
import '../../widgets/custom_toasts.dart';
import '../../widgets/progress_bar.dart';

class AuthController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final confirmPassword = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  GlobalKey<FormState> loginFormKey = GlobalKey();
  File? image;
  String? imageUrl;
  CheckConnectionService connectionService = CheckConnectionService();

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final FirebaseAuth auth = FirebaseAuth.instance;
  /// Pick Image
  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
        image = File(pickedImage.path);
    }
    update();
  }
  /// Upload Image
  Future<void> uploadImage() async {
    if (image == null) return;

    // Create a reference to the Firebase Storage bucket
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final reference = FirebaseStorage.instance.ref().child('images').child('$fileName.jpg');

    final uploadTask = reference.putFile(image!);
    final snapshot = await uploadTask.whenComplete(() {});
    // Get the download URL of the uploaded image
    if (snapshot.state == firebase_storage.TaskState.success) {
      final downloadUrl = await reference.getDownloadURL();
      imageUrl = downloadUrl;
      Get.log("Image Url is $imageUrl");
    }
      update();
  }
  ///Create account
  createAccountWithEmailAndPassword() async {
    if (passwordController.text == confirmPassword.text) {
      Get.dialog(ProgressBar(), barrierDismissible: false);
      connectionService.checkConnection().then((value) async {
        if (!value) {
          CustomToast.failToast(msg: "No Internet Connection".tr);
          Get.back();
        } else {
          try {
            await auth
                .createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            )
                .then((value) {
              CustomToast.successToast(msg: "Account created successfully!");
              Future.wait([
                addUserData(),
              ]);
              Get.back();
              Get.off(() => LoginScreen());
            }, onError: (error) {
              Get.back();
              if (error.toString().contains("SocketException")) {
                CustomToast.failToast(
                  msg: "Please check your internet!".tr,
                  // message
                );
              }
            });
          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              CustomToast.failToast(msg: "The password provided is too weak.");
            } else if (e.code == 'email-already-in-use') {
              CustomToast.failToast(msg: "email-already-in-use");
            }
            Get.back();
          } catch (e) {
            print(e);
          }
        }
      });
    } else {
      CustomToast.failToast(msg: "Both passwords should be same");
    }
  }

  ///add user data to firebase
  Future addUserData() {
    return users.doc(auth.currentUser!.uid).set({
      'first_name': firstNameController.text,
      'last_name': lastNameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'phone': phoneController.text,
      'image': imageUrl,
    }).then((value) {
      ///optional
    }).catchError(
        (error) => CustomToast.failToast(msg: "Failed to add user$error"));
  }

  ///Sign In
  signInWithEmailAndPassword() async {
    Get.dialog(ProgressBar(), barrierDismissible: false);
    connectionService.checkConnection().then((value) async {
      if (!value) {
        CustomToast.failToast(msg: "No Internet Connection".tr);
        Get.back();
      } else {
        try {
          await auth
              .signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text)
              .then((value) {
            Get.back();
            Get.offAll(() => const BottomNavigationScreen(),
                transition: Transition.rightToLeft);
            CustomToast.successToast(msg: "Login successfully!");
          }, onError: (error) {
            Get.back();
            if (error.toString().contains("SocketException")) {
              CustomToast.failToast(
                msg: "Please check your internet!".tr,
                // message
              );
            } else if (error.toString().contains(
                "The password is invalid or the user does not have a password")) {
              CustomToast.failToast(
                  msg: "Wrong password provided for that user.");
            } else if (error.toString().contains(
                "There is no user record corresponding to this identifier. The user may have been deleted.")) {
              CustomToast.failToast(msg: "No user found for that email.");
            }
          });
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            CustomToast.failToast(msg: "No user found for that email.");
          } else if (e.code == 'wrong-password') {
            CustomToast.failToast(
                msg: "Wrong password provided for that user.");
          }
          Get.back();
        } catch (e) {
          print("...............$e");
        }
      }
    });
  }

  ///check session
  void checkUserSession() {
    final User? user = auth.currentUser;

    if (user != null) {
      Get.offAll(() => const BottomNavigationScreen(),
          transition: Transition.rightToLeft);
    } else {
      Get.offAll(() => LoginScreen(), transition: Transition.rightToLeft);
    }
  }

  ///Logout
  void logout() async {
    Get.dialog(ProgressBar(), barrierDismissible: false);

    connectionService.checkConnection().then((value) async {
      if (!value) {
        CustomToast.failToast(msg: "No Internet Connection".tr);
        Get.back();
      } else {
        try {
          await auth.signOut().then((value) {
            Get.back();
            Get.offAll(() => LoginScreen(), transition: Transition.rightToLeft);
            // CustomToast.successToast(msg: "Logout successfully!");
          }, onError: (error) {
            Get.back();
            if (error.toString().contains("SocketException")) {
              CustomToast.failToast(msg: "Please check your internet!".tr);
            }
          });
        } catch (e) {
          print(e);
        }
      }
    });
  }
}
