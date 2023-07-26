import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CustomSnackBar {
  static successSnackBar({required String text, required String mess}) {
    Get.snackbar(text, mess,
        backgroundColor: Colors.green, snackPosition: SnackPosition.TOP,colorText: Colors.white);
  }
  static failSnackBar({required String text, required String mess}) {
    Get.snackbar(text, mess,
        backgroundColor: Colors.red, snackPosition: SnackPosition.TOP,colorText:Colors.white);
  }
}
