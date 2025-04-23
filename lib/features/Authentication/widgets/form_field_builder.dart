import 'package:flutter/material.dart';

double smallBorderRadius=15;
Color iconsColor=Colors.white;
Color borderColor=Colors.white;
Widget formFieldBuilder({
  required String label,
  double? width,

  // required TextEditingController textEditingController,
  TextEditingController? textEditingController,
  IconData? prefixIcon,
  IconData? suffixIcon,
  VoidCallback? suffixIconClick,
  TextInputType? keyBoardType,
  bool enabled = true,
  // TextStyle labelTextStyle = textFormFieldTextStyle,
}) {
  return SizedBox(
  // width: width,
  child:Padding(
    padding: EdgeInsets.symmetric( vertical: 5), // Reduced outer padding
    child: TextFormField(
      controller: textEditingController,
      enabled: enabled,
      keyboardType: keyBoardType,
      // style: labelTextStyle,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(smallBorderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(smallBorderRadius),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12), // Adjusted padding
        label: Text(
          label,
          // style: labelTextStyle,
        ),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: iconsColor)
            : null,
        suffixIcon: suffixIcon != null
            ? IconButton(
          onPressed: suffixIconClick,
          icon: Icon(suffixIcon, color: iconsColor),
        )
            : null,
      ),
    ),
  ));

  }