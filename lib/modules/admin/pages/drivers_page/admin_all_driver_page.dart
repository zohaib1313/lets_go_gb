// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/admin/controller/admin_view_all_drivers_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/models/driver_user_model.dart';
import 'package:let_go_gb/modules/drivers/utils/common_widgets.dart';

import '../../../drivers/common_widgets/loading_widget.dart';
import '../../../drivers/utils/app_user_roles.dart';
import '../../../drivers/utils/firebase_paths.dart';
import '../../../drivers/utils/my_app_bar.dart';
import '../../../drivers/utils/styles.dart';
import '../../../drivers/utils/utils.dart';

class AdminAllDriversPage extends GetView<AdminViewAllDriversController> {
  static const id = '/AdminAllDriversPage';

  AdminAllDriversPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: myAppBar(title: "Drivers", goBack: false, actions: [
        MyAnimSearchBar(
          width: context.width * 0.8,
          onSuffixTap: () {
            controller.searchController.clear();
          },
          closeSearchOnSuffixTap: true,
          textController: controller.searchController,
        ),
      ]),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: GetX<AdminViewAllDriversController>(initState: (state) {
            controller.searchController.clear();
            controller.searchController.addListener(() {
              controller.searchFromList();
            });
          }, builder: (context) {
            controller.isLoading.value;

            ///temp
            return Stack(
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(FirebasePathNodes.users)
                        .where("userRole", isEqualTo: AppUserRoles.driver)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text(
                          'Something went wrong',
                          style: AppTextStyles.textStyleBoldBodyMedium,
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return LoadingWidget();
                      }
                      if (snapshot.data != null) {
                        controller.filteredItemList.clear();

                        for (var document in snapshot.data!.docs) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          DriverUserModel model = DriverUserModel.fromMap(data);
                          controller.filteredItemList.add(model);
                        }
                        if (controller.allItemList.isEmpty) {
                          controller.allItemList
                              .addAll(controller.filteredItemList);
                        }
                        return Obx(() => ListView.builder(
                            itemCount: controller.filteredItemList.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  /*Get.toNamed(UserVehicleDetailPage.id,
                                      arguments:
                                      controller.filteredItemList[index]?.id ??
                                          '');*/
                                },
                                child: driverInfoCard(
                                    model: controller.filteredItemList[index]!),
                              );
                            }));
                      }
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'No Driver Found',
                              style: AppTextStyles.textStyleBoldBodyMedium,
                            ),
                          ],
                        ),
                      );
                    }),
                // if (controller.isLoading.isTrue) LoadingWidget()
              ],
            );
          }),
        ),
      ),
    );
  }

  driverInfoCard({required DriverUserModel model}) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: NetworkCircularImage(
                url: model.profileImage ?? '',
                radius: 20,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.firstName ?? '-',
                    style: AppTextStyles.textStyleBoldBodyMedium,
                  ),
                  Text(
                    model.emailAddress ?? '-',
                    style: AppTextStyles.textStyleNormalBodySmall,
                  ),
                  Text(
                    model.phone ?? '-',
                    style: AppTextStyles.textStyleNormalBodySmall,
                  ),
                  Text(
                    model.address ?? '-',
                    style: AppTextStyles.textStyleNormalBodySmall,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  'Account Status: ',
                  style: AppTextStyles.textStyleNormalBodySmall,
                ),
                Transform.scale(
                  scale: 0.8,
                  child: CupertinoSwitch(
                    value: model.isActive ?? false,
                    onChanged: (value) {
                      controller.changeDriverAccountStatus(model: model);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
