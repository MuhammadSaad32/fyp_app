import 'package:flutter/material.dart';

class TextUtils {
  static Text txt({
    required String data,
    required double fontSize,
    FontWeight? fontWeight,
    Color? fontColor,
    TextAlign? textAlign,
  }) {
    return Text(
      textAlign: textAlign,
      data,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: fontColor,
        //fontFamily: Constants.fontFamily
      ),
    );
  }
}
