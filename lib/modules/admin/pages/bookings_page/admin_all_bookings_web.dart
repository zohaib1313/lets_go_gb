import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/admin_view_all_bookings_controller.dart';

class AdminViewAllBookingsWeb extends GetView<AdminViewAllBookingsController> {
  const AdminViewAllBookingsWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetX<AdminViewAllBookingsController>(
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
