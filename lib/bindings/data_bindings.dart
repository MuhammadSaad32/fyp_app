import 'package:fyp_app_olx/data/controllers/chat_controller.dart';
import 'package:fyp_app_olx/data/controllers/home_controller.dart';
import 'package:fyp_app_olx/data/controllers/post_controller.dart';
import 'package:fyp_app_olx/data/controllers/profile_controller.dart';
import 'package:get/get.dart';

import '../data/controllers/auth_controller.dart';

class DataBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AuthController(),fenix: true);
    Get.lazyPut(() => PostController(),fenix: true);
    Get.lazyPut(() => ProfileController(),fenix: true);
    Get.lazyPut(() => HomeController(),fenix: true);
    Get.lazyPut(() => ChatController(),fenix: true);
  }

}

