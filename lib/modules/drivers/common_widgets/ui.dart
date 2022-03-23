// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Ui {
  /// Success Snackbar
  static GetSnackBar SuccessSnackBar(
      {String title = 'Success',
      String? message,
      double? maxWidth,
      int? seconds = 2}) {
    Get.log("[$title] $message");

    return GetSnackBar(
      titleText: Text(title.tr,
          style: Get.textTheme.headline6!.apply(color: Colors.white)),
      messageText: Text(message!,
          style: Get.textTheme.subtitle2!.apply(color: Colors.white)),
      snackPosition: SnackPosition.BOTTOM,
      maxWidth: maxWidth,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.green,
      icon:
          const Icon(Icons.check_circle_outline, size: 32, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      dismissDirection: DismissDirection.horizontal,
      duration: Duration(seconds: seconds!),
    );
  }

  /// Error Snackbar
  static GetSnackBar ErrorSnackBar(
      {String title = 'Error', String? message, double? maxWidth}) {
    Get.log("[$title] $message", isError: true);

    return GetSnackBar(
      titleText: Text(title.tr,
          style: Get.textTheme.headline6!.apply(color: Colors.white)),
      messageText: Text(message!,
          style: Get.textTheme.bodyText2!.apply(color: Colors.white)),
      snackPosition: SnackPosition.BOTTOM,
      maxWidth: maxWidth,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.redAccent,
      icon: const Icon(Icons.remove_circle_outline,
          size: 32, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }

  /// Alert Snackbar
  static GetSnackBar AlertSnackBar(
      {String title = 'Alert', String? message, double? maxWidth}) {
    Get.log("[$title] $message", isError: true);

    return GetSnackBar(
      titleText: Text(title.tr,
          style: Get.textTheme.headline6!
              .merge(const TextStyle(color: Colors.white))),
      messageText: Text(message!,
          style: Get.textTheme.caption!
              .merge(const TextStyle(color: Colors.white))),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      maxWidth: maxWidth,
      backgroundColor: Colors.blue,
      icon: const Icon(Icons.add_alert_outlined, size: 32, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }

  /// convert Hexa-color to Color
  static Color parseColor(String hexCode, {double? opacity}) {
    try {
      return Color(int.parse(hexCode.replaceAll("#", "0xFF")))
          .withOpacity(opacity ?? 1);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity ?? 1);
    }
  }
}
