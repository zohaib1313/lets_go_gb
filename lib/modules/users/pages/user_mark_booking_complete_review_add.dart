import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/common/models/booking_model.dart';

import '../../drivers/utils/utils.dart';
import '../controllers/UserMarkBookingCompleteReviewAddController.dart';

class UserMarkBookingCompleteReviewAddPage
    extends GetView<UserMarkBookingCompleteReviewAddController> {
  UserMarkBookingCompleteReviewAddPage({Key? key}) : super(key: key);
  static const id = '/UserMarkBookingCompleteReviewAddPage';

  BookingModel? bookingModel = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: 'Tell us how it went?', goBack: true),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: GetX<UserMarkBookingCompleteReviewAddController>(
              initState: (state) {},
              builder: (context) {
                controller.temp.value;
                return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Container(),
                    ));
              }),
        ),
      ),
    );
  }
}
