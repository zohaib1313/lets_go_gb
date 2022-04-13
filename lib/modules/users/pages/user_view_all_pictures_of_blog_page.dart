import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../drivers/utils/utils.dart';

class UserViewAllPicturesBlogPage extends StatelessWidget {
  const UserViewAllPicturesBlogPage({Key? key}) : super(key: key);
  static const id = '/UserViewAllPicturesBlog';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          myAppBar(title: 'Back', goBack: true, backGroundColor: Colors.white),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      "assets/images/bg4.png",
                      fit: BoxFit.fill,
                      height: 300.h,
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
