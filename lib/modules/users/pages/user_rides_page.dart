import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/vehicle_info_Card.dart';
import 'package:let_go_gb/modules/drivers/dashboard/models/vehicle_model.dart';
import 'package:let_go_gb/modules/drivers/utils/firebase_paths.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';
import 'package:let_go_gb/modules/users/controllers/user_rides_controller.dart';
import 'package:let_go_gb/modules/users/pages/user_vehicle_details_page.dart';

import '../../drivers/utils/my_app_bar.dart';
import '../../drivers/utils/styles.dart';

class UserRidesPage extends GetView<UserRideController> {
  const UserRidesPage({Key? key}) : super(key: key);
  static const id = '/UserRidesPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: 'Rides For You', goBack: false, actions: [
        MyAnimSearchBar(
          width: MediaQuery.of(context).size.width,
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
          child: GetX<UserRideController>(initState: (state) {
            controller.searchController.clear();
            controller.searchController.addListener(() {
              controller.searchFromList();
            });
          }, builder: (context) {
            controller.temp.value;
            return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(FirebasePathNodes.vehicles)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text(
                      'Something went wrong',
                      style: AppTextStyles.textStyleBoldBodyMedium,
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data != null) {
                    controller.filteredItemList.clear();

                    for (var document in snapshot.data!.docs) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      VehicleModel vehicleModel = VehicleModel.fromMap(data);
                      controller.filteredItemList.add(vehicleModel);
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
                              Get.toNamed(UserVehicleDetailPage.id,
                                  arguments:
                                      controller.filteredItemList[index]?.id ??
                                          '');
                            },
                            child: VehicleInfoCard(
                              vehicleModel: controller.filteredItemList[index]!,
                            ),
                          );
                        }));
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'No Vehicle Found',
                          style: AppTextStyles.textStyleBoldBodyMedium,
                        ),
                      ],
                    ),
                  );
                });
          }),
        ),
      ),
    );
  }
}
