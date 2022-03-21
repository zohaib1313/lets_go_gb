import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/add_new_vehicle_controller.dart';
import 'package:let_go_gb/modules/drivers/utils/styles.dart';

import '../../utils/common_widgets.dart';

class DriverAddNewVehiclePage extends GetView<AddNewVehicleController> {
  DriverAddNewVehiclePage({Key? key}) : super(key: key);
  static const id = '/DriverAddNewVehiclePage';
  final vSpace = SizedBox(height: 20.h);

  @override
  Widget build(BuildContext context) {
    return GetX<AddNewVehicleController>(
      initState: (state) {},
      builder: (_) {
        controller.temp.value;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Container(
                color: AppColor.blackColor.withAlpha(100),
                padding: EdgeInsets.all(20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.h),
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                    vSpace,
                    Expanded(
                      child: Card(
                        color: AppColor.whiteColor.withOpacity(0.8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 20,
                        child: Padding(
                          padding: EdgeInsets.all(20.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Add Your Vehicle",
                                style: AppTextStyles.textStyleBoldSubTitleLarge,
                              ),
                              Expanded(
                                  child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      vSpace,
                                      getTextField(
                                          title: 'Vehicle Name',
                                          controller:
                                              controller.vehicleNameController),
                                      vSpace,
                                      getTextField(
                                          title: 'Vehicle Plate No',
                                          controller: TextEditingController()),
                                      vSpace,
                                      getTextField(
                                          title: 'Vehicle Maker',
                                          controller: TextEditingController()),
                                      vSpace,
                                      getTextField(
                                          title: 'Vehicle Make',
                                          controller: TextEditingController()),
                                      vSpace,
                                      getTextField(
                                          title: 'Rent / Hour',
                                          keyBoardType: TextInputType.number,
                                          controller: TextEditingController()),
                                      vSpace,
                                      getTextField(
                                          title: 'Mileage / Liter',
                                          keyBoardType: TextInputType.number,
                                          controller: TextEditingController()),
                                      vSpace,
                                      MyDropDown(
                                        fillColor: AppColor.alphaGrey,
                                        labelText: 'Seating Capacity',
                                        hintText: 'Select',
                                        items: controller.seatingCapacityList,
                                        value: controller
                                            .selectedSeatCapacity.value,
                                        validator: (value) {
                                          return null;
                                        },
                                        onChange: (value) {
                                          controller.selectedSeatCapacity
                                              .value = value;
                                        },
                                      ),
                                      vSpace,
                                      MyDropDown(
                                        fillColor: AppColor.alphaGrey,
                                        labelText: 'Transmission Type',
                                        hintText: 'Select',
                                        items: controller.transMissionTypeList,
                                        value: controller
                                            .selectedTransmissionType.value,
                                        validator: (value) {
                                          return null;
                                        },
                                        onChange: (value) {
                                          controller.selectedTransmissionType
                                              .value = value;
                                        },
                                      ),
                                      vSpace,
                                      Text(
                                        "Gallery",
                                        style: AppTextStyles
                                            .textStyleBoldSubTitleLarge,
                                      ),
                                      Text(
                                        "upload recent pictures of your vehicle",
                                        style: AppTextStyles
                                            .textStyleNormalBodyXSmall,
                                      ),
                                      vSpace,
                                      SizedBox(
                                        height: 150.h,
                                        child: ListView.builder(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemCount:
                                              4 /*controller
                                                      .picturesList.length +
                                                  1*/
                                          ,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return index ==
                                                    3 /*controller
                                                      .picturesList.length +
                                                  1*/
                                                ? Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    width: 400.w,
                                                    height: 100.h,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            AppColor.alphaGrey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: const Icon(Icons
                                                        .add_a_photo_outlined),
                                                  )
                                                : Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    width: 400.w,
                                                    height: 100.h,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            AppColor.alphaGrey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Image.asset(
                                                        'assets/images/redCar.png'),
                                                  );
                                          },
                                        ),
                                      ),
                                      vSpace,
                                      Button(
                                        buttonText: "Submit",
                                        textColor: AppColor.whiteColor,
                                        color: AppColor.primaryBlueDarkColor,
                                        onTap: () {
                                          //unfocus
                                        },
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
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ),
        );
      },
    );
  }

  getTextField(
      {required String title,
      required TextEditingController controller,
      TextInputType keyBoardType = TextInputType.text}) {
    return MyTextField(
      fillColor: AppColor.alphaGrey,
      hintText: title,
      leftPadding: 0,
      rightPadding: 0,
      keyboardType: keyBoardType,
      labelText: title,
      controller: controller,
      validator: (string) {
        if (string == null || string.isEmpty) {
          return 'Enter ${title}';
        }
        return null;
      },
    );
  }
}
