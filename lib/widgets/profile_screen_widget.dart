import 'package:flutter/material.dart';

import '../utils/colors_utils.dart';
import '../utils/size_config.dart';
import '../utils/text_styles.dart';

class ProfileScreenWidget extends StatelessWidget {
  final String text;
  final String image;
  final Function() ontap;

  const ProfileScreenWidget({
    required this.text,
    required this.image,
    required this.ontap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: getHeight(60),
        decoration: const BoxDecoration(
          color: whiteColor,
          //  borderRadius: BorderRadius.circular(8)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                image,
                height: 22,
                width: 22,
                color: secondaryColor,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                text,
                style: kSize16BlackW400Text,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
