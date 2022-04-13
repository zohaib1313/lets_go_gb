import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/common/models/booking_model.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/loading_widget.dart';
import 'package:let_go_gb/modules/drivers/utils/common_widgets.dart';
import 'package:let_go_gb/modules/drivers/utils/styles.dart';

import '../../drivers/utils/utils.dart';
import '../controllers/UserMarkBookingCompleteReviewAddController.dart';

class UserMarkBookingCompleteReviewAddPage
    extends GetView<UserMarkBookingCompleteReviewAddController> {
  UserMarkBookingCompleteReviewAddPage({Key? key}) : super(key: key);
  static const id = '/UserMarkBookingCompleteReviewAddPage';

  BookingModel? bookingModel = Get.arguments;
  static var vSpace = SizedBox(height: 20.h);
  static var hSpace = SizedBox(width: 50.w);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: 'Add your review', goBack: true),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: GetX<UserMarkBookingCompleteReviewAddController>(
              initState: (state) {
            controller.isLoading.value = false;
          }, builder: (context) {
            return Stack(
              children: [
                SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Center(
                        child: Form(
                          key: controller.formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Tell us how it went?',
                                style: AppTextStyles.textStyleBoldTitleLarge,
                              ),
                              RatingBar.builder(
                                initialRating: 0,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                updateOnDrag: false,
                                unratedColor: AppColor.primaryBlueColor,
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  controller.ratings.value = rating;
                                },
                              ),
                              vSpace,
                              MyTextField(
                                minLines: 5,
                                controller: controller.reviewTextController,
                                focusBorderColor: AppColor.primaryBlueDarkColor,
                                unfocusBorderColor: AppColor.primaryBlueColor,
                                maxLines: 15,
                                validator: (string) {
                                  if ((string ?? '').isEmpty) {
                                    return "Required";
                                  }
                                  return null;
                                },
                              ),
                              vSpace,
                              Button(
                                buttonText: "Mark Complete",
                                textStyle: AppTextStyles.textStyleBoldBodyMedium
                                    .copyWith(color: AppColor.whiteColor),
                                onTap: () {
                                  if (bookingModel != null &&
                                      controller.formKey.currentState!
                                          .validate()) {
                                    controller.markBookingComplete(
                                        booking: bookingModel!);
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
                if (controller.isLoading.value || bookingModel == null)
                  LoadingWidget(),
              ],
            );
          }),
        ),
      ),
    );
  }
}
