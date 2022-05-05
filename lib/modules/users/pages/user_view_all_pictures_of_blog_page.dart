import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:let_go_gb/modules/admin/models/BlogsModel.dart';
import 'package:let_go_gb/modules/drivers/utils/common_widgets.dart';

import '../../drivers/utils/utils.dart';

class UserViewAllPicturesBlogPage extends StatelessWidget {
  static const id = '/UserViewAllPicturesBlog';
  BlogModel blogModel;

  UserViewAllPicturesBlogPage({Key? key, required this.blogModel})
      : super(key: key);

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
              itemCount: blogModel.placeImages?.length ?? 0,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: NetworkPlainImage(
                      url: blogModel.placeImages![index],
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
