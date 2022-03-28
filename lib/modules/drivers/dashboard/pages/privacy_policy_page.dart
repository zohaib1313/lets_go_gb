import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/privacy_policy_controller.dart';

import '../../utils/utils.dart';

class PrivacyPolicyPage extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyPage({Key? key}) : super(key: key);
  static const id = '/PrivacyPolicyPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: 'Privacy Policy', goBack: true),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: GetX<PrivacyPolicyController>(
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
