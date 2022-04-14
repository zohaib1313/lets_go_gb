import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/admin_view_all_drivers_controller.dart';

class AdminViewAllDriversMobile extends GetView<AdminViewAllDriversController> {
  const AdminViewAllDriversMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetX<AdminViewAllDriversController>(
            initState: (state) {},
            builder: (context) {
              controller.temp.value;
              return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  ));
            }),
      ),
    );
  }
}
