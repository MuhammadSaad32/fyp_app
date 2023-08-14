// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../utils/colors_utils.dart';
// import '../../utils/size_config.dart';
// import 'full_image_screen.dart';
//
// class EditAdScreen extends StatelessWidget {
//   final Map<String, dynamic> adData;
//
//   const EditAdScreen({Key? key, required this.adData}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     final List<dynamic>? imageUrls = adData['imageUrls'] as List<dynamic>?;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Ad'),
//         backgroundColor: primaryColor,
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (imageUrls != null && imageUrls.isNotEmpty)
//               CarouselSlider(
//                 options: CarouselOptions(
//                   height: getHeight(200),
//                   enableInfiniteScroll: false,
//                 ),
//                 items: imageUrls
//                     .map(
//                       (imageUrl) => GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               FullImageScreen(imageUrl: imageUrl),
//                         ),
//                       );
//                     },
//                     child: Hero(
//                       tag: 'fullImage',
//                       child: Image.network(imageUrl, fit: BoxFit.cover),
//                     ),
//                   ),
//                 )
//                     .toList(),
//               ),
//             SizedBox(height: getHeight(16)),
//             TextField(
//               controller: TextEditingController(text: adData['title']),
//               decoration: InputDecoration(
//                 labelText: 'Title*',
//               ),
//             ),
//             SizedBox(height: getHeight(16)),
//             TextField(
//               controller: TextEditingController(text: adData['category']),
//               decoration: InputDecoration(
//                 labelText: 'Category*',
//               ),
//             ),
//             SizedBox(height: getHeight(16)),
//             TextField(
//               controller: TextEditingController(text: adData['city']),
//               decoration: InputDecoration(
//                 labelText: 'City*',
//               ),
//             ),
//             SizedBox(height: getHeight(16)),
//             TextField(
//               controller: TextEditingController(text: adData['address']),
//               decoration: InputDecoration(
//                 labelText: 'Address*',
//               ),
//             ),
//             SizedBox(height: getHeight(16)),
//             TextField(
//               controller: TextEditingController(text: adData['description']),
//               decoration: InputDecoration(
//                 labelText: 'Description*',
//               ),
//             ),
//             SizedBox(height: getHeight(16)),
//             TextField(
//               controller: TextEditingController(text: adData['price'].toString()),
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: 'Price*',
//               ),
//             ),
//             SizedBox(height: getHeight(16)),
//             TextField(
//               controller: TextEditingController(text: adData['phoneNumber']),
//               keyboardType: TextInputType.phone,
//               decoration: InputDecoration(
//                 labelText: 'Phone Number*',
//               ),
//             ),
//             SizedBox(height: getHeight(16)),
//             TextField(
//               controller: TextEditingController(text: adData['type']),
//               decoration: InputDecoration(
//                 labelText: 'Type*',
//               ),
//             ),
//             SizedBox(height: getHeight(16)),
//             ElevatedButton(
//               onPressed: () {
//                 // Implement your update logic here
//                 // You can update the ad data in the database using the values from the text fields
//               },
//               child: Text('Update'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
