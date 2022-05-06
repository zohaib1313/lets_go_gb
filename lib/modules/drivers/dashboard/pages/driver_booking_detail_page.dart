import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:let_go_gb/common/models/booking_model.dart';
import 'package:let_go_gb/common/models/chat_user_model.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/loading_widget.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/DriverBookingDetailController.dart';
import 'package:let_go_gb/modules/drivers/utils/app_constants.dart';
import 'package:let_go_gb/modules/drivers/utils/app_popups.dart';
import 'package:let_go_gb/modules/drivers/utils/common_widgets.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';
import 'package:let_go_gb/modules/users/models/user_model.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../common/pages/chat_screen.dart';
import '../../utils/styles.dart';
import 'driver_google_map.dart';

class DriverBookingDetailsPage extends GetView<DriverBookingDetailController> {
  static const id = "/DriverBookingDetailsPage";

  DriverBookingDetailsPage({Key? key}) : super(key: key);
  static var vSpace = SizedBox(height: 20.h);
  static var hSpace = SizedBox(width: 50.w);

  BookingModel bookingModel = Get.arguments[0];
  UserModel userModel = Get.arguments[1];

  @override
  Widget build(BuildContext context) {
    var _pageArea = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top +
            MediaQuery.of(context).padding.bottom);
    return GetX<DriverBookingDetailController>(
        initState: (state) {},
        builder: (staex) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AppColor.whiteColor,
              automaticallyImplyLeading: true,
              iconTheme: const IconThemeData(color: AppColor.blackColor),
              title: Text(
                'Booking Details',
                style: AppTextStyles.textStyleBoldBodyMedium,
              ),
            ),
            backgroundColor: AppColor.alphaGrey,
            body: SafeArea(
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.37,
                    child: Container(
                      color: AppColor.greenColor,
                      child: MapSampleDriver(
                          userLocationPickUp: LatLng(bookingModel.pickUpLat!,
                              bookingModel.pickUpLng!)),

                      ///show pickup location
                    ),
                  ),
                  _slidingPanel(context, _pageArea),
                  if (controller.isLoading.value) LoadingWidget(),
                ],
              ),
            ),
          );
        });
  }

  SlidingUpPanel _slidingPanel(BuildContext context, double pageArea) {
    return SlidingUpPanel(
        color: Colors.transparent,
        minHeight: MediaQuery.of(context).size.height * (0.55),
        maxHeight: MediaQuery.of(context).size.height * (1),
        panelBuilder: (ScrollController _scrollController) {
          return Container(
            margin: const EdgeInsetsDirectional.only(
                start: 10, end: 10, top: 14, bottom: 8),
            decoration: const BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0))),
            child: Container(
              padding: const EdgeInsetsDirectional.only(
                  start: 12, top: 12, end: 12, bottom: 6),
              child: Column(
                children: [
                  // Path 45
                  Container(
                      width: 70,
                      height: 8,
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: const BoxDecoration(
                          color: AppColor.alphaGrey,
                          borderRadius:
                              BorderRadius.all(Radius.circular(4.0)))),

                  ///views
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _userDetails(),
                        vSpace,
                        getRowInfo(
                            title: 'Booking id',
                            value: bookingModel.bookingId ?? ''),
                        getRowInfo(
                            title: 'Booking Notes',
                            value: bookingModel.bookingNotes ?? ''),
                        getRowInfo(
                            title: 'Pick Up Date & Time',
                            value:
                                '${formatDateTime(bookingModel.bookingDateStart)} : ${bookingModel.pickUpTime ?? ''}'),
                        getRowInfo(
                            title: 'Pick Up Address',
                            value: bookingModel.pickUpAddress ?? ''),
                        getRowInfo(
                            title: 'Total Passengers',
                            value: (bookingModel.passengers ?? 0).toString()),
                        getRowInfo(
                            title: 'Booking Request For',
                            value:
                                '${formatDateTime(bookingModel.bookingDateStart)} -- ${formatDateTime(bookingModel.bookingDateEnd)}  ${'${daysDifference(from: bookingModel.bookingDateStart!, to: bookingModel.bookingDateEnd!).toString()} Days'}'),
                        if ((bookingModel.status ?? '') ==
                            BookingStatus.pending)
                          Row(
                            children: [
                              Expanded(
                                  child: Button(
                                buttonText: 'Cancel Booking',
                                color: AppColor.redColor,
                                textColor: AppColor.whiteColor,
                                onTap: () {
                                  AppPopUps.showConfirmDialog(
                                    title: 'Please Confirm',
                                    message: 'Booking will be cancelled',
                                    onSubmit: () {
                                      Navigator.pop(context);
                                      controller.changeBookingStatus(
                                        booking: bookingModel,
                                        user: userModel,
                                        status: BookingStatus.cancelled,
                                      );
                                    },
                                  );
                                },
                              )),
                              Expanded(
                                  child: Button(
                                buttonText: 'Confirm Booking',
                                color: AppColor.greenColor,
                                textColor: AppColor.whiteColor,
                                onTap: () {
                                  AppPopUps.showConfirmDialog(
                                    title: 'Please Confirm',
                                    message: 'Booking will be confirmed',
                                    onSubmit: () {
                                      Navigator.pop(context);
                                      controller.changeBookingStatus(
                                        booking: bookingModel,
                                        user: userModel,
                                        status: BookingStatus.confirmed,
                                      );
                                    },
                                  );
                                },
                              )),
                            ],
                          )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
        onPanelOpened: () {});
  }

  _userDetails() {
    return Container(
      padding: EdgeInsets.all(20.h),
      decoration: BoxDecoration(
          color: AppColor.blackColor, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          NetworkCircularImage(
            url: userModel.profileImage ?? '',
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                userModel.firstName ?? '',
                style: AppTextStyles.textStyleBoldBodyMedium
                    .copyWith(color: AppColor.whiteColor),
              ),
              Text(
                userModel.phone ?? '',
                style: AppTextStyles.textStyleBoldBodySmall
                    .copyWith(color: AppColor.whiteColor),
              ),
            ],
          )),
          hSpace,
          InkWell(
            onTap: () {
              Get.toNamed(ChatScreen.id,
                  arguments: ChatUserModel(
                      otherUserId: userModel.id,
                      otherUserName: userModel.firstName,
                      otherUserContact: userModel.phone,
                      otherUserProfileImage: userModel.profileImage));
            },
            child: const Icon(
              Icons.chat,
              color: AppColor.whiteColor,
            ),
          ),
          hSpace
        ],
      ),
    );
  }

  getRowInfo({required String title, required String value}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.textStyleBoldBodyMedium,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            style: AppTextStyles.textStyleNormalBodyMedium,
            maxLines: 4,
          ),
        ),
        const Divider()
      ],
    );
  }
}
