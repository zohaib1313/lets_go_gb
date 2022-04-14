import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/admin/controller/admin_view_all_users_controller.dart';

class AdminViewAllUsersMobile extends GetView<AdminViewAllUsersController> {
  const AdminViewAllUsersMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetX<AdminViewAllUsersController>(
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
