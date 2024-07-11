import 'package:flutter/material.dart';

const firstColor = Color(0xFFeab52b);
const secondColor = Color(0xFF484949);
const whiteColor = Color.fromARGB(255, 255, 255, 255);
const outlineGrayColor = Color(0xFFADB8C4);
const redColor = Color(0xFFEF4B3F);
const grayColor = Color(0xFF626360);
const grayLightColor = Color(0xFFB3B3B3);
const scaffoldColor = Color(0xFFF4F5F7);
const blueColor = Color(0xFF14333F);

extension ColorExtension on Color {
  String toCssString() {
    return '#${value.toRadixString(16).substring(2).toUpperCase()}';
  }
}