import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';

import '../controllers/contact_us_controller.dart';

class ContactUsPage extends GetView<ContactUsController> {
  const ContactUsPage({Key? key}) : super(key: key);
  static const id = '/ContactUsPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: 'Contact Us', goBack: true),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: GetX<ContactUsController>(
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
