import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/loading_widget.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/driver_dashboard_home_controller.dart';
import 'package:let_go_gb/modules/drivers/utils/common_widgets.dart';
import 'package:let_go_gb/modules/drivers/utils/styles.dart';

// ignore: must_be_immutable
class DriverHomePage extends GetView<DriverDashBoardHomeController> {
  DriverHomePage({Key? key}) : super(key: key);
  static const id = '/DriverHomePage';
  static var vSpace = SizedBox(height: 20.h);
  static var hSpace = SizedBox(width: 50.w);

  @override
  Widget build(BuildContext context) {
    return GetX<DriverDashBoardHomeController>(initState: (state) {
      controller.loadUserInfo();
    }, builder: (_) {
      return Stack(
        children: [
          controller.loading.value
              ? LoadingWidget()
              : Scaffold(
                  body: SafeArea(
                    child: Stack(
                      children: [
                        animatedBackGround(),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 100.w, vertical: 50.h),
                          child: Column(
                            children: [
                              ///headers
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Welcome , TestUser',
                                      style: AppTextStyles
                                          .textStyleBoldSubTitleLarge,
                                    ),
                                  ),
                                  const CircleAvatar(
                                    backgroundColor: AppColor.alphaGrey,
                                    child: SvgViewer(
                                        svgPath:
                                            'assets/icons/ic_notifications.svg'),
                                  )
                                ],
                              ),

                              ///user information card
                              vSpace,
                              Card(
                                elevation: 30,
                                color: AppColor.blackColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  padding: EdgeInsets.all(20.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 180.r,
                                        backgroundImage: const AssetImage(
                                            'assets/images/place_your_image.png'),
                                      ),
                                      Flexible(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              controller
                                                  .loginModel.value.firstName!,
                                              style: AppTextStyles
                                                  .textStyleBoldBodyMedium
                                                  .copyWith(
                                                      color:
                                                          AppColor.whiteColor),
                                            ),
                                            Text(
                                              controller
                                                  .loginModel.value.phone!,
                                              style: AppTextStyles
                                                  .textStyleBoldBodySmall
                                                  .copyWith(
                                                      color: AppColor.alphaGrey
                                                          .withOpacity(0.9)),
                                            ),
                                            RatingBar.builder(
                                              initialRating: 3,
                                              minRating: 1,
                                              itemSize: 20,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              unratedColor: AppColor.whiteColor,
                                              itemCount: 5,
                                              itemPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                              itemBuilder: (context, _) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {
                                                print(rating);
                                              },
                                            ),
                                            vSpace,
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: AppColor.whiteColor
                                                      .withOpacity(0.3)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Account Active: ',
                                                    style: AppTextStyles
                                                        .textStyleNormalBodyXSmall
                                                        .copyWith(
                                                            color: AppColor
                                                                .whiteColor),
                                                  ),
                                                  const Icon(
                                                    Icons.online_prediction,
                                                    color: AppColor.greenColor,
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              ///bookings widgets
                              vSpace,
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(20.h),
                                  decoration: BoxDecoration(
                                    color: AppColor.whiteColor.withAlpha(480),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Bookings\nJanuary 2022',
                                              style: AppTextStyles
                                                  .textStyleBoldSubTitleLarge
                                                  .copyWith(
                                                      color:
                                                          AppColor.blackColor),
                                            ),
                                          ),
                                          hSpace,
                                          Text("View All",
                                              style: AppTextStyles
                                                  .textStyleBoldBodyXSmall),
                                          // const Icon(Icons.filter_alt_rounded)
                                        ],
                                      ),
                                      vSpace,
                                      Expanded(
                                        child: ListView.builder(
                                            itemCount: 10,
                                            shrinkWrap: true,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return getRowItem(index);
                                            }),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      );
    });
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
                      opacity: 0.8,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            })
        : IgnorePointer();
  }

  Widget getRowItem(index) {
    return InkWell(
        onTap: () {
          ///goto booking details
        },
        child: Row(
          children: [
            Expanded(
              child: Card(
                margin:
                    const EdgeInsets.only(left: 0, right: 0, top: 3, bottom: 3),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 27,
                        backgroundImage:
                            Image.asset('assets/images/eclipse.jpg').image,
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User Name',
                            style: AppTextStyles.textStyleBoldBodyMedium,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5.h),
                              Row(
                                children: [
                                  const SvgViewer(
                                    svgPath:
                                        'assets/icons/ic_location_black.svg',
                                    width: 12,
                                    height: 12,
                                  ),
                                  Flexible(
                                    child: Text(
                                      ///this will be the notes of booking , while placing booking user will add this
                                      " Airport road",
                                      maxLines: 2,

                                      style: AppTextStyles
                                          .textStyleNormalBodySmall,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                "From: 22 January 2022",
                                maxLines: 2,
                                style: AppTextStyles.textStyleNormalBodySmall,
                              ),
                              Text(
                                "To: 25 January 2022",
                                maxLines: 2,
                                style: AppTextStyles.textStyleNormalBodySmall,
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),
            Container(
              width: 120.w,
              height: 122.h,
              decoration: BoxDecoration(
                color:
                    index % 2 == 0 ? Colors.green : AppColor.primaryBlueColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: RotatedBox(
                quarterTurns: 1,
                child: Center(
                  child: Text(
                    index % 2 == 0 ? 'Confirmed' : 'Pending',
                    style: AppTextStyles.textStyleBoldBodyMedium
                        .copyWith(color: AppColor.whiteColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
