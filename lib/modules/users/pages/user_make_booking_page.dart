import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:intl/intl.dart';
import 'package:let_go_gb/modules/drivers/dashboard/models/vehicle_model.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../drivers/common_widgets/loading_widget.dart';
import '../../drivers/utils/common_widgets.dart';
import '../../drivers/utils/styles.dart';
import '../controllers/user_make_booking_controller.dart';

class UserMakeBookingPage extends GetView<UserMakeBookingController> {
  UserMakeBookingPage({Key? key}) : super(key: key);
  static const id = '/UserMakeBookingPage';
  static var vSpace = SizedBox(height: 20.h);
  static var hSpace = SizedBox(width: 50.w);
  VehicleModel vehicleModel = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: 'Book Your Ride', goBack: true, actions: [
        /*   MyAnimSearchBar(
          width: MediaQuery.of(context).size.width,
          onSuffixTap: () {},
          closeSearchOnSuffixTap: true,
          textController: controller.searchController,
        ),*/
      ]),
      body: SafeArea(
        child: GetX<UserMakeBookingController>(
          initState: (state) {
            controller.makeCalculations(double.parse(vehicleModel.rent ?? "1"));
          },
          builder: (ctx) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Choose Pickup Location',
                              style: AppTextStyles.textStyleBoldSubTitleLarge,
                            ),
                            vSpace,
                            InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlacePicker(
                                      apiKey: Platform.isAndroid
                                          ? "AIzaSyC4nZiFzeJMnGFLS00_ANKqTT8nfcZUGSE"
                                          : "YOUR IOS API KEY",
                                      onPlacePicked: (result) {
                                        printWrapped(result.toString());
                                        // result.geometry.location.lat
                                      },
                                      initialPosition: const LatLng(223, 444.3),
                                      useCurrentLocation: true,
                                    ),
                                  ),
                                );
                                controller.locationPickController.text =
                                    'Location set';
                                controller.locationChanged.value = true;
                              },
                              child: getTextField(
                                  controller: controller.locationPickController,
                                  enabled: false,
                                  suffixIcon: controller.locationChanged.value
                                      ? const Icon(Icons.done_all,
                                          color: AppColor.greenColor)
                                      : null,
                                  title: 'Location'),
                            ),
                            vSpace,
                            /*  SizedBox(
                              height: MediaQuery.of(context).size.height * 0.37,
                              child: Container(
                                color: AppColor.greenColor,
                                child: getMap(),

                                ///show pickup location
                              ),
                            ),*/
                            Text(
                              'Enter Details',
                              style: AppTextStyles.textStyleBoldSubTitleLarge,
                            ),
                            vSpace,
                            vSpace,
                            InkWell(
                              onTap: () {
                                showMyTimePicker(
                                  context: context,
                                  onTimeSelected: ((value) {
                                    controller.startTimeController.text =
                                        value.toString();
                                  }),
                                );
                              },
                              child: getTextField(
                                  controller: controller.startTimeController,
                                  enabled: false,
                                  title: 'Pick Up Time'),
                            ),
                            vSpace,
                            InkWell(
                              onTap: () {
                                pickDateRange(
                                    context: context,
                                    initialRange: controller.dateTimeRange,
                                    onRangeSelect: (DateTimeRange range) {
                                      printWrapped(range.toString());
                                      controller.dateTimeRange = range;

                                      controller.days.value =
                                          controller.daysElapsedSince(
                                              range.start, range.end);

                                      controller.startDateController.text =
                                          "${DateFormat('dd-MM-yyyy').format(range.start)} | ${DateFormat('dd-MM-yyyy').format(range.end)}";

                                      controller.makeCalculations(double.parse(
                                          vehicleModel.rent ?? '1.0'));
                                    });
                              },
                              child: getTextField(
                                  controller: controller.startDateController,
                                  enabled: false,
                                  title: 'Pick up Dates'),
                            ),
                            vSpace,
                            getTextField(
                                controller: controller.addressController,
                                title: 'Address'),
                            vSpace,
                            getTextField(
                                controller: controller.notesController,
                                minLines: 2,
                                maxLines: 3,
                                title: 'Notes'),
                            vSpace,
                            /*    _buildValueContainer(
                                title: 'For Days',
                                decrementTap: () {
                                  if (controller.days.value > 1) {
                                    controller.days--;
                                    controller.makeCalculations(
                                        double.parse(vehicleModel.rent ?? "1"));
                                  }
                                },
                                incrementTap: () {
                                  controller.days++;
                                  controller.makeCalculations(
                                      double.parse(vehicleModel.rent ?? "1"));
                                },
                                val: controller.days.value.toStringAsFixed(0)),*/
                            vSpace,
                            _buildValueContainer(
                                title: 'Passengers',
                                decrementTap: () {
                                  if (controller.passengers.value > 1) {
                                    controller.passengers--;
                                  }
                                },
                                incrementTap: () {
                                  controller.passengers++;
                                },
                                val: controller.passengers.value
                                    .toStringAsFixed(0)),
                            vSpace,
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DottedBorder(
                                color: AppColor.primaryBlueDarkColor,
                                dashPattern: const [10, 10, 10, 10],
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Billing',
                                        style: AppTextStyles
                                            .textStyleBoldTitleLarge,
                                      ),
                                      SizedBox(height: 10.h),
                                      Text(
                                        "Company request you pay 20% advance of your total billing to insure your reservation and avoid any kind of fraud.",
                                        style: AppTextStyles
                                            .textStyleNormalBodyXSmall,
                                      ),
                                      vSpace,
                                      Row(
                                        children: [
                                          const Expanded(
                                              child: Text('Rent per day')),
                                          Text(
                                              '${controller.days} x ${vehicleModel.rent}')
                                        ],
                                      ),
                                      vSpace,
                                      Row(
                                        children: [
                                          const Expanded(child: Text('Total')),
                                          Text(
                                              '${controller.totalPrice.value} (PKR)')
                                        ],
                                      ),
                                      vSpace,
                                      Text(
                                        "You will will have to submit  ${controller.twentyPercentOfTax.value} (PKR)' advance for securing reservation",
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles
                                            .textStyleNormalBodyXSmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {
                        if (controller.formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          controller.makeReservation(vehicleModel.id ?? '');
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        decoration: const BoxDecoration(
                            color: AppColor.primaryBlueColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(28),
                                bottomLeft: Radius.circular(28))),
                        child: Shimmer.fromColors(
                          period: const Duration(milliseconds: 5500),
                          baseColor: AppColor.whiteColor,
                          highlightColor: Colors.black,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 18.0, bottom: 18),
                            child: Text(
                              "Make Reservation",
                              style: AppTextStyles.textStyleBoldBodyMedium
                                  .copyWith(color: AppColor.whiteColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (controller.isLoading.value) LoadingWidget(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  getTextField(
      {required TextEditingController controller,
      required String title,
      int minLines = 1,
      Widget? suffixIcon,
      int maxLines = 1,
      bool? enabled = true}) {
    return MyTextField(
      controller: controller,
      leftPadding: 0,
      enable: enabled,
      maxLines: maxLines,
      minLines: minLines,
      rightPadding: 0,
      hintText: title,
      focusBorderColor: AppColor.alphaGrey,
      textColor: AppColor.blackColor,
      hintColor: AppColor.blackColor,
      fillColor: AppColor.alphaGrey,
      suffixIconWidet: suffixIcon,
      validator: (string) {
        if ((string ?? "").isEmpty) {
          return 'Required';
        }
        return null;
      },
    );
  }

  Widget _buildValueContainer(
      {required VoidCallback decrementTap,
      required String title,
      required VoidCallback incrementTap,
      required String val}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.textStyleBoldBodyMedium,
          ),
        ),
        hSpace,
        GestureDetector(
          onTap: incrementTap,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColor.primaryBlueDarkColor)),
            child: const Icon(
              Icons.add,
              size: 18,
            ),
          ),
        ),
        hSpace,
        Text(
          val,
          style: const TextStyle(fontSize: 16),
        ),
        hSpace,
        GestureDetector(
          onTap: decrementTap,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColor.primaryBlueDarkColor)),
            child: const Icon(Icons.remove, size: 18),
          ),
        ),
      ],
    );
  }

/*  getMap() {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(51.5, -0.09),
        zoom: 13.0,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
          attributionBuilder: (_) {
            return Text("© OpenStreetMap contributors");
          },
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(51.5, -0.09),
              builder: (ctx) => Container(
                child: Icon(Icons.location_on),
              ),
            ),
          ],
        ),
      ],
    );
  }*/
}
