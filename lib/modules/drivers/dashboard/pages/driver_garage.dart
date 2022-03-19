import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/driver_garage_controller.dart';

class DriverGarage extends GetView<DriverGarageController> {
  const DriverGarage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GetX(
      initState: (state) {},
      builder: (_) {
        return Scaffold(
          body: Container(),
        );
      },
    ));
  }
}
