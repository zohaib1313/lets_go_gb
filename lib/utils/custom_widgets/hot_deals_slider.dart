import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:let_go_gb/utils/styles.dart';

class HotDealsSlider extends StatelessWidget {

  final String? carName;
  final String? carModel;
  final ImageProvider? carImage;

  HotDealsSlider({this.carName,this.carImage,this.carModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: const BoxDecoration(
          color: AppColor.primaryBlueColor,

          borderRadius: BorderRadius.all(Radius.circular(20))

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            carName!,
            style: AppTextStyles.textStyleBoldSubTitleLarge
                .copyWith(color: AppColor.whiteColor),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 200.h,
                  width: 200.h,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: carImage!,
                        fit: BoxFit.fill,
                      )),
                ),
                flex: 7,
              ),
              const Expanded(
                flex: 3,
                child: Text(
                    "25%\nOFF",
                    style: TextStyle(fontSize: 40,
                        color:  Color(0xffF6BC29),
                        fontWeight: FontWeight.bold)
                ),
              ),
            ],
          ),
          Text(
            carModel!,
            style: AppTextStyles.textStyleNormalBodyMedium
                .copyWith(color: AppColor.whiteColor),
          ),
        ],
      ),
    );

  }
}
