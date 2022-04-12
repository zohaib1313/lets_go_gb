import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/common/models/booking_model.dart';
import 'package:let_go_gb/modules/drivers/utils/app_alert_bottom_sheet.dart';
import 'package:let_go_gb/modules/drivers/utils/app_constants.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';
import 'package:let_go_gb/modules/users/controllers/user_booking_controller.dart';
import 'package:let_go_gb/modules/users/pages/user_mark_booking_complete_review_add.dart';

import '../../drivers/dashboard/models/driver_user_model.dart';
import '../../drivers/utils/common_widgets.dart';
import '../../drivers/utils/firebase_paths.dart';
import '../../drivers/utils/styles.dart';

class UserBookingPage extends GetView<UserBookingController> {
  UserBookingPage({Key? key}) : super(key: key);
  static const id = '/UserBookingPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: 'Bookings', goBack: false, actions: [
        /* MyAnimSearchBar(
          width: MediaQuery.of(context).size.width,
          onSuffixTap: () {
            controller.searchController.clear();
          },
          closeSearchOnSuffixTap: true,
          textController: controller.searchController,
        ),*/
      ]),
      body: SafeArea(
        child: GetX<UserBookingController>(initState: (state) {
          controller.loadData();
          controller.searchController.clear();
          controller.searchController.addListener(
            () {
              controller.searchFromBookings();
            },
          );
        }, builder: (controll) {
          controller.temp.value;
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(50.r)),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, bottom: 20, left: 10, right: 10),
                              child: GestureDetector(
                                onTap: () {
                                  controller.filterOnDates();
                                },
                                child: Text(
                                  "Recent",
                                  style: AppTextStyles.textStyleBoldBodyMedium,
                                ),
                              ),
                            ),
                          ),
                          Icon(controller.isRecentFilterd.value
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 40.w, right: 40.w),
                      color: AppColor.alphaGrey,
                      width: 2,
                      height: 50.h,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          controller.isSortFiltered.value
                              ? Row(
                                  children: const [
                                    Icon(
                                      Icons.arrow_upward,
                                      size: 20,
                                    ),
                                    Icon(
                                      Icons.arrow_downward,
                                      size: 20,
                                    ),
                                  ],
                                )
                              : Row(
                                  children: const [
                                    Icon(
                                      Icons.arrow_downward,
                                      size: 20,
                                    ),
                                    Icon(
                                      Icons.arrow_upward,
                                      size: 20,
                                    ),
                                  ],
                                ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                controller.filterOnSort();
                              },
                              child: Text(
                                "Sort",
                                style: AppTextStyles.textStyleBoldBodyMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 40.w, right: 40.w),
                      color: AppColor.alphaGrey,
                      width: 2,
                      height: 50.h,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Icons.filter_alt_rounded),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                showBottom(context);
                              },
                              child: Text(
                                "Filter",
                                style: AppTextStyles.textStyleBoldBodyMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Obx(() => ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount:
                                    controller.filteredBookingList.length,
                                itemBuilder: ((context, index) {
                                  return getRowItem(
                                      controller.filteredBookingList[index]!);
                                }),
                              )),
                        ),
                        Container(
                          height: 80.h,
                          color: Colors.transparent,
                        )
                      ],
                    )

                    /*  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(FirebasePathNodes.bookings)
                          .where('userId',
                              isEqualTo:
                                  UserDefaults.getUserSession()?.id ?? '')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text(
                            'Something went wrong',
                            style: AppTextStyles.textStyleBoldBodyMedium,
                          );
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.data != null) {
                          controller.filteredBookingList.clear();

                          for (var element in snapshot.data!.docs) {
                            Map<String, dynamic> data =
                                element.data()! as Map<String, dynamic>;
                            BookingModel model = BookingModel.fromMap(data);
                            controller.filteredBookingList.add(model);
                          }
                          if (controller.allBookingList.isEmpty) {
                            controller.allBookingList
                                .addAll(controller.filteredBookingList);
                          }

                          return
                            Column(
                            children: [
                              Expanded(
                                child: Obx(() => ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount:
                                          controller.filteredBookingList.length,
                                      itemBuilder: ((context, index) {
                                        return getRowItem(controller
                                            .filteredBookingList[index]!);
                                      }),
                                    )),
                              ),
                              Container(
                                height: 80.h,
                                color: Colors.transparent,
                              )
                            ],
                          );
                        }
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'No Booking Found',
                                style: AppTextStyles.textStyleBoldBodyMedium,
                              ),
                            ],
                          ),
                        );
                      }),*/
                    ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget getRowItem(BookingModel model) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(FirebasePathNodes.users)
            .doc(model.vehicleId ?? '')
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

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data != null) {
            DriverUserModel driverUserModel = DriverUserModel.fromMap(
                (snapshot.data!.data() as Map<String, dynamic>));

            return InkWell(
              onTap: () {
                // Get.toNamed(DriverBookingDetailsPage.id);
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
                              url: driverUserModel.profileImage ?? '',
                              radius: 30,
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
                                  driverUserModel.firstName ?? '',
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
                                            " ${model.pickUpAddress ?? ''}",
                                            maxLines: 2,

                                            style: AppTextStyles
                                                .textStyleNormalBodySmall,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.h),
                                    Text(
                                      "From:  ${formatDateTime(model.bookingDateStart)}",
                                      maxLines: 2,
                                      style: AppTextStyles
                                          .textStyleNormalBodySmall,
                                    ),
                                    Text(
                                      "To: ${formatDateTime(model.bookingDateEnd)}",
                                      maxLines: 2,
                                      style: AppTextStyles
                                          .textStyleNormalBodySmall,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )),
                          (model.status ?? "") == BookingStatus.confirmed
                              ? InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                        UserMarkBookingCompleteReviewAddPage.id,
                                        arguments: model);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColor.primaryBlueColor),
                                    padding: const EdgeInsets.all(8.0),
                                    margin: EdgeInsets.only(right: 10.w),
                                    child: Text(
                                      "Mark Complete",
                                      style: AppTextStyles
                                          .textStyleBoldBodyXSmall
                                          .copyWith(color: AppColor.whiteColor),
                                    ),
                                  ),
                                )
                              : const IgnorePointer()
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 120.w,
                    height: 122.h,
                    decoration: BoxDecoration(
                      color: BookingStatus.getColor(model.status),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Center(
                        child: Text(
                          model.status ?? '',
                          style: AppTextStyles.textStyleBoldBodyMedium
                              .copyWith(color: AppColor.whiteColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return Center(
            child: Text(
              'Something went wrong',
              style: AppTextStyles.textStyleBoldBodyMedium,
            ),
          );
        });
  }

  final vSpace = SizedBox(height: 20.h);

  void showBottom(BuildContext context) {
    AppBottomSheets.showAppAlertBottomSheet(
        context: context,
        isFull: true,
        title: "Apply Filters",
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Button(
                buttonText: "Confirmed",
                textColor: AppColor.whiteColor,
                onTap: () {
                  Get.back();
                  controller.getFilteredList(status: BookingStatus.confirmed);
                },
              ),
              vSpace,
              Button(
                buttonText: "Pending",
                textColor: AppColor.whiteColor,
                onTap: () {
                  Get.back();
                  controller.getFilteredList(status: BookingStatus.pending);
                },
              ),
              vSpace,
              Button(
                buttonText: "Completed",
                textColor: AppColor.whiteColor,
                onTap: () {
                  Get.back();
                  controller.getFilteredList(status: BookingStatus.completed);
                },
              ),
              vSpace,
              Button(
                buttonText: "Cancelled",
                textColor: AppColor.whiteColor,
                onTap: () {
                  Get.back();
                  controller.getFilteredList(status: BookingStatus.cancelled);
                },
              ),
              vSpace,
              Button(
                buttonText: "Clear All Filters",
                textColor: AppColor.whiteColor,
                onTap: () {
                  Get.back();
                  controller.getFilteredList(status: "");
                },
              ),
              vSpace
            ],
          ),
        ));
  }
}
