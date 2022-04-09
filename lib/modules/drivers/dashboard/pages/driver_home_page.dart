// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:let_go_gb/common/models/booking_model.dart';
import 'package:let_go_gb/common/pages/notifications_page.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/loading_widget.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/driver_dashboard_home_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/models/driver_user_model.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/driver_signup_screen.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/driver_view_all_bookings_page.dart';
import 'package:let_go_gb/modules/drivers/utils/app_constants.dart';
import 'package:let_go_gb/modules/drivers/utils/app_popups.dart';
import 'package:let_go_gb/modules/drivers/utils/common_widgets.dart';
import 'package:let_go_gb/modules/drivers/utils/styles.dart';
import 'package:let_go_gb/modules/drivers/utils/user_defaults.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';
import 'package:let_go_gb/modules/users/models/user_model.dart';

import '../../utils/firebase_paths.dart';
import 'driver_booking_detail_page.dart';

// ignore: must_be_immutable
class DriverHomePage extends GetView<DriverDashBoardHomeController> {
  const DriverHomePage({Key? key}) : super(key: key);
  static const id = '/DriverHomePage';
  static var vSpace = SizedBox(height: 20.h);
  static var hSpace = SizedBox(width: 50.w);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await AppPopUps.showConfirmDialog(
            title: 'Confirm',
            message: 'Are you sure to exit from the app',
            onSubmit: () {
              Navigator.pop(context, true);
            });
      },
      child: GetX<DriverDashBoardHomeController>(
          initState: (state) {},
          builder: (_) {
            return Stack(
              children: [
                Scaffold(
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
                                      'Welcome ',
                                      style: AppTextStyles
                                          .textStyleBoldSubTitleLarge,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(NotificationsPage.id);
                                    },
                                    child: const CircleAvatar(
                                      backgroundColor: AppColor.alphaGrey,
                                      child: SvgViewer(
                                          svgPath:
                                              'assets/icons/ic_notifications.svg'),
                                    ),
                                  )
                                ],
                              ),

                              ///user information card
                              vSpace,
                              StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection(FirebasePathNodes.users)
                                      .doc(UserDefaults.getDriverUserSession()
                                              ?.id ??
                                          '')
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    if (snapshot.hasError) {
                                      return Center(
                                        child: Text(
                                          'Something went wrong',
                                          style: AppTextStyles
                                              .textStyleBoldBodyMedium,
                                        ),
                                      );
                                    }

                                    if (!snapshot.hasData) {
                                      return const CircularProgressIndicator();
                                    }

                                    Map<String, dynamic> userDocument =
                                        snapshot.data?.data()
                                            as Map<String, dynamic>;
                                    DriverUserModel currentUser =
                                        DriverUserModel.fromMap(userDocument);

                                    controller.saveUserSession(currentUser);

                                    return InkWell(
                                      onTap: () {
                                        Get.toNamed(DriverSignUpScreen.id,
                                            arguments: currentUser);
                                      },
                                      child: Card(
                                        elevation: 30,
                                        color: AppColor.blackColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Container(
                                          padding: EdgeInsets.all(20.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              NetworkCircularImage(
                                                url: currentUser.profileImage ??
                                                    '',
                                              ),
                                              Flexible(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      currentUser.firstName ??
                                                          "-",
                                                      style: AppTextStyles
                                                          .textStyleBoldBodyMedium
                                                          .copyWith(
                                                              color: AppColor
                                                                  .whiteColor),
                                                    ),
                                                    Text(
                                                      currentUser.phone ?? "-",
                                                      style: AppTextStyles
                                                          .textStyleBoldBodySmall
                                                          .copyWith(
                                                              color: AppColor
                                                                  .alphaGrey
                                                                  .withOpacity(
                                                                      0.9)),
                                                    ),
                                                    /* RatingBar.builder(
                                                      initialRating:
                                                          (currentUser.ratings ?? 0)
                                                              .toDouble(),
                                                      minRating: 1,
                                                      itemSize: 20,
                                                      direction: Axis.horizontal,
                                                      allowHalfRating: true,
                                                      updateOnDrag: false,
                                                      unratedColor:
                                                          AppColor.whiteColor,
                                                      itemCount: 5,
                                                      ignoreGestures: true,
                                                      itemPadding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 4.0),
                                                      itemBuilder: (context, _) =>
                                                          const Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                      onRatingUpdate: (rating) {
                                                        print(rating);
                                                      },
                                                    ),*/
                                                    vSpace,
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          color: AppColor
                                                              .whiteColor
                                                              .withOpacity(
                                                                  0.3)),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            (currentUser.isActive ??
                                                                    false)
                                                                ? 'Account Active: '
                                                                : 'Account In-Active: ',
                                                            style: AppTextStyles
                                                                .textStyleNormalBodyXSmall
                                                                .copyWith(
                                                                    color: AppColor
                                                                        .whiteColor),
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .online_prediction,
                                                            color: (currentUser
                                                                        .isActive ??
                                                                    false)
                                                                ? AppColor
                                                                    .greenColor
                                                                : AppColor
                                                                    .redColor,
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
                                    );
                                  }),

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
                                            child: InkWell(
                                              onTap: () {
                                                showMyMonthPicker(
                                                    context: context,
                                                    onMonthSelected: (month) {
                                                      controller
                                                          .selecetedDateTime
                                                          .value = month;
                                                    },
                                                    initialDate: controller
                                                        .selecetedDateTime
                                                        .value);
                                              },
                                              child: Text(
                                                'Bookings\n${DateFormat.yMMMM().format(controller.selecetedDateTime.value).toString()}',
                                                style: AppTextStyles
                                                    .textStyleBoldSubTitleLarge
                                                    .copyWith(
                                                        color: AppColor
                                                            .blackColor),
                                              ),
                                            ),
                                          ),
                                          hSpace,
                                          InkWell(
                                            onTap: () {
                                              Get.toNamed(
                                                  DriverViewAllBookingsPage.id);
                                            },
                                            child: Text("View All",
                                                style: AppTextStyles
                                                    .textStyleBoldBodyXSmall),
                                          ),
                                          // const Icon(Icons.filter_alt_rounded)
                                        ],
                                      ),
                                      vSpace,
                                      Expanded(
                                        child: StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection(
                                                    FirebasePathNodes.bookings)
                                                .where('vehicleId',
                                                    isEqualTo:
                                                        UserDefaults.getDriverUserSession()
                                                                ?.id ??
                                                            '')
                                                .limit(10)
                                                .orderBy('bookingDateStart')
                                                .where(
                                                  'bookingDateStart',
                                                  isGreaterThan: controller
                                                      .selecetedDateTime.value,
                                                )
                                                .where('bookingDateStart',
                                                    isLessThan: DateTime(
                                                        controller
                                                            .selecetedDateTime
                                                            .value
                                                            .year,
                                                        controller
                                                                .selecetedDateTime
                                                                .value
                                                                .month +
                                                            1,
                                                        controller
                                                            .selecetedDateTime
                                                            .value
                                                            .day))
                                                .snapshots(),
                                            builder: (context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    snapshot) {
                                              if (snapshot.hasError) {
                                                return Center(
                                                  child: Text(
                                                    'Something went wrong',
                                                    style: AppTextStyles
                                                        .textStyleBoldBodyMedium,
                                                  ),
                                                );
                                              }

                                              if (!snapshot.hasData) {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              }
                                              if (snapshot.data!.docs.isEmpty) {
                                                return Center(
                                                  child: Text(
                                                    'No Booking Found',
                                                    style: AppTextStyles
                                                        .textStyleBoldBodyMedium,
                                                  ),
                                                );
                                              }
                                              return ListView(
                                                shrinkWrap: true,
                                                children: snapshot.data!.docs
                                                    .map((DocumentSnapshot
                                                        document) {
                                                  Map<String, dynamic> data =
                                                      document.data()! as Map<
                                                          String, dynamic>;

                                                  BookingModel model =
                                                      BookingModel.fromMap(
                                                          data);

                                                  return getRowItem(model);
                                                }).toList(),
                                              );
                                            }),
                                      ),
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
                if (controller.loading.value) LoadingWidget(),
              ],
            );
          }),
    );
  }

  Widget getRowItem(BookingModel bookingModel) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(FirebasePathNodes.users)
            .doc(bookingModel.userId ?? '')
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Something went wrong',
                style: AppTextStyles.textStyleBoldBodyMedium,
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data?.data() != null) {
            UserModel userModel = UserModel.fromMap(
                snapshot.data!.data() as Map<String, dynamic>);

            return InkWell(
                onTap: () {
                  Get.toNamed(DriverBookingDetailsPage.id,
                      arguments: [bookingModel, userModel]);
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        margin: const EdgeInsets.only(
                            left: 0, right: 0, top: 3, bottom: 3),
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
                              child: NetworkCircularImage(
                                url: userModel.profileImage ?? '',
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
                                    userModel.firstName ?? '',
                                    style:
                                        AppTextStyles.textStyleBoldBodyMedium,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              " ${bookingModel.pickUpAddress ?? ''}",
                                              maxLines: 2,
                                              style: AppTextStyles
                                                  .textStyleNormalBodySmall,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        "From: ${formatDateTime(bookingModel.bookingDateStart)}",
                                        maxLines: 2,
                                        style: AppTextStyles
                                            .textStyleNormalBodySmall,
                                      ),
                                      Text(
                                        "To: ${formatDateTime(bookingModel.bookingDateEnd)}",
                                        maxLines: 2,
                                        style: AppTextStyles
                                            .textStyleNormalBodySmall,
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
                        color: BookingStatus.getColor(bookingModel.status),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Center(
                          child: Text(
                            bookingModel.status ?? '',
                            style: AppTextStyles.textStyleBoldBodyMedium
                                .copyWith(color: AppColor.whiteColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  ],
                ));
          } else {
            return Center(
              child: Text(
                'No Data Found',
                style: AppTextStyles.textStyleBoldBodyMedium,
              ),
            );
          }
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
        : const IgnorePointer();
  }
}
