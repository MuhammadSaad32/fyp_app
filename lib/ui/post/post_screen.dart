import 'package:flutter/material.dart';
import 'package:fyp_app_olx/ui/post/post_add_screen.dart';
import 'package:fyp_app_olx/utils/colors_utils.dart';
import 'package:fyp_app_olx/utils/size_config.dart';
import 'package:get/get.dart';

import '../../data/controllers/post_controller.dart';
class PostScreen extends StatelessWidget {
  PostController controller = Get.find();
  PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text("Post"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth(5)),
        child: SizedBox(
          child: ListView.builder(
            itemCount: controller.categoriesPets.length,
            itemBuilder: (context, index) {
              final category = controller.categoriesPets[index];
              return GestureDetector(
                onTap: (){
                  Get.to(()=>PostAddScreen(category: category,));
                },
                child: ListTile(
                  title: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.transparent,
                      border: Border.all(color: blackColor)
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      category,
                      style: const TextStyle(
                        color: blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
