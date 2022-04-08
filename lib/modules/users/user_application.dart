import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/users/user_app_pages.dart';
import 'package:let_go_gb/modules/users/user_splash_screen.dart';
import 'package:let_go_gb/routes.dart';

class UserApplication extends StatefulWidget {
  const UserApplication({Key? key}) : super(key: key);

  @override
  _UserApplicationState createState() => _UserApplicationState();
}

class _UserApplicationState extends State<UserApplication>
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
        getPages: userAppPages(),
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        home: const UserSplashScreen(),
      ),
    );
  }
}
