import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/DriverBookingDetailController.dart';
import 'package:let_go_gb/modules/drivers/utils/common_widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../utils/styles.dart';
import 'google_map.dart';

class DriverBookingDetailsPage extends GetView<DriverBookingDetailController> {
  static const id = "/DriverBookingDetailsPage";

  const DriverBookingDetailsPage({Key? key}) : super(key: key);
  static var vSpace = SizedBox(height: 20.h);
  static var hSpace = SizedBox(width: 50.w);

  @override
  Widget build(BuildContext context) {
    var _pageArea = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top +
            MediaQuery.of(context).padding.bottom);
    return GetX<DriverBookingDetailController>(
        initState: (state) {},
        builder: (staex) {
          controller.temp.value;
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
                      child: MapSample(),

                      ///show pickup location
                    ),
                  ),
                  _slidingPanel(context, _pageArea)
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
                      margin: EdgeInsets.only(bottom: 12),
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
                            title: 'Booking Notes',
                            value:
                                ''''Hi, i need a vehicle for 3 days,Hi, i need a vehicle for 3 days,Hi, i need a vehicle for 3 days,Hi, i need a vehicle for 3 days',  '''),
                        getRowInfo(
                            title: 'Pick Up Date & Time',
                            value: '22 Feb 2022 : 11:00 pm'),
                        getRowInfo(
                            title: 'Pick Up Address',
                            value: 'Airport road gate no 10'),
                        getRowInfo(
                            title: 'Total Passengers', value: '4 Persons'),
                        getRowInfo(
                            title: 'Booking Request For',
                            value: '22 Feb 2022 -- 25 Feb 2022  ${'3 Days'}'),
                        Row(
                          children: [
                            Expanded(
                                child: Button(
                              buttonText: 'Cancel',
                              color: AppColor.redColor,
                              textColor: AppColor.whiteColor,
                              onTap: () {},
                            )),
                            Expanded(
                                child: Button(
                              buttonText: 'Confirm',
                              color: AppColor.greenColor,
                              textColor: AppColor.whiteColor,
                              onTap: () {},
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
          const CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage('assets/images/eclipse.jpg'),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'User abc',
                style: AppTextStyles.textStyleBoldBodyMedium
                    .copyWith(color: AppColor.whiteColor),
              ),
              Text(
                '+92xxxxxxxx',
                style: AppTextStyles.textStyleBoldBodySmall
                    .copyWith(color: AppColor.whiteColor),
              ),
            ],
          )),
          hSpace,
          InkWell(
            onTap: () {
              ///open chat with this user
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
