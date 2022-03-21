import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../drivers/common_widgets/home_screen_card.dart';
import '../../../drivers/utils/styles.dart';
import '../../../drivers/utils/utils.dart';
import '../controllers/home_screen_driver_controller.dart';

class UserHomeScreen extends GetView<HomeScreenUserController> {
  final space = SizedBox(height: 20.h);

  final List<String> imagesList = [
    'https://cdn.pixabay.com/photo/2015/10/03/06/04/porsche-969408__480.jpg',
    'https://cdn.pixabay.com/photo/2012/11/02/13/02/car-63930__340.jpg',
    'https://cdn.pixabay.com/photo/2015/05/21/12/56/car-777160__340.jpg',
    'https://media.istockphoto.com/photos/generic-modern-suv-car-in-concrete-garage-picture-id1307086567?b=1&k=20&m=1307086567&s=170667a&w=0&h=NjcM6LIOkmfhyqH-zrbFU7pHCPxIABvNhWaOElm_P-E=',
    'https://cdn.pixabay.com/photo/2018/04/07/16/30/auto-3298890__340.jpg',
  ];

  UserHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.alphaGrey,
        appBar: myAppBar(goBack: false, actions: [
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
          myAppBarIcon(),
          SizedBox(
            width: 50.w,
          ),
        ]),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.only(
              left: 50.w,
              right: 50.w,
            ),
            child: Column(
              children: [
                //slider
                SizedBox(
                  height: 20.h,
                ),
                // Explore GB
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Available Rides For You",
                      style: AppTextStyles.textStyleBoldTitleLarge
                          .copyWith(color: AppColor.blackColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                CarouselSlider(
                  options:
                      CarouselOptions(autoPlay: true, enlargeCenterPage: true),
                  items: imagesList
                      .map(
                        (item) => ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Center(
                            child: Image.network(
                              item,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),

                SizedBox(
                  height: 20.h,
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
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 150.h),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return HomeScreenCard(
                          text: "Skardu Valley",
                          btnText: "Explore",
                          image: const AssetImage('assets/icons/sceneOne.png'),
                        );
                      }),
                )
                //explore / homeScreenCard widgets
              ],
            ),
          ),
        ));
  }

  Widget myAppBarIcon() {
    return Center(
      child: CircleAvatar(
        backgroundColor: AppColor.primaryBlueColor.withAlpha(50),
        child: Stack(
          children: [
            const Icon(
              Icons.notifications,
              color: Colors.black,
              size: 30,
            ),
            Container(
              width: 30,
              height: 30,
              alignment: Alignment.topRight,
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffc32c37),
                    border: Border.all(color: Colors.white, width: 1)),
                child: const Center(
                  child: Text(
                    "1",
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
