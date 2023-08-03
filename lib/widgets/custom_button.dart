import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors_utils.dart';
import '../utils/size_config.dart';
import '../utils/text_utils.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? function;
  final String title;
  final double? height;
  final double? width;
  final Color? buttonTextColor;
  final Color? containerColor;
  final Color?borderColor;

  const CustomButton(
      {super.key,
        this.function,
        this.buttonTextColor,
        this.containerColor,
        this.borderColor,
        required this.title,
        this.width,
        this.height});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: function,
      child: Container(
        width: width?? double.infinity,
        //width: MediaQuery.of(context).size.width * 0.335,
        height: height??getHeight(60),
        decoration: BoxDecoration(
            border: Border.all(color: borderColor ?? Colors.transparent),
            color: containerColor??primaryColor, borderRadius: BorderRadius.circular(30)),
        child: Center(
          child:
          TextUtils.txt(
              data: title,
              fontSize: 16,
              fontColor: buttonTextColor ?? whiteColor,
              fontWeight: FontWeight.w400,
              //textAlign: TextAlign.center
          ),
          // Text(
          //   title,
          //   style: TextStyle(
          //     fontSize: getFont(16),
          //       fontFamily: 'SFDisplay',
          //       fontWeight: FontWeight.w700, color: buttonTextColor ?? MyColors.white),
          // ),
        ),
      ),
    );
  }
}
