import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/utils/styles.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';

import '../../utils/my_app_bar.dart';
import '../controllers/driver_chat_home_controller.dart';
import 'driver_chat_screen.dart';

class DriverChatHomePage extends GetView<DriverChatHomeController> {
  const DriverChatHomePage({Key? key}) : super(key: key);
  static const id = '/DriverChatHomePage';

  @override
  Widget build(BuildContext context) {
    return GetX<DriverChatHomeController>(initState: (state) {
      ///load chats here
      controller.haveChat.value = true;
    }, builder: (stateCtx) {
      return SafeArea(
        child: Scaffold(
          appBar: myAppBar(goBack: false, title: "Your Chats", actions: [
            MyAnimSearchBar(
              width: MediaQuery.of(context).size.width,
              onSuffixTap: () {
                // controller.searchJobPostedController.clear();
              },
              closeSearchOnSuffixTap: true,
              textController:
                  TextEditingController() /*controller.searchJobPostedController*/,
            ),
          ]),
          body: Container(
            padding: EdgeInsets.all(10.h),
            child: controller.haveChat.value
                ? ListView.builder(
                    itemCount: 11,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return index == 10
                          ? SizedBox(height: 150.h)

                          ///adding padding at the last item so that row don't overlap on bottom navbar
                          : getUsersOfChatRow();
                    },
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'No Chat Found',
                          style: AppTextStyles.textStyleBoldBodyMedium,
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      );
    });
  }

  Widget getUsersOfChatRow() {
    return InkWell(
      onTap: () {
        Get.toNamed(ChatScreen.id);
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage:
                const AssetImage('assets/images/place_your_image.png'),
            radius: 180.r,
          ),
          title: Text(
            'User Name',
            style: AppTextStyles.textStyleBoldBodyMedium,
          ),
          subtitle: Text(
            'Hello last message',
            style: AppTextStyles.textStyleNormalBodyXSmall,
          ),
          trailing: Text(
            '09:00 am',
            style: AppTextStyles.textStyleNormalBodyMedium,
          ),
        ),
      ),
    );
  }
}
