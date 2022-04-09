import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/common/controller/notification_controller.dart';
import 'package:let_go_gb/common/models/notification_model.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/loading_widget.dart';
import 'package:let_go_gb/modules/drivers/utils/firebase_paths.dart';
import 'package:let_go_gb/modules/drivers/utils/styles.dart';
import 'package:let_go_gb/modules/drivers/utils/user_defaults.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';

import '../../utils/Utils.dart';

class NotificationsPage extends GetView<NotificationsController> {
  const NotificationsPage({Key? key}) : super(key: key);
  static const id = '/NotificationsPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: 'Notifications', goBack: true),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: GetX<NotificationsController>(
            initState: (state) {},
            builder: (context) {
              controller.temp.value;
              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(FirebasePathNodes.notifications)
                    .where('toId', isEqualTo: UserDefaults.getCurrentUserId())
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LoadingWidget();
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Something went wrong',
                        style: AppTextStyles.textStyleBoldBodyMedium,
                      ),
                    );
                  }

                  if ((snapshot.data?.docs.length ?? 0) < 1) {
                    return Center(
                      child: Text('No recent notification',
                          style: AppTextStyles.textStyleBoldBodyMedium),
                    );
                  }

                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      NotificationModel notificationModel =
                          NotificationModel.fromMap(data);
                      return Card(
                        color: (notificationModel.isRead ?? false)
                            ? AppColor.whiteColor
                            : AppColor.alphaGrey,
                        elevation: 10,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(15),
                          title: Text(notificationModel.title ?? ''),
                          subtitle: Text(notificationModel.body ?? ''),
                          trailing: Text(
                            AppUtils.readTimestamp(
                                DateTime.parse(notificationModel.time!)
                                    .toLocal()
                                    .millisecondsSinceEpoch),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
