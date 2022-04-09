import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../routes.dart';

class AppBottomSheets {
  //bool isDialogShowing = false;
  static final AppBottomSheets _singleton = AppBottomSheets._internal();

  factory AppBottomSheets() {
    return _singleton;
  }

  AppBottomSheets._internal();

  static showAppAlertBottomSheet(
      {isDismissable, Widget? child, BuildContext? context}) {
    //   isDialogShowing =true;
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      enableDrag: false,
      isDismissible: isDismissable ?? false,
      context: myContext!,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.h),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return child!;
      },
    ).then((value) {
      //  isDialogShowing = false;
    });
  }
}
