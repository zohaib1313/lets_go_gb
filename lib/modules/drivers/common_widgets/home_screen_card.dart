import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/styles.dart';

class HomeScreenCard extends StatelessWidget {
  final ImageProvider? image;
  final String? text;
  final String? btnText;

  HomeScreenCard({this.image, this.text, this.btnText});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      child: Card(
        elevation: 1,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 250.h,
          //column as child
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 180.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: image!,
                    // image: AssetImage('assets/icons/sceneOne.png'),
                    fit: BoxFit.fill,
                  ),
                  // shape: BoxShape.circle,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 25.w,
                  right: 25.w,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        text!,
                        style: AppTextStyles.textStyleBoldBodySmall,
                      ),
                      MaterialButton(
                          height: 35.h,
                          child: Text(
                            btnText!,
                            style: AppTextStyles.textStyleNormalBodySmall
                                .apply(color: AppColor.whiteColor),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          // color: const Color(0xff0088FF),
                          color: AppColor.primaryBlueColor,
                          onPressed: () {})
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
