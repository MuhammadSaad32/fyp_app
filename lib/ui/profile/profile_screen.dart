import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp_app_olx/data/controllers/auth_controller.dart';
import 'package:fyp_app_olx/ui/post/add_detail_screen.dart';
import 'package:fyp_app_olx/ui/profile/customer_support_screen.dart';
import 'package:fyp_app_olx/utils/size_config.dart';
import 'package:fyp_app_olx/widgets/profile_screen_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fyp_app_olx/data/controllers/profile_controller.dart';
import 'package:fyp_app_olx/utils/colors_utils.dart';

import '../../utils/images_utils.dart';
import '../../utils/text_styles.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text("Profile Screen"),
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: primaryColor,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                Get.find<AuthController>().logout();

              }
            },
            itemBuilder: (BuildContext context) => [
               PopupMenuItem<String>(
                value: 'logout',
                child: SizedBox(
                    height: getHeight(50),
                    width: getWidth(200),
                    child: Text('Logout',style: kSize20BlackW700Text,)),
              ),
            ],
          ),
        ],
      ),
      body: GetBuilder<ProfileController>(builder: (controller) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getWidth(1), vertical: getHeight(10)),
          child: Column(
            children: [
              Flexible(
                child: FutureBuilder<DocumentSnapshot>(
                  future: controller.getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }
                    final firstName = snapshot.data!['first_name'];
                    final lastName = snapshot.data!['last_name'];
                    final phoneNumber = snapshot.data!['phone'];
                    final userImage = snapshot.data!['image'];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: getHeight(20),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: getWidth(20)),
                            child: Column(
                              children: [
                                SizedBox(height: getHeight(20)),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getWidth(20)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: getHeight(20)),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(() => EditProfileScreen(
                                                firstName: firstName,
                                                lastName: lastName,
                                                userImage: userImage,
                                                phoneNumber: phoneNumber,
                                              ));
                                        },
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 40,
                                              backgroundImage:
                                                  NetworkImage(userImage ?? ''),
                                            ),
                                            SizedBox(width: getWidth(20)),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '$firstName $lastName' ??
                                                        '',
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height: getHeight(5)),
                                                  Text(
                                                    '$phoneNumber' ?? '',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Icon(
                                              Icons.edit,
                                              color: Colors.grey,
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Add other content here if needed...
                                    ],
                                  ),
                                )
                                // Add other content here if needed...
                              ],
                            ),
                          ),
                          SizedBox(
                            height: getHeight(20),
                          ),
                          Text(
                            'My Ads*',
                            style: kSize20BlackW700Text,
                          ),
                          SizedBox(
                            height: getHeight(20),
                          ),
                          Expanded(
                            child: FutureBuilder<List<DocumentSnapshot>>(
                              future: controller.getMyAds(),
                              builder: (context, adsSnapshot) {
                                if (adsSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (adsSnapshot.hasError) {
                                  return Center(
                                    child: Text('Error: ${adsSnapshot.error}'),
                                  );
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
                                return ListView.builder(
                                  itemCount: myAds.length,
                                  itemBuilder: (context, index) {
                                    final adData = myAds[index].data()
                                        as Map<String, dynamic>;
                                    final title = myAds[index]['title'];
                                    final category = myAds[index]['category'];
                                    final price = myAds[index]['price'];
                                    final imageUrls =
                                        adData['imageUrls'] as List<dynamic>?;
                                    final imageUrl = (imageUrls != null &&
                                            imageUrls.isNotEmpty)
                                        ? imageUrls[0]
                                        : '';

                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(() =>
                                              AdDetailsScreen(adData: adData));
                                        },
                                        child: Container(
                                          height: getHeight(150),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Card(
                                            elevation: 4,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: getWidth(100),
                                                    height: getHeight(100),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            imageUrl),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: getWidth(20)),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          title ?? '',
                                                          style: TextStyle(
                                                            fontSize:
                                                                getFont(18),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        SizedBox(
                                                            height:
                                                                getHeight(5)),
                                                        Text(
                                                          category ?? '',
                                                          style: TextStyle(
                                                            fontSize:
                                                                getFont(16),
                                                            color: Colors.grey,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        SizedBox(
                                                            height:
                                                                getHeight(5)),
                                                        Text(
                                                          'Rs $price' ?? '',
                                                          style: TextStyle(
                                                            fontSize:
                                                                getFont(18),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: primaryColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              ProfileScreenWidget(
                text: 'Customer Support',
                image: MyImgs.logo2,
                ontap: () {
                  Get.to(() => const CustomerSupportPage());
                },
              ),
              ProfileScreenWidget(
                text: 'Log Out',
                image: MyImgs.logo2,
                ontap: () {
                  Get.find<AuthController>().logout();
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
