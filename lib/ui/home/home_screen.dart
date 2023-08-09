import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp_app_olx/data/controllers/home_controller.dart';
import 'package:fyp_app_olx/utils/colors_utils.dart';
import 'package:fyp_app_olx/utils/size_config.dart';
import 'package:fyp_app_olx/utils/text_styles.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../utils/images_utils.dart';
import '../../widgets/custom_textField.dart';
import '../post/add_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: whiteColor,
      // body: GetBuilder<HomeController>(builder: (controller) {
      //   return Padding(
      //     padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
      //     child: Column(
      //       children: [
      //         SizedBox(
      //           height: getHeight(40),
      //         ),
      //         Container(
      //           height: getHeight(40),
      //           width: double.infinity,
      //           decoration: BoxDecoration(
      //               color: Colors.white,
      //               borderRadius: BorderRadius.circular(5)),
      //           child: Center(
      //               child: Text(
      //             "ABEK",
      //             style: kSize20BlackW700Text,
      //           )),
      //         ),
      //         SizedBox(
      //           height: getHeight(5),
      //         ),
      //         Obx(
      //           () => Container(
      //             height: getHeight(60),
      //             width: double.infinity,
      //             decoration: BoxDecoration(
      //                 color: primaryColor,
      //                 borderRadius: BorderRadius.circular(5)),
      //             child: Center(
      //                 child: Row(
      //               children: [
      //                 SizedBox(
      //                   width: getWidth(10),
      //                 ),
      //                 const Icon(
      //                   Icons.location_on_outlined,
      //                   color: whiteColor,
      //                 ),
      //                 SizedBox(
      //                   width: getWidth(20),
      //                 ),
      //                 SizedBox(
      //                     width: getWidth(200),
      //                     child: Text(
      //                       controller.userAddress.value.toString(),
      //                       style: kSize14WhiteW400Text,
      //                       overflow: TextOverflow.ellipsis,
      //                     )),
      //               ],
      //             )),
      //           ),
      //         ),
      //         SizedBox(
      //           height: getHeight(5),
      //         ),
      //           CustomTextField(
      //             keyboardType: TextInputType.text,
      //             length: 500,
      //             text: 'Search',
      //             onChanged: (value) {
      //               controller.updateSearchTerm(value);
      //             },
      //             //controller: controller.searchController,
      //           ),
      //
      //       ],
      //     ),
      //   );
      // }),
      body:GetBuilder<HomeController>(
        builder: (controller) {
          return SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 50,
                  floating: true,
                  pinned: true,
                  backgroundColor: Colors.white,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(MyImgs.logo),
                        Text(
                          "A BEK",
                          style: kSize20BlackW700Text,
                        ),
                        const Icon(Icons.search,color: Colors.white,)

                      ],
                    ),
                    centerTitle: true,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                    child: Column(
                      children: [
                        SizedBox(height: getHeight(5)),
                        Obx(
                              () => Container(
                            height: getHeight(60),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  SizedBox(width: getWidth(10)),
                                  const Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: getWidth(20)),
                                  SizedBox(
                                    width: getWidth(200),
                                    child: Text(
                                      controller.userAddress.value.toString(),
                                      style: kSize14WhiteW400Text,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        //SizedBox(height: getHeight(5)),
                        // CustomTextField(
                        //   keyboardType: TextInputType.text,
                        //   length: 500,
                        //   text: 'Search',
                        //   onChanged: (value) {
                        //     controller.updateSearchTerm(value);
                        //   },
                        //   controller: controller.searchController,
                        // ),
                        SizedBox(height: getHeight(10),),
                        controller.storage!=null?
                        CarouselSlider(
                          items: controller.storage!.map((imageUrl) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(imageUrl),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          options: CarouselOptions(
                            height: getHeight(100),
                            enableInfiniteScroll: true,
                            autoPlay: true,
                          ),
                        ):
                        FutureBuilder<QuerySnapshot>(
                          future: FirebaseFirestore.instance.collection('images').get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator(color: primaryColor,));
                            }
                            if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            }
                            final imageDocs = snapshot.data!.docs;
                            final imageUrls = imageDocs.map((doc) => doc['url'] as String).toList();
                            Get.log('imgurls length is ${imageUrls.length}');
                            GetStorage().write('list', imageUrls);
                            Get.log('imgurls index is ${imageUrls[0]}');
                            return CarouselSlider(
                              items: imageUrls.map((imageUrl) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(imageUrl),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                              options: CarouselOptions(
                                height: getHeight(100),
                                enableInfiniteScroll: true,
                                autoPlay: true,
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: getHeight(60),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.categories.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  controller.selectedIndex = index;
                                  if (controller.categories[index] == 'All') {
                                    await controller.fetchAllAds();
                                  } else {
                                    await controller
                                        .fetchAdsByCategory(controller.categories[index]);
                                  }
                                  controller.update();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: index == controller.selectedIndex
                                          ? primaryColor // Change the color of selected category to primaryColor
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    controller.categories[index],
                                    style: TextStyle(
                                        color: index == controller.selectedIndex
                                            ? whiteColor // Change the color of selected category to primaryColor
                                            : Colors.black,
                                        fontSize: getFont(16),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: getHeight(600),
                          child: FutureBuilder<List<Map<String, dynamic>>>(
                            future: controller.searchController.text.isEmpty
                                ? controller.selectedIndex == 0
                                ? controller.fetchAllAds()
                                : controller.fetchAdsByCategory(controller.categories[controller.selectedIndex])
                                : controller.searchAdsByTitle(controller.searchController.text),
                            builder: (context, adsSnapshot) {
                              if (adsSnapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator());
                              }
                              if (adsSnapshot.hasError) {
                                return Center(child: Text('Error: ${adsSnapshot.error}'));
                              }
                              final myAds = adsSnapshot.data;
                              if (myAds == null || myAds.isEmpty) {
                                return Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.sentiment_very_dissatisfied,
                                          color: Colors.grey,
                                          size: 48,
                                        ),
                                        SizedBox(height: getHeight(16)),
                                        Text(
                                          "No Ads",
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                        SizedBox(height: getHeight(8)),
                                        Text(
                                          "Oops! There are no Ads available at the moment.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              return SizedBox(
                                height: getHeight(600),
                                child: GridView.builder(
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8.0,
                                    mainAxisSpacing: 8.0,
                                  ),
                                  itemCount: myAds.length,
                                  itemBuilder: (context, index) {
                                    final adData = myAds[index];
                                    final title = adData['title'] ?? '';
                                    final category = adData['category'] ?? '';
                                    final price = adData['price'] ?? '';
                                    final imageUrls = adData['imageUrls'] as List<dynamic>?;
                                    final adId = adData['adId'];
                                    final isLiked = controller.isAdLiked(adId);
                                    final imageUrl =
                                    (imageUrls != null && imageUrls.isNotEmpty)
                                        ? imageUrls[0]
                                        : 'https://via.placeholder.com/150';

                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(() => AdDetailsScreen(adData: adData));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey, width: 1),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: getHeight(100), // Adjust the height for the image container
                                              width: double.infinity, // Full width
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  image: NetworkImage(imageUrl),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: getHeight(5)),
                                            Padding(
                                              padding:EdgeInsets.symmetric(horizontal: getWidth(10)),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: getWidth(90),
                                                    child: Text(
                                                      title,
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (isLiked) {
                                                        controller.removeFromFavorites(adData);
                                                      } else {
                                                        controller.addToFavorites(adData);
                                                      }
                                                    },
                                                    child: Icon(
                                                      isLiked ? Icons.favorite : Icons.favorite_border,
                                                      color: isLiked ? Colors.red : Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:EdgeInsets.symmetric(horizontal: getWidth(10)),
                                              child: Text(
                                                category,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(height: getHeight(5)),
                                            Padding(
                                              padding:EdgeInsets.symmetric(horizontal: getWidth(10)),
                                              child: Text(
                                                'Rs $price',
                                                style: TextStyle(
                                                  fontSize: getFont(16),
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryColor, // Replace with your primaryColor
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );


                            },
                          ),
                        ),
                        // The rest of your widgets...
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
