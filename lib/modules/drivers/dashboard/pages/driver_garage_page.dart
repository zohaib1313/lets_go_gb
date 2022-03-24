import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/driver_garage_controller.dart';
import 'package:let_go_gb/modules/drivers/utils/styles.dart';
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
        controller.haveVehicle.value = true;
        Future.delayed(
          const Duration(seconds: 2),
          () {},
        );
      },
      builder: (_) {
        return SafeArea(
          child: Scaffold(
            appBar: myAppBar(
                goBack: false,
                title: 'Your Vehicle',
                actions: controller.haveVehicle.value
                    ? [
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(Icons.more_vert),
                        )
                      ]
                    : null),
            body: Container(
              padding: EdgeInsets.all(10.h),
              child: controller.haveVehicle.value
                  ? vehicleDetails()
                  : Center(
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
                    ),
            ),
          ),
        );
      },
    );
  }

  vehicleDetails() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CarouselSlider(
            options: CarouselOptions(autoPlay: true, enlargeCenterPage: true),
            items: controller.imagesList

                ///these will be the images in vehicle
                .map(
                  (item) => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Center(
                      child: Image.network(
                        item,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          vSpace,
          Text(
            'Toyota Parado',
            style: AppTextStyles.textStyleBoldSubTitleLarge,
          ),
          vSpace,
          Text(
            'Vaadi travels provides Toyota Prado on rent from Islamabad and Rawalpindi to all Northern areas of Pakistan and AJK. For more details please call us at',
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
                    Text('Rs. ${controller.vehicleModel!.rentHour}',
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
          Wrap(
            children: [
              getSpecificationItem(),
              getSpecificationItem(),
              getSpecificationItem(),
              getSpecificationItem(),
              getSpecificationItem(),
              getSpecificationItem(),
              getSpecificationItem(),
              getSpecificationItem(),
            ],
          ),
          Text(
            ///features that driver will add while adding a vehicle
            'Features',
            style: AppTextStyles.textStyleBoldSubTitleLarge,
          ),
          SizedBox(
            height: 80.h,
            child: ListView.builder(
                itemCount: 10,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return getSpecificationItem(height: 50.h);
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

  getSpecificationItem({double? height}) {
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
            Text('Milage/Liter',
                style: AppTextStyles.textStyleNormalBodyXSmall),
            Text('40km', style: AppTextStyles.textStyleBoldBodyXSmall),
          ],
        ),
      ),
    );
  }
}
