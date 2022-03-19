import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/driver_dashboard_controller.dart';

class DriverGarage extends GetView<DriverDashBoardController> {
  const DriverGarage({Key? key}) : super(key: key);
  static const id = '/DriverGarage';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GetX<DriverDashBoardController>(
      initState: (state) {},
      builder: (_) {
        controller.temp.value;
        return Scaffold(
          body: Container(),
        );
      },
    ));
  }
}
