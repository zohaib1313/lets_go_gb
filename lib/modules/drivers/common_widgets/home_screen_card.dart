import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:let_go_gb/modules/drivers/utils/common_widgets.dart';
import 'package:let_go_gb/modules/drivers/utils/styles.dart';

class BlogViewItemCard extends StatelessWidget {
  final String? image;
  final String? name;
  final String? btnText;
  double? width;
  double? height;

  BlogViewItemCard(
      {Key? key, this.image, this.name, this.btnText, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      child: Card(
        elevation: 1,
        child: SizedBox(
          width: width ?? MediaQuery.of(context).size.width,
          height: height ?? 220.h,
          //column as child
          child: Stack(
            children: [
              NetworkPlainImage(
                width: width,
                height: height,
                url: image ??
                    "https://cdn.pixabay.com/photo/2018/01/14/23/12/nature-3082832__480.jpg",
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: width ?? MediaQuery.of(context).size.width,
                  color: AppColor.blackColor.withOpacity(0.5),
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          name!,
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
            ],
          ),
        ),
      ),
    );
  }
}
