import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/admin_dashboard_home_controller.dart';

class AdminDashboardHomeWeb extends GetView<AdminDashBoardHomeController> {
  const AdminDashboardHomeWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetX<AdminDashBoardHomeController>(
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
