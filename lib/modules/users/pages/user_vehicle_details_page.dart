import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/dashboard/models/vehicle_model.dart';
import 'package:let_go_gb/modules/drivers/utils/firebase_paths.dart';
import 'package:let_go_gb/modules/drivers/utils/styles.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../drivers/dashboard/pages/driver_chat_screen.dart';
import '../controllers/user_vehicle_details_controller.dart';

// ignore: must_be_immutable
class UserVehicleDetailPage extends GetView<UserVehicleDetailsController> {
  UserVehicleDetailPage({Key? key}) : super(key: key);
  static const id = '/UserVehicleDetailPage';
  final vSpace = SizedBox(height: 20.h);
  final hSpace = SizedBox(height: 20.h);
  String vehicleId = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return GetX<UserVehicleDetailsController>(
      initState: (state) {
        /*  Future.delayed(
          const Duration(seconds: 2),
          () {},
        );*/
      },
      builder: (_) {
        controller.temp.value;
        return SafeArea(
          child: Scaffold(
            appBar: myAppBar(goBack: true, title: 'Vehicle', actions: []),
            body: Container(
              padding: EdgeInsets.all(10.h),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(FirebasePathNodes.vehicles)
                      .doc(vehicleId)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.data?.data() != null) {
                      return Stack(
                        children: [
                          vehicleDetails(
                              vehicleModel: VehicleModel.fromMap(snapshot.data!
                                  .data() as Map<String, dynamic>)),
                          vSpace,
                          _slidingPanel(context),
                          vSpace,
                        ],
                      );
                    }
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'No Vehicle Found',
                            style: AppTextStyles.textStyleBoldBodyMedium,
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        );
      },
    );
  }

  vehicleDetails({required VehicleModel vehicleModel}) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CarouselSlider(
            options: CarouselOptions(autoPlay: true, enlargeCenterPage: true),
            items: vehicleModel.vehicleImages

                ///these will be the images in vehicle
                ?.map(
                  (item) => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Center(
                      child: Image.network(
                        item,
                        height: 300.h,
                        width: 1500.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          vSpace,
          vSpace,
          Text(
            vehicleModel.vehicleName ?? '',
            style: AppTextStyles.textStyleBoldSubTitleLarge,
          ),
          vSpace,
          Text(
            vehicleModel.descriptionNote ?? '',
            style: AppTextStyles.textStyleNormalBodySmall,
          ),
          vSpace,
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.h),
            decoration: BoxDecoration(
                color: AppColor.blackColor,
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Shimmer.fromColors(
                period: const Duration(milliseconds: 4500),
                baseColor: Colors.white,
                highlightColor: Colors.black54,
                child: Column(
                  children: [
                    Text('Rent / Hour',
                        style: AppTextStyles.textStyleBoldBodyMedium),
                    Text('Rs. ${vehicleModel.rentHour ?? ''}',
                        style: AppTextStyles.textStyleBoldBodyXSmall),
                  ],
                ),
              ),
            ),
          ),
          vSpace,
          Text(
            ///these are specifications which driver will add , for example, make, maker, milage, etc
            'Specifications',
            style: AppTextStyles.textStyleBoldSubTitleLarge,
          ),
          vSpace,
          Wrap(
            children: [
              getSpecificationItem(
                  value: vehicleModel.transmissionType ?? '',
                  title: 'Transmission'),
              getSpecificationItem(
                  value: vehicleModel.mileage ?? '', title: 'Mileage / liter'),
              getSpecificationItem(
                  value: vehicleModel.seatingCapacity ?? '',
                  title: 'Seating Capacity'),
              getSpecificationItem(
                  value: vehicleModel.make ?? '', title: 'Make'),
              getSpecificationItem(
                  value: vehicleModel.maker ?? '', title: 'Maker'),
            ],
          ),
          vSpace,
          Text(
            ///features that driver will add while adding a vehicle
            'Features',
            style: AppTextStyles.textStyleBoldSubTitleLarge,
          ),
          vSpace,
          SizedBox(
            height: 80.h,
            child: ListView.builder(
                itemCount: vehicleModel.features?.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return getSpecificationItem(
                      height: 50.h, value: vehicleModel.features![index]);
                }),
          ),
          vSpace,
          vSpace,
          vSpace,
          vSpace,
          vSpace,
          vSpace,
          vSpace,
          vSpace,
        ],
      ),
    );
  }

  getSpecificationItem({double? height, String? title, required String value}) {
    return Container(
      height: height ?? 100.h,
      margin: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.h),
      decoration: BoxDecoration(
          color: AppColor.alphaGrey, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (title != null)
              Text(title, style: AppTextStyles.textStyleNormalBodyXSmall),
            Text(value, style: AppTextStyles.textStyleBoldBodyXSmall),
          ],
        ),
      ),
    );
  }

  SlidingUpPanel _slidingPanel(BuildContext context) {
    return SlidingUpPanel(
        color: Colors.transparent,
        minHeight: MediaQuery.of(context).size.height * (0.08),
        maxHeight: MediaQuery.of(context).size.height * (1),
        panelBuilder: (ScrollController _scrollController) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0))),
            child: Container(
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
      padding: EdgeInsets.all(15.h),
      margin: EdgeInsets.symmetric(horizontal: 100.w),
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
              Get.toNamed(ChatScreen.id);
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
}
