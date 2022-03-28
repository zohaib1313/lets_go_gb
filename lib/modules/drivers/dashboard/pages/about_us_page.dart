import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/about_us_controller.dart';

import '../../utils/utils.dart';

class AboutUsPage extends GetView<AboutUsController> {
  const AboutUsPage({Key? key}) : super(key: key);
  static const id = '/AboutUsPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: 'About Us', goBack: true),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: GetX<AboutUsController>(
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
