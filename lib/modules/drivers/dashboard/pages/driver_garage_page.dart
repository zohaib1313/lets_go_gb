import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/driver_garage_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/models/vehicle_model.dart';
import 'package:let_go_gb/modules/drivers/utils/common_widgets.dart';
import 'package:let_go_gb/modules/drivers/utils/firebase_paths.dart';
import 'package:let_go_gb/modules/drivers/utils/styles.dart';
import 'package:let_go_gb/modules/drivers/utils/user_defaults.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';
import 'package:shimmer/shimmer.dart';

import 'driver_add_new_vehicle_page.dart';

class DriverGaragePage extends GetView<DriverGarageController> {
  DriverGaragePage({Key? key}) : super(key: key);
  static const id = '/DriverGarage';
  final vSpace = SizedBox(height: 20.h);

  @override
  Widget build(BuildContext context) {
    return GetX<DriverGarageController>(
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
            appBar: myAppBar(goBack: false, title: 'Your Vehicle', actions: [
              PopupMenuButton<int>(
                onSelected: (item) => handleClick(item),
                itemBuilder: (context) => [
                  const PopupMenuItem<int>(value: 0, child: Text('Update')),
                  /*   const PopupMenuItem<int>(value: 1, child: Text('Delete')),*/
                ],
              ),
            ]),
            body: Container(
              padding: EdgeInsets.all(10.h),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(FirebasePathNodes.vehicles)
                      .doc(UserDefaults.getDriverUserSession()?.id ?? "")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.data?.data() != null) {
                      controller.vehicleModel = VehicleModel.fromMap(
                          snapshot.data!.data() as Map<String, dynamic>);

                      return vehicleDetails(
                          vehicleModel: controller.vehicleModel!);
                    }

                    controller.vehicleModel = null;
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'No Vehicle Found',
                            style: AppTextStyles.textStyleBoldBodyMedium,
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(DriverAddNewVehiclePage.id);
                            },
                            child: Text(
                              'Add new one?',
                              style: AppTextStyles.textStyleBoldBodyMedium
                                  .copyWith(color: AppColor.primaryBlueColor),
                            ),
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
      physics: const BouncingScrollPhysics(),
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
                        child: NetworkPlainImage(
                      url: item,
                      height: 300.h,
                      width: 1500.w,
                      fit: BoxFit.cover,
                    )),
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
                    Text('Rent / Day',
                        style: AppTextStyles.textStyleBoldBodyMedium),
                    Text('Rs. ${vehicleModel.rent ?? ''}',
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

  handleClick(int item) {
    switch (item) {
      case 0:
        Get.toNamed(DriverAddNewVehiclePage.id,
            arguments: controller.vehicleModel);

        break;

      case 2:
        break;
    }
  }
}
