import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/loading_widget.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/privacy_policy_controller.dart';
import 'package:let_go_gb/modules/drivers/utils/firebase_paths.dart';
import 'package:let_go_gb/modules/drivers/utils/styles.dart';
import 'package:simple_rich_text/simple_rich_text.dart';

import '../../utils/utils.dart';

class PrivacyPolicyPage extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyPage({Key? key}) : super(key: key);
  static const id = '/PrivacyPolicyPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: 'Privacy Policy', goBack: true),
      body: SafeArea(
        child: GetX<PrivacyPolicyController>(
            initState: (state) {},
            builder: (context) {
              controller.temp.value;
              return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(FirebasePathNodes.appConstants)
                          .doc('PrivacyPolicy')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return LoadingWidget();
                        }
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Something went wrong'),
                          );
                        }
                        if (snapshot.data!.data() == null) {
                          return const Center(
                            child: Text('Something went wrong'),
                          );
                        }
                        var s = snapshot.data!.data() as Map<String, dynamic>;
                        return SimpleRichText(
                          s['PrivacyPolicy'],
                          style: AppTextStyles.textStyleNormalBodySmall,
                        );
                      },
                    ),
                  ));
            }),
      ),
    );
  }
}
