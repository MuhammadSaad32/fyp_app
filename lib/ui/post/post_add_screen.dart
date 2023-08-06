import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp_app_olx/data/controllers/post_controller.dart';
import 'package:fyp_app_olx/utils/text_styles.dart';
import 'package:get/get.dart';
import '../../utils/colors_utils.dart';
import '../../utils/size_config.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textField.dart';

class PostAddScreen extends StatelessWidget {
  final String category;
  PostAddScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Add"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: GetBuilder<PostController>(builder: (ctr) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getHeight(20)),
                ctr.selectedImages.isEmpty
                    ? Container(
                        height: getHeight(150),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: IconButton(
                            onPressed: () {
                              ctr.pickImages();
                            },
                            icon: const Icon(
                              Icons.add,
                              color: whiteColor,
                              size: 30,
                            )),
                      )
                    : CarouselSlider(
                        items: ctr.selectedImages.map((image) {
                          return Image.file(image);
                        }).toList(),
                        options: CarouselOptions(
                          height: getHeight(150),
                          enableInfiniteScroll: false,
                        ),
                      ),
                SizedBox(height: getHeight(10)),
                CustomButton(
                  title: 'Add Images',
                  function: () {
                    ctr.pickImages();
                  },
                ),
                SizedBox(
                  height: getHeight(10),
                ),
                Text(
                  'Category*',
                  style: kSize20BlackW700Text,
                ),
                SizedBox(
                  height: getHeight(10),
                ),
                Container(
                  height: getHeight(100),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const CircleAvatar(
                            radius: 25,
                            backgroundColor: whiteColor,
                            child: Icon(
                              Icons.person,
                              color: blackColor,
                            )),
                        SizedBox(
                          width: getWidth(10),
                        ),
                        Text(
                          category,
                          style: kSize16W700Text,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(10),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        ctr.selectContainer('Male');
                      },
                      child: Obx(() => Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ctr.selectedContainer.value == 'Male'
                                  ? primaryColor // Primary color when tapped
                                  : blackColor,
                            ), // Color black when not tapped
                            child: const Text('Male',
                                style: TextStyle(color: Colors.white)),
                          )),
                    ),
                    SizedBox(
                      width: getWidth(10),
                    ),
                    InkWell(
                      onTap: () {
                        ctr.selectContainer('Female');
                      },
                      child: Obx(() => Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ctr.selectedContainer.value == 'Female'
                                  ? primaryColor // Primary color when tapped
                                  : blackColor,
                            ),
                            // Color black when not tapped
                            child: const Text('Female',
                                style: TextStyle(color: Colors.white)),
                          )),
                    ),
                    SizedBox(
                      width: getWidth(10),
                    ),
                    InkWell(
                      onTap: () {
                        ctr.selectContainer('Pair');
                      },
                      child: Obx(() => Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ctr.selectedContainer.value == 'Pair'
                              ? primaryColor // Primary color when tapped
                              : blackColor,
                        ),
                        // Color black when not tapped
                        child: const Text('Pair',
                            style: TextStyle(color: Colors.white)),
                      )),
                    ),
                  ],
                ),
                SizedBox(height: getHeight(10),),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 200, // Adjust the height as needed
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: ctr.cities.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(ctr.cities[index]),
                                      onTap: () {
                                        ctr.updateSelectedCity(
                                            ctr.cities[index]);
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: getHeight(60),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color:primaryColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Obx(
                          () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ctr.selectedCity.value,
                            style: kSize16BlackW400Text,
                          ),
                          const Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(10),
                ),
                Text(
                  'Price*',
                  style: kSize20BlackW700Text,
                ),
                SizedBox(
                  height: getHeight(10),
                ),
                CustomTextField(
                  text: 'Price',
                  controller: ctr.priceController,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  keyboardType: TextInputType.number,
                  length: 6,
                ),
                SizedBox(
                  height: getHeight(10),
                ),
                Text(
                  'Add Title*',
                  style: kSize20BlackW700Text,
                ),
                SizedBox(
                  height: getHeight(10),
                ),
                CustomTextField(
                  text: 'Title',
                  controller: ctr.titleController,
                  // inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
                  keyboardType: TextInputType.multiline,
                  maxlines: null,
                  length: 100,
                ),
                SizedBox(
                  height: getHeight(10),
                ),
                Text(
                  'Description*',
                  style: kSize20BlackW700Text,
                ),
                SizedBox(
                  height: getHeight(10),
                ),
                CustomTextField(
                  text: 'Describe What You are Selling',
                  // inputFormatters:
                  // FilteringTextInputFormatter.singleLineFormatter,
                  keyboardType: TextInputType.text,
                  maxlines: null,
                  controller: ctr.descriptionController,
                  length: 10000,
                ),
                SizedBox(
                  height: getHeight(10),
                ),
                Text(
                  'Phone Number*',
                  style: kSize20BlackW700Text,
                ),
                SizedBox(
                  height: getHeight(10),
                ),
                CustomTextField(
                  text: 'Phone Number',
                  controller: ctr.phoneController,
                  keyboardType: TextInputType.number,
                  maxlines: null,
                  length: 11,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Note we use this phone Number for Call',
                    style: kSize12blackW500Text,
                  ),
                ),
                SizedBox(
                  height: getHeight(10),
                ),
                CustomButton(
                  title: 'Next',
                  function: () {
                    Get.log("Selected Container is ${ctr.selectedContainer.value}");
                    Get.log("Selected City is ${ctr.selectedCity.value}");
                    ctr.nextButton(category: category);
                  },
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
