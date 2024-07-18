import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/colors.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messageKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackBar({
    required String title, 
    required String message, 
    Color? color
  }){
    return Get.snackbar(
      title, message,
      icon: const Icon(Icons.report_rounded, color: whiteColor),
      backgroundColor: color ?? secondColor,
      snackPosition: SnackPosition.TOP,
      colorText: whiteColor,
      margin: const EdgeInsets.all(20)
    );
  }

  static showDefaultDialog(String title) {
    return Get.defaultDialog(
      title: title,
      content: const Column(
        children: [
          CircularProgressIndicator(
            strokeWidth: 3,
            color: whiteColor,
          )
        ],
      ),
    );
  }
}
