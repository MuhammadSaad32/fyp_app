import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/colors_utils.dart';
import '../utils/size_config.dart';
class CustomTextField extends StatefulWidget {
  final double? height;
  final double? width;
  final double? roundCorner;
  final Color? bordercolor;
  final Color? background;
  final String text;
  final TextAlign? textAlign;
  final int length;
  bool? centerHintText=false;
  final int? verticalPadding;
  final TextInputType keyboardType;
  final TextInputFormatter? inputFormatters;
  bool? Readonly = false;
  final Widget? icon;
  final suffixIcon;
  final preffixIcon;
  final InputBorder? border;
  final String? errorText;
  final FocusNode? focusNode;
  final String? suffixtext;
  final Color? hintColor;
  final Color? textColor;
  final Color? cursorColor;
  final int? maxlines;
  final Color? color;
  bool? obscureText;
  bool? enable;
  final AutovalidateMode? autovalidateMode;

  // final bool? isObscure;
  final Function(String)? onFieldSubmitted;

  TextEditingController? controller;
  FormFieldValidator<String>? validator;
  ValueChanged<String>? onChanged;

  CustomTextField({
    Key? key,
    this.height,
    this.enable,
    this.width,
    this.roundCorner,
    this.suffixIcon,
    this.preffixIcon,
    this.bordercolor,
    this.background,
    this.controller,
    this.centerHintText,
    this.textAlign,
    this.border,
    this.maxlines,
    required this.text,
    this.validator,
    this.onChanged,
    this.errorText,
    this.Readonly,
    this.focusNode,
    this.hintColor,
    this.icon,
    this.color,
    this.obscureText,
    this.suffixtext,
    required this.length,
    required this.keyboardType,
    this.inputFormatters,
    // this.isObscure,
    this.textColor,
    this.cursorColor,
    this.onFieldSubmitted,
    this.verticalPadding,
    this.autovalidateMode,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;

    return Container(
      height: widget.height ?? getHeight(60),
      width: widget.width ?? getWidth(374),
      decoration: BoxDecoration(
          color: widget.background ?? whiteColor,
          // borderRadius: BorderRadius.circular(widget.roundCorner ?? 48)
      ),
      child: TextFormField(
        // autovalidateMode: widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
        obscuringCharacter: '*',
        maxLength: widget.length,
        enabled: widget.enable,
        cursorHeight: 20,
        maxLines: widget.maxlines ?? 1,
        focusNode: widget.focusNode,
        // validator: widget.validator ??
        //         (value) {
        //       if (value == null || value.isEmpty) {
        //         return widget.errorText ?? 'Please enter some text';
        //       }
        //       return null;
        //     },
        style: TextStyle(
            color: widget.textColor ?? widget.textColor,
            fontSize: getFont(16),
            fontWeight: FontWeight.w400),
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        textAlign: widget.textAlign ?? TextAlign.start,
        onChanged: widget.onChanged,

        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: widget.cursorColor ?? primaryColor,
        inputFormatters: <TextInputFormatter>[widget.inputFormatters??FilteringTextInputFormatter.singleLineFormatter],
        textInputAction: TextInputAction.next,
        // readOnly: true,
        readOnly: widget.Readonly == true ? true : false,
        obscureText: widget.obscureText ?? false,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              horizontal: getWidth(10), vertical: getHeight(16)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              getHeight(8),
            ),
            borderSide: BorderSide(
              color: blackColor.withOpacity(0.6),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
          errorText: widget.errorText,

          counterText: "",
          // enabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(
          //     getHeight(8),
          //   ),
          //   // borderSide: BorderSide(
          //   //   color: MyColors.black.withOpacity(0.6),
          //   // ),
          // ),

          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(
          //     getHeight(8),
          //   ),
          //   // borderSide: BorderSide(
          //   //   color: MyColors.black,
          //   // ),
          // ),

          errorBorder: OutlineInputBorder(
            gapPadding: 22,
            borderRadius: widget.roundCorner == null
                ? BorderRadius.circular(getHeight(8))
                : BorderRadius.circular(widget.roundCorner!),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          hintText: widget.text,
          alignLabelWithHint: widget.centerHintText,
          // suffixIcon: suffixIcon,
          suffixIcon: (widget.suffixIcon != null)
              ? GestureDetector(
              onTap: () {
                setState(() {
                  widget.obscureText = !widget.obscureText!;
                });
              },
              child: Icon(
                widget.obscureText!
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: getHeight(20),
              ))
              : null,
          // errorText: widget.errorText,
          errorStyle: TextStyle(fontSize: 8),
          hintStyle: TextStyle(
              color: widget.hintColor ?? Colors.grey,
              fontWeight: FontWeight.normal,
              fontSize: getFont(14)),
          // contentPadding: EdgeInsets.only(left: 15, top: 9),
          prefixIcon: widget.icon != null
              ? Padding(
            padding: EdgeInsets.all(13),
            child: widget.icon,
          )
              : null,
          // errorStyle: TextStyle(fontSize: 0),
          suffixText: widget.suffixtext,
          //focusColor: blueList,
        ),
      ),
    );
  }
}
