import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fyp_app_olx/data/controllers/post_controller.dart';
import 'package:fyp_app_olx/ui/chat/chat_home.dart';
import 'package:fyp_app_olx/ui/chat/chat_page.dart';
import 'package:fyp_app_olx/utils/colors_utils.dart';
import 'package:fyp_app_olx/utils/size_config.dart';
import 'package:fyp_app_olx/widgets/custom_button.dart';
import 'package:get/get.dart';
import '../../utils/text_styles.dart';

class AdDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> adData;

  const AdDetailsScreen({Key? key, required this.adData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final List<dynamic>? imageUrls = adData['imageUrls'] as List<dynamic>?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ad Details'),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Images*',
              style: kSize20BlackW700Text,
            ),
            SizedBox(
              height: getHeight(10),
            ),
            if (imageUrls != null && imageUrls.isNotEmpty)
              CarouselSlider(
                options: CarouselOptions(
                  height: getHeight(200),
                  enableInfiniteScroll: false,
                ),
                items: imageUrls
                    .map((imageUrl) =>
                        Image.network(imageUrl, fit: BoxFit.cover))
                    .toList(),
              ),
            SizedBox(height: getHeight(16)),
            FirebaseAuth.instance.currentUser!.uid == adData['id']
                ? const SizedBox.shrink()
                : Align(
              alignment: Alignment.centerRight,
                  child: CustomButton(
                      title: 'Chat',
                      width: getWidth(100),
                    function: (){
                      var groupId= (FirebaseAuth.instance.currentUser!.uid.hashCode + adData['id'].hashCode).toString();
                        Get.log("group id is $groupId");
                        var userName = '${adData['name']}';
                        Get.to(()=>ChatPage(name: userName,groupId: groupId,otherId:adData['id']));

                    },
                    ),
                ),
            SizedBox(height: getHeight(16)),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(
                  'Title*',
                  style: kSize20BlackW700Text,
                ),
                subtitle: Text(
                  adData['title'],
                  style: TextStyle(
                    fontSize: getFont(18),
                    fontWeight: FontWeight.w500,
                    color: hintText,
                  ),
                ),
              ),
            ),
            SizedBox(height: getHeight(16)),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(
                  'Category*',
                  style: kSize20BlackW700Text,
                ),
                subtitle: Text(
                  adData['category'],
                  style: TextStyle(
                    fontSize: getFont(18),
                    fontWeight: FontWeight.w500,
                    color: hintText,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(
                  'Description*',
                  style: kSize20BlackW700Text,
                ),
                subtitle: Text(
                  adData['description'],
                  style: TextStyle(
                    fontSize: getFont(18),
                    fontWeight: FontWeight.w500,
                    color: hintText,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(
                  'Price*',
                  style: kSize20BlackW700Text,
                ),
                subtitle: Text(
                  'RS ${adData['price']}',
                  style: TextStyle(
                    fontSize: getFont(18),
                    fontWeight: FontWeight.w500,
                    color: hintText,
                  ),
                ),
              ),
            ),
            SizedBox(height: getHeight(8)),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(
                  'Phone Number*',
                  style: kSize20BlackW700Text,
                ),
                subtitle: Text(
                  '${adData['phoneNumber']}',
                  style: TextStyle(
                    fontSize: getFont(18),
                    fontWeight: FontWeight.w500,
                    color: hintText,
                  ),
                ),
              ),
            ),
            SizedBox(height: getHeight(8)),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(
                  'Type*',
                  style: kSize20BlackW700Text,
                ),
                subtitle: Text(
                  '${adData['type']}',
                  style: TextStyle(
                    fontSize: getFont(18),
                    fontWeight: FontWeight.w500,
                    color: hintText,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
