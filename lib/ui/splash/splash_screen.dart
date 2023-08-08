import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fyp_app_olx/data/controllers/auth_controller.dart';
import 'package:fyp_app_olx/services/get_services.dart';
import 'package:fyp_app_olx/ui/bottom_navigation/bottom_navigation_screen.dart';
import 'package:fyp_app_olx/utils/colors_utils.dart';
import 'package:fyp_app_olx/utils/images_utils.dart';
import 'package:get/get.dart';
import '../auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 CheckConnectionService checkConnectionService = CheckConnectionService();
  AuthController authController = Get.put(AuthController());
  @override
  void initState() {
    // Get.log("${GetStorage().read("accessToken")}");
    //authController.checkConnectionSplash();
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () {
      authController.checkUserSession();

    });
  }

  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);
    return Scaffold(
        backgroundColor: primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Image.asset(MyImgs.logo)),
          ],
        ));
  }
}
