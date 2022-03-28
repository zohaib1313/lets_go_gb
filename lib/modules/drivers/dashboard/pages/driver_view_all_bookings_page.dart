import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/driver_booking_controller.dart';
import 'package:let_go_gb/modules/drivers/utils/styles.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';

import '../../utils/common_widgets.dart';
import '../../utils/my_app_bar.dart';
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
      return SafeArea(
        child: Scaffold(
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
          body: Container(
            padding: EdgeInsets.all(10.h),
            child: controller.temp.value
                ? ListView.builder(
                    itemCount: 11,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return index == 10
                          ? SizedBox(height: 150.h)

                          ///adding padding at the last item so that row don't overlap on bottom navbar
                          : getRowItem(index);
                    },
                  )
                : Center(
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
                  ),
          ),
        ),
      );
    });
  }

  Widget getRowItem(index) {
    return InkWell(
        onTap: () {
          Get.toNamed(DriverBookingDetailsPage.id);
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
