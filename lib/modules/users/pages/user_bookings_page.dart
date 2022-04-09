import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/common/models/booking_model.dart';
import 'package:let_go_gb/modules/drivers/utils/app_constants.dart';
import 'package:let_go_gb/modules/drivers/utils/user_defaults.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';
import 'package:let_go_gb/modules/users/controllers/user_booking_controller.dart';

import '../../drivers/dashboard/models/driver_user_model.dart';
import '../../drivers/utils/common_widgets.dart';
import '../../drivers/utils/firebase_paths.dart';
import '../../drivers/utils/styles.dart';

class UserBookingPage extends GetView<UserBookingController> {
  const UserBookingPage({Key? key}) : super(key: key);
  static const id = '/UserBookingPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: 'Bookings', goBack: false, actions: [
        /*   MyAnimSearchBar(
          width: MediaQuery.of(context).size.width,
          onSuffixTap: () {},
          closeSearchOnSuffixTap: true,
          textController: controller.searchTextController,
        ),*/
      ]),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: GetX<UserBookingController>(initState: (state) {
            controller.searchTextController.clear();
            /*  controller.searchTextController.addListener(() {
              controller.searchFromBookings();
            });*/
          }, builder: (context) {
            controller.temp.value;
            return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(FirebasePathNodes.bookings)
                    .where('userId',
                        isEqualTo: UserDefaults.getUserSession()?.id ?? '')
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
                    controller.showingBookingList.clear();
                    controller.allBookingList.clear();
                    for (var element in snapshot.data!.docs) {
                      Map<String, dynamic> data =
                          element.data()! as Map<String, dynamic>;
                      BookingModel model = BookingModel.fromMap(data);
                      controller.showingBookingList.add(model);
                      controller.allBookingList.add(model);
                    }
                    return Column(
                      children: [
                        Expanded(
                          child: Obx(() => ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: controller.showingBookingList.length,
                                itemBuilder: ((context, index) {
                                  return getRowItem(
                                      controller.showingBookingList[index]!);
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
                });
          }),
        ),
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
                                      "From: ${formatDateTime(model.bookingDateStart!)}",
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
}
