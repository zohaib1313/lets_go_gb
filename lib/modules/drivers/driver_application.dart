import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/routes.dart';
import 'package:month_year_picker/month_year_picker.dart';

import 'driverAppPages.dart';
import 'driver_splash_screen.dart';

class DriverApplication extends StatefulWidget {
  const DriverApplication({Key? key}) : super(key: key);

  @override
  _DriverApplicationState createState() => _DriverApplicationState();
}

class _DriverApplicationState extends State<DriverApplication>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 1080),
      builder: () => GetMaterialApp(
        getPages: driverAppPages(),
        localizationsDelegates: const [
          DefaultCupertinoLocalizations.delegate,
          DefaultMaterialLocalizations.delegate,
          MonthYearPickerLocalizations.delegate
        ],
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        home: const DriverSplashPage(),
      ),
    );
  }
}
