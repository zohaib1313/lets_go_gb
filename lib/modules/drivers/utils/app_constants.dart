import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:let_go_gb/modules/drivers/utils/styles.dart';

class AppConstants {
  static final ltrPadding = EdgeInsets.symmetric(horizontal: 20.w);
}

class BookingStatus {
  static const confirmed = 'Confirmed';
  static const pending = 'Pending';
  static const cancelled = 'Cancelled';
  static const completed = 'Completed';

  static Color? getColor(String? status) {
    switch (status) {
      case confirmed:
        return AppColor.green;
      case pending:
        return AppColor.primaryBlueColor;
      case cancelled:
        return AppColor.redColor;
      case completed:
        return AppColor.orangeColor;

      default:
        AppColor.redColor;
    }
    return AppColor.redColor;
  }
}
