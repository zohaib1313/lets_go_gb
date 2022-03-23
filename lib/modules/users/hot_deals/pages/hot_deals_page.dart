// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../drivers/common_widgets/hot_deals_card.dart';
import '../../../drivers/common_widgets/hot_deals_slider.dart';
import '../../../drivers/utils/styles.dart';
import '../../../drivers/utils/utils.dart';
import '../../home/controllers/hot_deals_controller.dart';

class HotDealsPage extends GetView<HotDealsController> {
  final space = SizedBox(height: 20.h);

  HotDealsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: "Hot Deals", goBack: false),
      backgroundColor: const Color(0xffE5E5E5).withOpacity(0.3),
      body: Container(
        padding: EdgeInsets.only(
          left: 50.w,
          right: 50.w,
        ),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 25.h,
            ),

            //hot deals slider
            SizedBox(
              height: 320.h,
              // color: Colors.green,
              // margin: const EdgeInsets.all(5),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  // padding: EdgeInsets.all(5),
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: HotDealsSlider(
                        carName: "Toyota Land Crusier",
                        carImage: const AssetImage("assets/images/redCar.png"),
                        carModel: "MODEL: 2020",
                      ),
                    );
                  }),
            ),

            SizedBox(
              height: 25.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Available Cars",
                  style: AppTextStyles.textStyleBoldTitleLarge
                      .copyWith(color: AppColor.blackColor),
                ),
                const Text(
                  "View all",
                  style: TextStyle(
                    color: Color(0xff0088FF),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            //hot deals card
            HotDealsCard(
              carName: "Toyota Land Cruiser",
              carPrice: "PKR 1000/",
              carSeats: "4 Seats",
              image: const AssetImage("assets/images/whiteCar.png"),
            ),
            SizedBox(
              height: 10.h,
            ),
            HotDealsCard(
              carName: "Toyota Land Cruiser",
              carPrice: "PKR 1000/",
              carSeats: "4 Seats",
              image: const AssetImage("assets/images/redCar.png"),
            ),

            SizedBox(
              height: 10.h,
            ),
            HotDealsCard(
              carName: "Toyota Land Cruiser",
              carPrice: "PKR 1000/",
              carSeats: "4 Seats",
              image: const AssetImage("assets/images/whiteCar.png"),
            ),

            SizedBox(
              height: 10.h,
            ),
            HotDealsCard(
              carName: "Toyota Land Cruiser",
              carPrice: "PKR 1000/",
              carSeats: "4 Seats",
              image: const AssetImage("assets/images/redCar.png"),
            ),

            SizedBox(
              height: 10.h,
            ),
            HotDealsCard(
              carName: "Toyota Land Cruiser",
              carPrice: "PKR 1000/",
              carSeats: "4 Seats",
              image: const AssetImage("assets/images/whiteCar.png"),
            ),

            SizedBox(
              height: 10.h,
            ),

            HotDealsCard(
              carName: "Toyota Land Cruiser",
              carPrice: "PKR 1000/",
              carSeats: "4 Seats",
              image: const AssetImage("assets/images/redCar.png"),
            ),
            SizedBox(
              height: 10.h,
            ),
            HotDealsCard(
              carName: "Toyota Land Cruiser",
              carPrice: "PKR 1000/",
              carSeats: "4 Seats",
              image: const AssetImage("assets/images/whiteCar.png"),
            ),

            SizedBox(
              height: 10.h,
            ),
            HotDealsCard(
              carName: "Toyota Land Cruiser",
              carPrice: "PKR 1000/",
              carSeats: "4 Seats",
              image: const AssetImage("assets/images/redCar.png"),
            ),
          ]),
        ),
      ),
    );
  }
}
