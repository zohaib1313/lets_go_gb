import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/controllers/home_screen_driver_controller.dart';
import 'package:let_go_gb/utils/custom_widgets/home_screen_card.dart';

import '../../../utils/common_widgets.dart';
import '../../../utils/styles.dart';
import '../../../utils/utils.dart';

class HomeScreenDriver extends GetView<HomeScreenDriverController> {
  final space = SizedBox(height: 20.h);

  final List<String> imagesList = [
    'https://cdn.pixabay.com/photo/2015/10/03/06/04/porsche-969408__480.jpg',
    'https://cdn.pixabay.com/photo/2012/11/02/13/02/car-63930__340.jpg',
    'https://cdn.pixabay.com/photo/2015/05/21/12/56/car-777160__340.jpg',
    'https://media.istockphoto.com/photos/generic-modern-suv-car-in-concrete-garage-picture-id1307086567?b=1&k=20&m=1307086567&s=170667a&w=0&h=NjcM6LIOkmfhyqH-zrbFU7pHCPxIABvNhWaOElm_P-E=',
    'https://cdn.pixabay.com/photo/2018/04/07/16/30/auto-3298890__340.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(title: "Home", goBack: false, actions: [
          //profile image
          const CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage(
              "assets/icons/ellipseperson.png",
            ),
          ),
          SizedBox(
            width: 30.w,
          ),
          //notification icon
          SvgViewer(
              height: 48.h, svgPath: "assets/icons/ic_my_notification.svg"),
          SizedBox(
            width: 50.w,
          ),
        ]),
        backgroundColor: AppColor.whiteColor,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.only(
              left: 50.w,
              right: 50.w,
            ),
            child: Column(
              children: [
                //slider
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                  ),
                  items: imagesList
                      .map(
                        (item) => Center(
                          child: Image.network(
                            item,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                      .toList(),
                ),

                SizedBox(
                  height: 30.h,
                ),
                // Explore GB
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Explore GB",
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
              //explore / homeScreenCard widgets

                SizedBox(
                  height: 30.h,
                ),
                 HomeScreenCard(
                   text: "Skardu Valley",
                   btnText: "Explore",
                   image:const AssetImage('assets/icons/sceneOne.png'),

                 ),
                SizedBox(
                  height: 10.h,
                ),
                 HomeScreenCard(
                   text: "Hunza Valley",
                   btnText: "Explore",
                   image:const AssetImage('assets/images/hunza.png'),

                 ),
                SizedBox(
                  height: 10.h,
                ),
                 HomeScreenCard(
                   text: "Sawat Valley",
                   btnText: "Explore",
                   image:const AssetImage('assets/icons/sceneOne.png'),
                 ),
              ],
            ),
          ),
        ));
  }
}
