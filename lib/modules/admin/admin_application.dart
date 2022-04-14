import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/admin/admin_splash_screen.dart';
import 'package:let_go_gb/routes.dart';

import 'admin_app_pages.dart';

class AdminApplication extends StatefulWidget {
  const AdminApplication({Key? key}) : super(key: key);

  @override
  _AdminApplicationState createState() => _AdminApplicationState();
}

class _AdminApplicationState extends State<AdminApplication>
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
      builder: (_) => GetMaterialApp(
        getPages: adminAppPages(),
        scrollBehavior: MyScrollBehavior(),
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        home: const AdminSplashScreen(),
      ),
    );
  }
}

class MyScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.invertedStylus,
      };
}
