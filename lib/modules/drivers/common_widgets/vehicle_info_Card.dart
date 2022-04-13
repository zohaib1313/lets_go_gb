import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:let_go_gb/common/reviews_model.dart';
import 'package:let_go_gb/modules/drivers/dashboard/models/vehicle_model.dart';
import 'package:let_go_gb/modules/drivers/utils/common_widgets.dart';
import 'package:let_go_gb/modules/drivers/utils/firebase_paths.dart';

import '../../users/pages/user_vehicle_details_page.dart';
import '../utils/styles.dart';

class VehicleInfoCard extends StatelessWidget {
  VehicleModel vehicleModel;

  VehicleInfoCard({Key? key, required this.vehicleModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 10,
      child: Container(
        // height: 130.h,
        width: MediaQuery.of(context).size.width,

        padding: EdgeInsets.only(
          top: 10.h,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 10.w,
            ),
            /*Container(
              height: 110.h,
              width: 160.h,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: image!,
                fit: BoxFit.fill,
              )),
            ),*/
            NetworkPlainImage(
              url: vehicleModel.vehicleImages?[0],
              height: 110.h,
              width: 160.h,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            vehicleModel.vehicleName ?? '',
                            style: AppTextStyles.textStyleBoldBodyMedium
                                .copyWith(color: AppColor.blackColor),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            ('Seating Capacity ${vehicleModel.seatingCapacity ?? ''}'),
                            textAlign: TextAlign.center,
                            style: AppTextStyles.textStyleNormalBodySmall
                                .copyWith(color: AppColor.greyColor),
                          ),
                        ),
                      ],
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection(FirebasePathNodes.reviews)
                            .where("driverId", isEqualTo: vehicleModel.id)
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          double ratings = 0.0;
                          if (snapshot.data?.docs != null) {
                            if (snapshot.data!.docs.isNotEmpty) {
                              for (var element in snapshot.data!.docs) {
                                ReviewModel reviewModel = ReviewModel.fromMap(
                                    element.data() as Map<String, dynamic>);
                                ratings += reviewModel.ratings ?? 0.0;
                              }
                            }
                          }
                          return RatingBarIndicator(
                            rating: ratings,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          );
                        }),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                ('RS: ${vehicleModel.rent ?? ''}'),
                                style: AppTextStyles.textStyleBoldBodyMedium
                                    .copyWith(color: const Color(0xffF6BC29)),
                              ),
                              Text(
                                " /Day",
                                style: AppTextStyles.textStyleNormalBodyMedium
                                    .copyWith(
                                  color: const Color(0xff0088FF),
                                ),
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                            height: 20.h,
                            minWidth: 420.w,
                            padding: const EdgeInsets.all(7),
                            child: Text(
                              "Book",
                              style: AppTextStyles.textStyleNormalBodySmall
                                  .apply(color: AppColor.whiteColor),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            // color: const Color(0xff0088FF),
                            color: AppColor.primaryBlueColor,
                            onPressed: () {
                              Get.toNamed(UserVehicleDetailPage.id,
                                  arguments: vehicleModel.id ?? '');
                            })
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
