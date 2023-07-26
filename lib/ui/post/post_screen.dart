import 'package:flutter/material.dart';
import 'package:fyp_app_olx/ui/post/post_add_screen.dart';
import 'package:fyp_app_olx/utils/colors_utils.dart';
import 'package:fyp_app_olx/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:fyp_app_olx/widgets/custom_category.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text("Post Screen"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Please Select a Category',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            CustomCategory(
              title: 'Computer/Laptop & Accessories',
              icon: Icons.laptop,
              color: Colors.blue,
              onPressed: () {
                Get.to(()=>PostAddScreen(category: 'Computer/Laptop & Accessories',icon: Icons.laptop,));
                // Handle button press
              },
            ),
            CustomCategory(
              title: 'Mobile Phones',
              icon: Icons.phone_android,
              color: Colors.green,
              onPressed: () {
                Get.to(()=>PostAddScreen(category: 'Mobile Phones',icon: Icons.phone_android,));
              },
            ),
            CustomCategory(
              title: 'Home Appliances',
              icon: Icons.home,
              color: Colors.orange,
              onPressed: () {
                Get.to(()=>PostAddScreen(category: 'Home Appliances',icon: Icons.home,));
              },
            ),
            CustomCategory(
              title: 'Property',
              icon: Icons.home_outlined,
              color: Colors.purple,
              onPressed: () {
                Get.to(()=>PostAddScreen(category: 'Property',icon: Icons.home_outlined,));
              },
            ),
            CustomCategory(
              title: 'Cars',
              icon: Icons.directions_car,
              color: Colors.red,
              onPressed: () {
                Get.to(()=>PostAddScreen(category: 'Cars',icon: Icons.directions_car,));
              },
            ),
            CustomCategory(
              title: 'Bikes',
              icon: Icons.motorcycle,
              color: Colors.teal,
              onPressed: () {
                Get.to(()=>PostAddScreen(category: 'Bikes',icon: Icons.motorcycle,));
              },
            ),
            CustomCategory(
              title: 'Others',
              icon: Icons.widgets,
              color: Colors.brown,
              onPressed: () {
                Get.to(()=>PostAddScreen(category: 'Others',icon: Icons.widgets,));
              },
            ),
          ],
        ),
      ),
    );
  }
}
