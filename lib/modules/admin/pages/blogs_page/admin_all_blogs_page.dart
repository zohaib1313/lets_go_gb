// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/admin/controller/admin_view_all_blogs_controller.dart';
import 'package:let_go_gb/modules/admin/models/BlogsModel.dart';
import 'package:let_go_gb/modules/admin/pages/blogs_page/admin_add_new_blog_page.dart';

import '../../../drivers/common_widgets/home_screen_card.dart';
import '../../../drivers/utils/firebase_paths.dart';
import '../../../drivers/utils/styles.dart';

class AdminViewAllBlogsPage extends GetView<AdminViewAllBlogsController> {
  static const id = '/AdminAllBlogsPage';

  AdminViewAllBlogsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.alphaGrey,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: AppColor.greenColor,
          onPressed: () {
            Get.toNamed(AdminAddNewBlogPage.id);
          },
        ),
        body: GetX<AdminViewAllBlogsController>(
            initState: (state) {},
            builder: (cc) {
              controller.temp.value;
              return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(FirebasePathNodes.blogs)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text(
                        'Something went wrong',
                        style: AppTextStyles.textStyleBoldBodyMedium,
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.data != null) {
                      controller.filteredItemList.clear();

                      for (var document in snapshot.data!.docs) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        BlogModel model = BlogModel.fromMap(data);
                        controller.filteredItemList.add(model);
                      }
                      if (controller.allItemList.isEmpty) {
                        controller.allItemList
                            .addAll(controller.filteredItemList);
                      }
                      return Obx(() => ListView.builder(
                          itemCount: controller.filteredItemList.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Get.toNamed(AdminAddNewBlogPage.id,
                                    arguments:
                                        controller.filteredItemList[index]);
                              },
                              child: BlogViewItemCard(
                                name: controller
                                        .filteredItemList[index].placeName ??
                                    '',
                                btnText: "Explore",
                                height: context.height * 0.4,
                                image: controller.filteredItemList[index]
                                        .placeImages?[0] ??
                                    'https://cdn.pixabay.com/photo/2018/01/14/23/12/nature-3082832__480.jpg',
                              ),
                            );
                          }));
                    }
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'No Vehicle Found',
                            style: AppTextStyles.textStyleBoldBodyMedium,
                          ),
                        ],
                      ),
                    );
                  });
            }));
  }
}
