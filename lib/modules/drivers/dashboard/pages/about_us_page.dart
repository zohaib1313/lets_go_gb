import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/about_us_controller.dart';
import 'package:simple_rich_text/simple_rich_text.dart';

import '../../common_widgets/loading_widget.dart';
import '../../utils/firebase_paths.dart';
import '../../utils/styles.dart';
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
                return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection(FirebasePathNodes.appConstants)
                            .doc('AboutUs')
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
                            s['AboutUs'] ?? "",
                            style: AppTextStyles.textStyleNormalBodySmall,
                          );
                        },
                      ),
                    ));
              }),
        ),
      ),
    );
  }
}
