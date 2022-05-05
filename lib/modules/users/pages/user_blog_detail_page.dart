import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/admin/models/BlogsModel.dart';
import 'package:let_go_gb/modules/drivers/utils/common_widgets.dart';
import 'package:let_go_gb/modules/drivers/utils/styles.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';
import 'package:let_go_gb/modules/users/pages/user_view_all_pictures_of_blog_page.dart';

import '../controllers/user_blog_detail_controller.dart';

class UserViewBlogDetailsPage extends GetView<UserBlogDetailController> {
  UserViewBlogDetailsPage({Key? key}) : super(key: key);
  static const id = '/UserViewBlogDetailsPage';
  final vSpace = SizedBox(height: 20.h);
  final hSpace = SizedBox(width: 80.w);
  BlogModel? blogModel = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetX<UserBlogDetailController>(
            initState: (state) {},
            builder: (contr) {
              controller.temp.value;
              return Stack(
                children: [
                  animatedBackGround(),
                  if (blogModel != null)
                    Padding(
                      padding: EdgeInsets.all(10.h),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            myAppBar(
                                title: 'Back',
                                goBack: true,
                                backGroundColor: Colors.transparent),
                            vSpace,
                            vSpace,
                            SizedBox(
                              height: 305.h,
                              child: RotatedBox(
                                  quarterTurns: -1,
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(UserViewAllPicturesBlogPage(
                                          blogModel: blogModel!));
                                    },
                                    child: ListWheelScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      offAxisFraction: 0.2,
                                      diameterRatio: 1.5,
                                      perspective: 0.005,
                                      clipBehavior: Clip.none,
                                      renderChildrenOutsideViewport: false,
                                      onSelectedItemChanged: (x) {},
                                      controller: controller.scrollController,
                                      children: List.generate(
                                        blogModel!.placeImages?.length ?? 0,
                                        (x) => x ==
                                                (blogModel!
                                                        .placeImages!.length -
                                                    1)
                                            ? RotatedBox(
                                                quarterTurns: 1,
                                                child: Container(
                                                  height: 300.h,
                                                  width: 400.h,
                                                  decoration: BoxDecoration(
                                                      color: AppColor.whiteColor
                                                          .withOpacity(0.9),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: Center(
                                                      child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "View All",
                                                        style: AppTextStyles
                                                            .textStyleBoldBodyMedium,
                                                      ),
                                                      hSpace,
                                                      const CircleAvatar(
                                                        backgroundColor:
                                                            AppColor.blackColor,
                                                        child: Icon(Icons
                                                            .arrow_forward),
                                                      )
                                                    ],
                                                  )),
                                                ),
                                              )
                                            : RotatedBox(
                                                quarterTurns: 1,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  child: NetworkPlainImage(
                                                    url: blogModel!
                                                        .placeImages![x],
                                                    height: 300.h,
                                                    width: 400.h,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                      ),
                                      itemExtent: 230,
                                    ),
                                  )),
                            ),
                            vSpace,
                            _buildChipsList(),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    blogModel!.placeName ?? "-",
                                    style: AppTextStyles
                                        .textStyleBoldSubTitleLarge,
                                  ),
                                ),
                              ],
                            ),
                            vSpace,
                            Text(
                              blogModel!.placeDescription ?? "-",
                              style: AppTextStyles.textStyleNormalBodyMedium,
                            ),
                            vSpace,
                          ],
                        ),
                      ),
                    ),
                ],
              );
            }),
      ),
    );
  }

  animatedBackGround() {
    return controller.motionController != null
        ? AnimatedBuilder(
            animation: controller.motionController!,
            builder: (context, child) {
              controller.scale = 1 + controller.motionController!.value;
              return Transform.scale(
                scale: controller.scale,
                child: Container(
                  // height: DynamicSize.height(0.80, context),
                  decoration: const BoxDecoration(
                    color: AppColor.whiteColor,
                    image: DecorationImage(
                      image: AssetImage('assets/images/bg3.png'),
                      opacity: 0.3,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            })
        : const IgnorePointer();
  }

  /* List<String>? chips = [
    "Lake",
    "Hiking",
    "Chair Lift",
    "Mountains",
    "Restaurant"
  ];*/

  Widget _buildChipsList() {
    var chips = blogModel!.placeFeatures;
    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          return Chip(
              backgroundColor: AppColor.green,
              label: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Text(
                  chips![i],
                  style: TextStyle(color: AppColor.whiteColor),
                ),
              ));
        },
        itemCount: chips?.length ?? 0,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 18,
          );
        },
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}
