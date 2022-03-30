import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';
import 'package:let_go_gb/modules/users/controllers/user_rides_controller.dart';

class UserRidesPage extends GetView<UserRideController> {
  const UserRidesPage({Key? key}) : super(key: key);
  static const id = '/UserRidesPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: 'Rides For You', goBack: false),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: GetX<UserRideController>(
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
