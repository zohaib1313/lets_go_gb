import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';
import 'package:simple_rich_text/simple_rich_text.dart';

import '../../common_widgets/loading_widget.dart';
import '../../utils/firebase_paths.dart';
import '../../utils/styles.dart';
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
                return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection(FirebasePathNodes.appConstants)
                            .doc('ContactUs')
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
                          if (snapshot.data?.data() == null) {
                            return const Center(
                              child: Text('Something went wrong'),
                            );
                          }
                          var s = snapshot.data!.data() as Map<String, dynamic>;
                          return SimpleRichText(
                            s['ContactUs'] ?? "",
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
