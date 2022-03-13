import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:let_go_gb/modules/drivers/utils/styles.dart';

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
          height: 220.h,
          //column as child
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: image!,
                // image: AssetImage('assets/icons/sceneOne.png'),
                fit: BoxFit.fill,
              ),
              // shape: BoxShape.circle,
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: AppColor.blackColor.withOpacity(0.5),
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        text!,
                        style: AppTextStyles.textStyleBoldBodyMedium
                            .copyWith(color: AppColor.whiteColor),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      color: AppColor.whiteColor,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
