import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/styles.dart';

class HotDealsCard extends StatelessWidget {
  final String? carName;
  final String? carPrice;
  final String? carSeats;
  final ImageProvider? image;

  HotDealsCard({this.carName, this.carPrice, this.image, this.carSeats});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
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
            Container(
              height: 110.h,
              width: 160.h,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: image!,
                fit: BoxFit.fill,
              )),
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
                      children: [
                        Text(
                          carName!,
                          style: AppTextStyles.textStyleBoldBodyMedium
                              .copyWith(color: AppColor.blackColor),
                        ),
                        Text(
                          carSeats!,
                          style: AppTextStyles.textStyleNormalBodySmall
                              .copyWith(color: AppColor.greyColor),
                        ),
                      ],
                    ),
                    RatingBarIndicator(
                      rating: 4,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 20.0,
                      direction: Axis.horizontal,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              carPrice!,
                              style: AppTextStyles.textStyleBoldBodyMedium
                                  .copyWith(color: const Color(0xffF6BC29)),
                            ),
                            Text(
                              "Hour",
                              style: AppTextStyles.textStyleNormalBodyMedium
                                  .copyWith(
                                color: const Color(0xff0088FF),
                              ),
                            ),
                          ],
                        ),
                        MaterialButton(
                            height: 20.h,
                            minWidth: 20.w,
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
                            onPressed: () {})
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
