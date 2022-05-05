import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';
import 'package:let_go_gb/modules/users/pages/user_blog_detail_page.dart';

import '../../admin/models/BlogsModel.dart';
import '../../drivers/common_widgets/home_screen_card.dart';
import '../../drivers/utils/firebase_paths.dart';
import '../controllers/user_view_all_blogs_controller.dart';

class UserViewAllBlogsPage extends GetView<UserViewAllBlogsController> {
  const UserViewAllBlogsPage({Key? key}) : super(key: key);
  static const id = '/UserViewAllBlogsPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: 'Places to visit', goBack: true),
      body: SafeArea(
        child: GetX<UserViewAllBlogsController>(
            initState: (state) {},
            builder: (context) {
              controller.temp.value;
              return Padding(
                padding: EdgeInsets.all(10.h),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(FirebasePathNodes.blogs)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapShot) {
                      if (snapShot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapShot.hasError) {
                        return const Center(
                          child: Text('An error occurred...'),
                        );
                      }
                      return ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: snapShot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          BlogModel blog = BlogModel.fromMap(data);
                          return InkWell(
                            onTap: () {
                              Get.toNamed(UserViewBlogDetailsPage.id,
                                  arguments: blog);
                            },
                            child: BlogViewItemCard(
                                name: blog.placeName ?? '-',
                                image: blog.placeImages![0]),
                          );
                        }).toList(),
                      );
                    }),
              );
            }),
      ),
    );
  }
}
