// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/admin/controller/admin_view_all_blogs_controller.dart';
import 'package:let_go_gb/modules/admin/models/BlogsModel.dart';
import 'package:let_go_gb/modules/admin/pages/blogs_page/admin_add_new_blog_page.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/loading_widget.dart';
import 'package:let_go_gb/modules/drivers/utils/my_app_bar.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';

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
        body: GetX<AdminViewAllBlogsController>(initState: (state) {
          controller.searchController.clear();
          controller.searchController.addListener(() {
            controller.searchFromList();
          });
        }, builder: (cc) {
          return Stack(
            children: [
              StreamBuilder(
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
                      return Obx(() => Column(
                            children: [
                              myAppBar(goBack: false, actions: [
                                MyAnimSearchBar(
                                  width: context.width * 0.8,
                                  onSuffixTap: () {
                                    controller.searchController.clear();
                                  },
                                  closeSearchOnSuffixTap: true,
                                  textController: controller.searchController,
                                ),
                              ]),
                              Expanded(
                                child: controller.filteredItemList.isEmpty
                                    ? Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'No Blog Found',
                                              style: AppTextStyles
                                                  .textStyleBoldBodyMedium,
                                            ),
                                          ],
                                        ),
                                      )
                                    : GridView.builder(
                                        itemCount:
                                            controller.filteredItemList.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 6.0,
                                                mainAxisSpacing: 6.0),
                                        physics: const BouncingScrollPhysics(),
                                        controller: ScrollController(),
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              Get.toNamed(
                                                  AdminAddNewBlogPage.id,
                                                  arguments: controller
                                                      .filteredItemList[index]);
                                            },
                                            child: BlogViewItemCard(
                                              onDelete: () {
                                                controller.deleteItem(
                                                    model: controller
                                                            .filteredItemList[
                                                        index]);
                                              },
                                              name: controller
                                                      .filteredItemList[index]
                                                      .placeName ??
                                                  '',
                                              image: controller
                                                      .filteredItemList[index]
                                                      .placeImages?[0] ??
                                                  'https://cdn.pixabay.com/photo/2018/01/14/23/12/nature-3082832__480.jpg',
                                            ),
                                          );
                                        }),
                              ),
                            ],
                          ));
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'No Blog Found',
                              style: AppTextStyles.textStyleBoldBodyMedium,
                            ),
                          ],
                        ),
                      );
                    }
                  }),
              if (controller.isLoading.isTrue) LoadingWidget()
            ],
          );
        }));
  }
}
