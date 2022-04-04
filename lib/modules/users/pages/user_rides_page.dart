import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/hot_deals_card.dart';
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
          onSuffixTap: () {},
          closeSearchOnSuffixTap: true,
          textController: controller.searchController,
        ),
      ]),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: GetX<UserRideController>(
              initState: (state) {},
              builder: (context) {
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
                        return ListView(
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          VehicleModel vehicleModel =
                              VehicleModel.fromMap(data);
                          return InkWell(
                            onTap: () {
                              Get.toNamed(UserVehicleDetailPage.id,
                                  arguments: vehicleModel.id ?? '');
                            },
                            child: VehicleInfoCard(
                              vehicleModel: vehicleModel,
                            ),
                          );
                        }).toList());
                        /*ListView.builder(
                            itemCount: 10,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Get.toNamed(UserVehicleDetailPage.id,
                                      arguments:
                                          'oDXXhEg91AOx57AVX0dWndHRK5j1');
                                },
                                child: const VehicleInfoCard(
                                  carName: "Toyota Land Cruiser",
                                  carPrice: "PKR 1000/",
                                  carSeats: "4 Seats",
                                  image: AssetImage("assets/images/redCar.png"),
                                ),
                              );
                            });*/
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
