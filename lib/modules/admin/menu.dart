import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:let_go_gb/common/pages/login_page.dart';
import 'package:let_go_gb/modules/admin/controller/admin_home_controller.dart';
import 'package:let_go_gb/modules/drivers/utils/styles.dart';
import 'package:let_go_gb/modules/drivers/utils/user_defaults.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';

import '../../common/spaces.dart';

class MenuWidgetAdmin extends GetView<AdminHomeScreenController> {
  @override
  Widget build(context) => Container(
        color: AppColor.greenColor.withOpacity(0.9),
        child: ListView(controller: ScrollController(), children: [
          _header(),
          const Divider(),
          ListTile(
            onTap: () {
              controller.selectedViewIndex.value = 0;
            },
            leading: const Icon(Icons.home, color: AppColor.whiteColor),
            title: Text(
              "Home",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.textStyleBoldBodyMedium
                  .copyWith(color: AppColor.whiteColor),
            ),
          ),
          ListTile(
            onTap: () {
              controller.selectedViewIndex.value = 1;
            },
            leading: const Icon(Icons.person_pin, color: AppColor.whiteColor),
            title: Text(
              "Drivers",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.textStyleBoldBodyMedium
                  .copyWith(color: AppColor.whiteColor),
            ),
          ),
          ListTile(
            onTap: () {
              controller.selectedViewIndex.value = 2;
            },
            leading: const Icon(Icons.where_to_vote_rounded,
                color: AppColor.whiteColor),
            title: Text(
              "Blogs",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.textStyleBoldBodyMedium
                  .copyWith(color: AppColor.whiteColor),
            ),
          ),
          ListTile(
            onTap: () {
              controller.selectedViewIndex.value = 3;
            },
            leading: const Icon(Icons.person, color: AppColor.whiteColor),
            title: Text(
              "Users",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.textStyleBoldBodyMedium
                  .copyWith(color: AppColor.whiteColor),
            ),
          ),
          ListTile(
            onTap: () {
              controller.selectedViewIndex.value = 4;
            },
            leading:
                const Icon(Icons.airplane_ticket, color: AppColor.whiteColor),
            title: Text(
              "Bookings",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.textStyleBoldBodyMedium
                  .copyWith(color: AppColor.whiteColor),
            ),
          ),
          ListTile(
            onTap: () {
              controller.selectedViewIndex.value = 5;
            },
            leading:
                const Icon(Icons.notifications, color: AppColor.whiteColor),
            title: Text(
              "Notifications",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.textStyleBoldBodyMedium
                  .copyWith(color: AppColor.whiteColor),
            ),
          ),
          ListTile(
            onTap: () {
              controller.selectedViewIndex.value = 6;
            },
            leading:
                const Icon(Icons.message_outlined, color: AppColor.whiteColor),
            title: Text(
              "Chats",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.textStyleBoldBodyMedium
                  .copyWith(color: AppColor.whiteColor),
            ),
          ),
          ListTile(
            onTap: () {
              controller.selectedViewIndex.value = 7;
            },
            leading: const Icon(Icons.car_rental, color: AppColor.whiteColor),
            title: Text(
              "Promoted Ads",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.textStyleBoldBodyMedium
                  .copyWith(color: AppColor.whiteColor),
            ),
          ),
          ListTile(
            onTap: () {},
            leading:
                const Icon(Icons.monetization_on, color: AppColor.whiteColor),
            title: Text(
              "Transactions",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.textStyleBoldBodyMedium
                  .copyWith(color: AppColor.whiteColor),
            ),
          ),
          ListTile(
            onTap: () {
              UserDefaults().clearAll();
              Get.toNamed(LoginPage.id);
            },
            leading: const Icon(Icons.logout, color: AppColor.whiteColor),
            title: Text(
              "Logout",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.textStyleBoldBodyMedium
                  .copyWith(color: AppColor.whiteColor),
            ),
          ),
          _footer(),
        ]),
      );

  _header() {
    print("pcccccc");
    printWrapped(UserDefaults.getAdminSession()?.profileImage ?? "");
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        vSpace,
        /* NetworkCircularImage(
          url: UserDefaults.getAdminSession()?.profileImage ?? "",
          radius: 44,
        ),*/
        Text(
          "Welcome\n ${UserDefaults.getAdminSession()?.firstName ?? ''}",
          style: AppTextStyles.textStyleBoldBodyMedium
              .copyWith(color: AppColor.whiteColor),
        )
      ],
    );
  }

  _footer() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          vSpace,
          Row(
            children: [
              const Icon(
                Icons.copyright,
                size: 10,
              ),
              Text(
                "  All right reserved",
                maxLines: 1,
                style: AppTextStyles.textStyleBoldBodyMedium
                    .copyWith(color: AppColor.whiteColor),
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
          vSpace,
        ],
      ),
    );
  }
}
