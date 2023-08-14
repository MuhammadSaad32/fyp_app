import 'package:flutter/material.dart';

import '../../utils/colors_utils.dart';

class FullImageScreen extends StatelessWidget {
  final String imageUrl;

  const FullImageScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Image'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Hero(
            tag: 'fullImage',
            child: Image.network(imageUrl),
          ),
        ),
      ),
    );
  }
}
