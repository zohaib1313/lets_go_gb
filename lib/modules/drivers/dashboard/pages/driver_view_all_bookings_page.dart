import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/driver_booking_controller.dart';
import 'package:let_go_gb/modules/drivers/utils/styles.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';

import '../../../../common/booking_model.dart';
import '../../../users/models/user_model.dart';
import '../../utils/app_constants.dart';
import '../../utils/common_widgets.dart';
import '../../utils/firebase_paths.dart';
import '../../utils/my_app_bar.dart';
import '../../utils/user_defaults.dart';
import 'driver_booking_detail_page.dart';

class DriverViewAllBookingsPage extends GetView<DriverBookingController> {
  const DriverViewAllBookingsPage({Key? key}) : super(key: key);
  static const id = '/driver_view_all_bookings_page.dart';

  @override
  Widget build(BuildContext context) {
    return GetX<DriverBookingController>(initState: (state) {
      ///load chats here
      controller.temp.value = true;
    }, builder: (stateCtx) {
      controller.temp.value;
      return Scaffold(
        appBar: myAppBar(goBack: true, title: "Your Bookings", actions: [
          MyAnimSearchBar(
            width: MediaQuery.of(context).size.width,
            onSuffixTap: () {
              // controller.searchJobPostedController.clear();
            },
            closeSearchOnSuffixTap: true,
            textController:
                TextEditingController() /*controller.searchJobPostedController*/,
          ),
        ]),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(FirebasePathNodes.bookings)
                    .where('vehicleId',
                        isEqualTo:
                            UserDefaults.getDriverUserSession()?.id ?? '')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

                  return ListView(
                    shrinkWrap: true,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;

                      BookingModel model = BookingModel.fromMap(data);

                      return getRowItem(model);
                    }).toList(),
                  );
                }),
          ),
        ),
      );
    });
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
}
