import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/driver_notifications_controller.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';

class DriverNotificationsPage extends GetView<DriverNotificationsController> {
  const DriverNotificationsPage({Key? key}) : super(key: key);
  static const id = '/DriverNotificationsPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: 'Notifications', goBack: true),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: GetX<DriverNotificationsController>(
            initState: (state) {},
            builder: (context) {
              controller.temp.value;
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
