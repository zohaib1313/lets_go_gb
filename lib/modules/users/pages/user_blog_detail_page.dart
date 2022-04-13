import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/utils/styles.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';
import 'package:let_go_gb/modules/users/pages/user_view_all_pictures_of_blog_page.dart';

import '../controllers/user_blog_detail_controller.dart';

class UserViewBlogDetailsPage extends GetView<UserBlogDetailController> {
  UserViewBlogDetailsPage({Key? key}) : super(key: key);
  static const id = '/UserViewBlogDetailsPage';
  final vSpace = SizedBox(height: 20.h);
  final hSpace = SizedBox(width: 80.w);

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
                                    Get.to(const UserViewAllPicturesBlogPage());
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
                                      10,
                                      (x) => x == 9
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
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
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
                                                      child: Icon(
                                                          Icons.arrow_forward),
                                                    )
                                                  ],
                                                )),
                                              ),
                                            )
                                          : RotatedBox(
                                              quarterTurns: 1,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                child: Image.asset(
                                                  "assets/images/sceneone.jpg",
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
                                  "Skardu Valley",
                                  style:
                                      AppTextStyles.textStyleBoldSubTitleLarge,
                                ),
                              ),
                            ],
                          ),
                          vSpace,
                          Text(
                            "Lorem ipsum dolor sit amet. Et nisi quam hic sint sapiente est animi consequuntur qui incidunt libero et quisquam quae est praesentium corporis? Aut porro recusandae aut nihil tempore ab accusamus facilis ea fuga ducimus qui dolores veritatis ut optio consequatur. Aut harum excepturi et officia possimus eos molestias quia! Eos ipsum dolorum qui unde ipsum aut sint omnis et quae asperiores id illum tenetur sed quis totam? </p><p>Sed eligendi autem et nihil possimus rem rerum aliquid et voluptas consequatur? Est velit sunt sed error animi aut eligendi architecto sit inventore quod qui voluptas consequatur! Ad iusto dolores id doloremque necessitatibus est quia internos! A saepe modi est natus quam qui dolor quia ut optio voluptas ut fuga esse. </p><p>Aut Quis provident rem eius repudiandae et autem enim rem rerum cupiditate ea amet vero. In nobis sunt At  explicabo ut neque praesentium sit neque voluptas. Aut debitis eveniet id voluptates ipsum non laudantium dignissimos et debitis aperiam a consequatur mollitia. Cum fugit nemo sed delectus unde ea asperiores atque vel explicabo ipsa aut modi quia.",
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

  List<String>? chips = [
    "Lake",
    "Hiking",
    "Chair Lift",
    "Mountains",
    "Restaurant"
  ];

  Widget _buildChipsList() {
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
