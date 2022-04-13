// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/common/pages/notifications_page.dart';
import 'package:let_go_gb/modules/drivers/utils/firebase_paths.dart';
import 'package:let_go_gb/modules/drivers/utils/user_defaults.dart';
import 'package:let_go_gb/modules/users/models/user_model.dart';
import 'package:let_go_gb/modules/users/pages/user_blog_detail_page.dart';
import 'package:let_go_gb/modules/users/pages/user_signup_screen.dart';
import 'package:let_go_gb/modules/users/pages/user_view_all_blogs_page.dart';

import '../../drivers/common_widgets/home_screen_card.dart';
import '../../drivers/utils/app_popups.dart';
import '../../drivers/utils/common_widgets.dart';
import '../../drivers/utils/styles.dart';
import '../controllers/home_screen_driver_controller.dart';

class UserHomeScreen extends GetView<HomeScreenUserController> {
  static const id = '/UserHomeScreen';
  final vSpace = SizedBox(height: 20.h);

  UserHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await AppPopUps.showConfirmDialog(
          title: 'Confirm',
          message: 'Are you sure to exit from the app',
          onSubmit: () {
            Navigator.pop(context, true);
          },
        );
      },
      child: Scaffold(
          backgroundColor: AppColor.alphaGrey,
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.only(
                left: 50.w,
                right: 50.w,
              ),
              child: GetX<HomeScreenUserController>(
                  initState: (state) {},
                  builder: (context) {
                    return Stack(
                      children: [
                        animatedBackGround(),
                        Column(
                          children: [
                            StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection(FirebasePathNodes.users)
                                    .doc(UserDefaults.getCurrentUserId())
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<DocumentSnapshot> snapShot) {
                                  if (snapShot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: Text('Loading...'),
                                    );
                                  }
                                  if (snapShot.hasError) {
                                    return Center(
                                      child: Text('An error occurred...'),
                                    );
                                  }
                                  if (snapShot.data?.data() != null) {
                                    UserModel user = UserModel.fromMap(
                                        snapShot.data!.data()!
                                            as Map<String, dynamic>);
                                    UserDefaults.saveUserSession(user);
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Get.toNamed(
                                                      UserSignUpScreen.id,
                                                      arguments: UserDefaults
                                                          .getUserSession());
                                                },
                                                child: NetworkCircularImage(
                                                  url: user.profileImage ?? '',
                                                  radius: 18,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 50.w,
                                              ),
                                              Text(
                                                'Hi, ${user.firstName ?? ''}',
                                                style: AppTextStyles
                                                    .textStyleBoldBodyXSmall,
                                              )
                                            ],
                                          ),
                                          //notification icon
                                          myAppBarIcon(),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Center(
                                      child: Text('An error occurred...'),
                                    );
                                  }
                                }),
                            vSpace,
                            Expanded(
                                child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Available Rides For You",
                                        style: AppTextStyles
                                            .textStyleBoldTitleLarge
                                            .copyWith(
                                                color: AppColor.blackColor),
                                      ),
                                    ],
                                  ),
                                  vSpace,
                                  CarouselSlider(
                                    options: CarouselOptions(
                                        autoPlay: true,
                                        enlargeCenterPage: true),
                                    items: controller.imagesList(),
                                  ),

                                  vSpace,
                                  // Explore GB
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Explore GB",
                                        style: AppTextStyles
                                            .textStyleBoldTitleLarge
                                            .copyWith(
                                                color: AppColor.blackColor),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.toNamed(UserViewAllBlogsPage.id);
                                        },
                                        child: Text(
                                          "View all",
                                          style: AppTextStyles
                                              .textStyleBoldBodySmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                  vSpace,
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 150.h),
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: 5,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              Get.toNamed(
                                                  UserViewBlogDetailsPage.id);
                                            },
                                            child: HomeScreenCard(
                                              text: "Skardu Valley",
                                              btnText: "Explore",
                                              image: const AssetImage(
                                                  'assets/images/sceneone.jpg'),
                                            ),
                                          );
                                        }),
                                  )
                                ],
                              ),
                            ))
                            //explore / homeScreenCard widgets
                          ],
                        ),
                      ],
                    );
                  }),
            ),
          )),
    );
  }

  Widget myAppBarIcon() {
    return InkWell(
      onTap: () {
        Get.toNamed(NotificationsPage.id);
      },
      child: Obx(
        () => Center(
          child: CircleAvatar(
            backgroundColor: AppColor.primaryBlueColor.withAlpha(50),
            child: Stack(
              children: [
                const Icon(
                  Icons.notifications,
                  color: Colors.black,
                  size: 30,
                ),
                Visibility(
                  visible: controller.notificationsCounts.value > 0,
                  child: Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xffc32c37),
                          border: Border.all(color: Colors.white, width: 1)),
                      child: Center(
                        child: Text(
                          controller.notificationsCounts.value.toString(),
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
                      image: AssetImage('assets/images/bg4.png'),
                      opacity: 0.3,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            })
        : const IgnorePointer();
  }
}
