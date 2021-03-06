import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/common/models/chat_user_model.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/loading_widget.dart';
import 'package:let_go_gb/modules/drivers/dashboard/models/driver_user_model.dart';
import 'package:let_go_gb/modules/drivers/dashboard/models/vehicle_model.dart';
import 'package:let_go_gb/modules/drivers/utils/firebase_paths.dart';
import 'package:let_go_gb/modules/drivers/utils/styles.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';
import 'package:let_go_gb/modules/users/models/user_model.dart';
import 'package:let_go_gb/modules/users/pages/user_make_booking_page.dart';
import 'package:let_go_gb/utils/Utils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../common/pages/chat_screen.dart';
import '../../../common/reviews_model.dart';
import '../../drivers/utils/common_widgets.dart';
import '../controllers/user_vehicle_details_controller.dart';

// ignore: must_be_immutable
class UserVehicleDetailPage extends GetView<UserVehicleDetailsController> {
  UserVehicleDetailPage({Key? key}) : super(key: key);
  static const id = '/UserVehicleDetailPage';
  final vSpace = SizedBox(height: 20.h);
  final hSpace = SizedBox(height: 20.h);
  String vehicleId = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return GetX<UserVehicleDetailsController>(
      initState: (state) {
        /*  Future.delayed(
          const Duration(seconds: 2),
          () {},
        );*/
      },
      builder: (_) {
        controller.temp.value;
        return Scaffold(
          appBar: myAppBar(goBack: true, title: 'Vehicle', actions: []),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.all(10.h),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(FirebasePathNodes.vehicles)
                      .doc(vehicleId)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: LoadingWidget());
                    }
                    if (snapshot.data?.data() != null) {
                      VehicleModel vehicleModel = VehicleModel.fromMap(
                          snapshot.data!.data() as Map<String, dynamic>);
                      return Stack(
                        children: [
                          vehicleDetails(
                            vehicleModel: vehicleModel,
                          ),
                          _slidingPanel(context, vehicleModel),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () {
                                if (controller.driverModel != null) {
                                  Get.toNamed(UserMakeBookingPage.id,
                                      arguments: [
                                        vehicleModel,
                                        controller.driverModel
                                      ]);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 5),
                                decoration: const BoxDecoration(
                                    color: AppColor.primaryBlueColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(28),
                                        bottomLeft: Radius.circular(28))),
                                child: Shimmer.fromColors(
                                  period: const Duration(milliseconds: 5500),
                                  baseColor: AppColor.whiteColor,
                                  highlightColor: Colors.black,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 18.0, bottom: 18),
                                    child: Text(
                                      "Book Now",
                                      style: AppTextStyles
                                          .textStyleBoldBodyMedium
                                          .copyWith(color: AppColor.whiteColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
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
                  }),
            ),
          ),
        );
      },
    );
  }

  vehicleDetails({required VehicleModel vehicleModel}) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CarouselSlider(
            options: CarouselOptions(autoPlay: true, enlargeCenterPage: true),
            items: vehicleModel.vehicleImages

                ///these will be the images in vehicle
                ?.map(
                  (item) => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Center(
                      child: NetworkPlainImage(
                        height: 300.h,
                        width: 1500.w,
                        fit: BoxFit.cover,
                        url: item,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          vSpace,
          vSpace,
          Text(
            vehicleModel.vehicleName ?? '',
            style: AppTextStyles.textStyleBoldSubTitleLarge,
          ),
          vSpace,
          Text(
            vehicleModel.descriptionNote ?? '',
            style: AppTextStyles.textStyleNormalBodySmall,
          ),
          vSpace,
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.h),
            decoration: BoxDecoration(
                color: AppColor.blackColor,
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Shimmer.fromColors(
                period: const Duration(milliseconds: 4500),
                baseColor: Colors.white,
                highlightColor: Colors.black54,
                child: Column(
                  children: [
                    Text('Rent / Day',
                        style: AppTextStyles.textStyleBoldBodyMedium),
                    Text('Rs. ${vehicleModel.rent ?? ''}',
                        style: AppTextStyles.textStyleBoldBodyXSmall),
                  ],
                ),
              ),
            ),
          ),
          vSpace,
          Text(
            ///these are specifications which driver will add , for example, make, maker, milage, etc
            'Specifications',
            style: AppTextStyles.textStyleBoldSubTitleLarge,
          ),
          vSpace,
          Wrap(
            children: [
              getSpecificationItem(
                  value: vehicleModel.transmissionType ?? '',
                  title: 'Transmission'),
              getSpecificationItem(
                  value: vehicleModel.mileage ?? '', title: 'Mileage / liter'),
              getSpecificationItem(
                  value: vehicleModel.seatingCapacity ?? '',
                  title: 'Seating Capacity'),
              getSpecificationItem(
                  value: vehicleModel.make ?? '', title: 'Make'),
              getSpecificationItem(
                  value: vehicleModel.maker ?? '', title: 'Maker'),
            ],
          ),
          vSpace,
          Text(
            ///features that driver will add while adding a vehicle
            'Features',
            style: AppTextStyles.textStyleBoldSubTitleLarge,
          ),
          vSpace,
          SizedBox(
            height: 80.h,
            child: ListView.builder(
                itemCount: vehicleModel.features?.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return getSpecificationItem(
                      height: 50.h, value: vehicleModel.features![index]);
                }),
          ),
          vSpace,
          vSpace,
          vSpace,
          vSpace,
          vSpace,
          vSpace,
          vSpace,
          vSpace,
        ],
      ),
    );
  }

  getSpecificationItem({double? height, String? title, required String value}) {
    return Container(
      height: height ?? 100.h,
      margin: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.h),
      decoration: BoxDecoration(
          color: AppColor.alphaGrey, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (title != null)
              Text(title, style: AppTextStyles.textStyleNormalBodyXSmall),
            Text(value, style: AppTextStyles.textStyleBoldBodyXSmall),
          ],
        ),
      ),
    );
  }

  SlidingUpPanel _slidingPanel(
      BuildContext context, VehicleModel vehicleModel) {
    return SlidingUpPanel(
        color: Colors.transparent,
        minHeight: MediaQuery.of(context).size.height * (0.10),
        maxHeight: MediaQuery.of(context).size.height * (1),
        panelBuilder: (ScrollController _scrollController) {
          return Container(
            margin: const EdgeInsetsDirectional.only(
                start: 5, end: 20, top: 14, bottom: 8),
            decoration: const BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Column(
              children: [
                // Path 45
                Container(
                    width: 70,
                    height: 8,
                    margin: const EdgeInsets.only(bottom: 12, top: 12),
                    decoration: const BoxDecoration(
                        color: AppColor.alphaGrey,
                        borderRadius: BorderRadius.all(Radius.circular(4.0)))),

                ///views
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 100.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          vSpace,
                          Text('Driver',
                              style: AppTextStyles.textStyleBoldTitleLarge),
                          vSpace,
                          _userDetails(vehicleModel),
                          vSpace,
                          _reviews(vehicleModel)
                          // _reviews(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
        onPanelOpened: () {});
  }

  _userDetails(VehicleModel vehicleModel) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(FirebasePathNodes.users)
            .doc(vehicleModel.id ?? '') //vehicle id and driver id is same
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Something went wrong',
                style: AppTextStyles.textStyleBoldBodyMedium,
              ),
            );
          }

          if (snapshot.data?.data() != null) {
            DriverUserModel? userModel = DriverUserModel.fromMap(
                snapshot.data!.data() as Map<String, dynamic>);
            controller.driverModel = userModel;
            return Container(
              padding: EdgeInsets.all(15.h),
              decoration: BoxDecoration(
                  color: AppColor.blackColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  NetworkCircularImage(
                    radius: 35,
                    url: userModel.profileImage ?? '',
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        userModel.firstName ?? '',
                        style: AppTextStyles.textStyleBoldBodyMedium
                            .copyWith(color: AppColor.whiteColor),
                      ),
                      InkWell(
                        onTap: () {
                          AppUtils.dialNumber(
                              phoneNumber: userModel.phone ?? '00',
                              context: context);
                        },
                        child: Text(
                          userModel.phone ?? '',
                          style: AppTextStyles.textStyleBoldBodySmall
                              .copyWith(color: AppColor.whiteColor),
                        ),
                      ),
                    ],
                  )),
                  hSpace,
                  InkWell(
                    onTap: () {
                      Get.toNamed(ChatScreen.id,
                          arguments: ChatUserModel(
                              otherUserId: userModel.id,
                              otherUserProfileImage: userModel.profileImage,
                              otherUserContact: userModel.phone,
                              otherUserName: userModel.firstName));
                    },
                    child: const Icon(
                      Icons.chat,
                      color: AppColor.whiteColor,
                    ),
                  ),
                  hSpace
                ],
              ),
            );
          } else {
            return Center(
              child: Text(
                'Something went wrong',
                style: AppTextStyles.textStyleBoldBodyMedium,
              ),
            );
          }
        });
  }

  Widget _reviews(VehicleModel vehicleModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Reviews', style: AppTextStyles.textStyleBoldSubTitleLarge),
        vSpace,
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(FirebasePathNodes.reviews)
                .where("driverId", isEqualTo: vehicleModel.id)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if ((snapshot.data?.docs ?? []).isNotEmpty) {
                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    ReviewModel reviewModel = ReviewModel.fromMap(data);
                    return _reviewRowItem(reviewModel);
                  }).toList(),
                );
              } else {
                return const Center(
                  child: Text("No Review"),
                );
              }

              /* return ListView.builder(
                  shrinkWrap: true,
                  itemCount: 20,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _reviewRowItem();
                  });*/
            }),
        vSpace,
        vSpace,
        vSpace,
        vSpace,
        vSpace,
        vSpace,
        vSpace,
        vSpace,
        vSpace,
        vSpace,
        vSpace,
        vSpace,
        vSpace,
      ],
    );
  }

  Widget _reviewRowItem(ReviewModel reviewModel) {
    return InkWell(
        onTap: () {},
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(FirebasePathNodes.users)
              .doc(reviewModel.userId)
              .snapshots(),
          builder: (contexxt, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong..!'));
            }

            if (snapshot.data?.data() != null) {
              UserModel? userModel = UserModel.fromMap(
                  snapshot.data!.data() as Map<String, dynamic>);
              return Card(
                margin:
                    const EdgeInsets.only(left: 0, right: 0, top: 3, bottom: 3),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NetworkCircularImage(
                        radius: 27,
                        url: userModel.profileImage ?? '',
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userModel.firstName ?? '-',
                            style: AppTextStyles.textStyleBoldBodyMedium,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5.h),
                              Row(
                                children: [
                                  Flexible(
                                    child: RatingBar.builder(
                                      initialRating: reviewModel.ratings ?? 0.0,
                                      minRating: 1,
                                      itemSize: 15,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      updateOnDrag: false,
                                      unratedColor: AppColor.alphaGrey,
                                      itemCount: 5,
                                      ignoreGestures: true,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 2.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                formatDateTime(DateTime.parse(
                                    reviewModel.dateTime ??
                                        DateTime.now().toString())),
                                maxLines: 2,
                                style: AppTextStyles.textStyleBoldBodyXSmall,
                              ),
                              Text(
                                reviewModel.reviewMessage ?? '-',
                                maxLines: 2,
                                style: AppTextStyles.textStyleNormalBodySmall,
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('No User Found..'));
            }
            return Container();
          },
        ));
  }
}
