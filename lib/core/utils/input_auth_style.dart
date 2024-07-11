import 'package:flutter/material.dart';
import 'package:qcracks_mobile/core/theme/colors.dart';


import '../theme/fonts.dart';

InputDecoration inputAuthStyle(
    String? errorText, String label, IconData? prtefixIcon, Widget? suffixIcon) {
  return InputDecoration(
      prefixIcon: Icon(prtefixIcon),
      suffixIconColor:firstColor ,
      suffixIcon: suffixIcon,
      errorText: errorText,
      label: Text(label),
      hintText: label,
      errorMaxLines: 2,
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: outlineGrayColor, width: 0.5),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: outlineGrayColor, width: 0.5),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: outlineGrayColor, width: 0.5),
        borderRadius: BorderRadius.circular(10.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: outlineGrayColor, width: 0.5),
        borderRadius: BorderRadius.circular(10.0),
      ),
      errorStyle: const TextStyle(
        color: redColor,
        fontWeight: FontWeight.bold,
      ),
      hintStyle: textStyleInput(grayColor),
  );
}