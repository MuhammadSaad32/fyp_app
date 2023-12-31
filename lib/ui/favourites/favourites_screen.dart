import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp_app_olx/data/controllers/home_controller.dart';
import 'package:fyp_app_olx/utils/colors_utils.dart';
import 'package:fyp_app_olx/utils/text_styles.dart';
import 'package:get/get.dart';
import '../../utils/size_config.dart';
import '../post/add_detail_screen.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text("Favourites"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getHeight(20),),
            Text(
              'Favourites*',
              style: kSize20BlackW700Text,
            ),
            SizedBox(
              width: double.infinity,
              height: getHeight(600),
              child: FutureBuilder<List<DocumentSnapshot>>(
                future: Get.find<HomeController>().getFavouritesAds(),
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
                              "Oops! There are no Favorites ads available at the moment.",
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
                    itemCount: myAds.length ?? 0,
                    itemBuilder: (context, index) {
                      final adData =
                      myAds[index].data() as Map<String, dynamic>;
                      final title = myAds[index]['title'];
                      final category = myAds[index]['category'];
                      final price = myAds[index]['price'];
                      final imageUrls =
                      adData['imageUrls'] as List<dynamic>?;
                      final imageUrl = (imageUrls != null && imageUrls.isNotEmpty)
                          ? imageUrls[0]
                          : '';

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => AdDetailsScreen(adData: adData));
                          },
                          child:Container(
                            height: getHeight(150),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: getWidth(100),
                                      height: getHeight(100),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(imageUrl),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: getWidth(20)),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            title ?? '',
                                            style: TextStyle(
                                              fontSize: getFont(18),
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: getHeight(5)),
                                          Text(
                                            category ?? '',
                                            style: TextStyle(
                                              fontSize: getFont(16),
                                              color: Colors.grey,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: getHeight(5)),
                                          Text(
                                            'Rs $price' ?? '',
                                            style: TextStyle(
                                              fontSize: getFont(18),
                                              fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
