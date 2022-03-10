import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/controllers/search_controller.dart';
import 'package:let_go_gb/utils/common_widgets.dart';
import 'package:let_go_gb/utils/styles.dart';

class SearchDriverScreen extends GetView<SearchScreenDriverController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5).withOpacity(0.3),
      body: Container(
        padding: EdgeInsets.only(
          left: 50.w,
          right: 50.w,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 15.h,
              ),
              MyTextField(
                leftPadding: 0,
                rightPadding: 0,
                hintText: "Search Cars, Location...",
                suffixIcon: "assets/icons/ic_search.svg",
                focusBorderColor: AppColor.primaryBlueDarkColor,
                textColor: AppColor.blackColor,
                hintColor: AppColor.blackColor,
                fillColor: AppColor.whiteColor,
                validator: (string) {
                  if (string == null || string.isEmpty) {
                    return 'Enter Email';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 25.h,
              ),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: AppColor.whiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(


                          decoration: const BoxDecoration(

                              image: DecorationImage(
                            image: AssetImage("assets/images/blueCar.png"),
                            fit: BoxFit.fill,
                          ),
                          ),
                          height: 130.h,
                        ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Toyota Prado Land Cruiser",
                              style: AppTextStyles.textStyleBoldBodySmall
                                  .copyWith(color: AppColor.blackColor),
                            ),
                            Text(
                              "4 Seats",
                              style:
                              AppTextStyles.textStyleNormalBodySmall.copyWith(
                                color: const Color(0xff0088FF),
                              ),
                            ),
                            Text(
                              "PKR 3000/-",
                              style: AppTextStyles.textStyleBoldBodySmall
                                  .copyWith(color: const Color(0xffF6BC29)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Daily",
                                  style: AppTextStyles.textStyleNormalBodySmall
                                      .copyWith(color: AppColor.blackColor),
                                ),
                                Row(
                                  children: [
                                    SvgViewer(
                                        width: double.infinity,
                                        height: 20.h,
                                        svgPath: "assets/icons/star.svg"),
                                    Text(
                                      "5.0",
                                      style: AppTextStyles.textStyleNormalBodyXSmall
                                          .copyWith(color: AppColor.greyColor),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
