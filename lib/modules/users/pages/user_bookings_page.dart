import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';
import 'package:let_go_gb/modules/users/controllers/user_booking_controller.dart';

class UserBookingPage extends GetView<UserBookingController> {
  const UserBookingPage({Key? key}) : super(key: key);
  static const id = '/UserBookingPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: 'Bookings', goBack: false),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: GetX<UserBookingController>(
              initState: (state) {},
              builder: (context) {
                controller.temp.value;
                return Container();
              }),
        ),
      ),
    );
  }
}
