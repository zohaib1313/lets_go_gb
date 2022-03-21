import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/add_new_vehicle_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/driver_chat_home_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/driver_chat_with_user_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/driver_dashboard_home_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/controllers/driver_garage_controller.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/driver_add_new_vehicle_page.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/driver_chat_screen.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/driver_dashboard_page.dart';
import 'package:let_go_gb/modules/drivers/dashboard/pages/home_page.dart';
import 'package:let_go_gb/modules/drivers/sing_in/controllers/login_driver_controller.dart';
import 'package:let_go_gb/modules/drivers/sing_in/pages/login_driver_screen.dart';
import 'package:let_go_gb/modules/drivers/sing_up/controllers/signup_driver_controller.dart';
import 'package:let_go_gb/modules/drivers/sing_up/pages/driver_signup_screen.dart';

import 'dashboard/controllers/driver_more_controller.dart';

appPages() {
  return [
    GetPage(
        name: DriverSignUpScreen.id,
        page: () => DriverSignUpScreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut<DriverSignUpController>(
            () => DriverSignUpController(),
          );
        })),
    GetPage(
        name: DriverHomePage.id,
        page: () => const DriverDashBoard(),
        binding: BindingsBuilder(() {
          ///putting lazy will dispose controller and throw ticker provider active exception
          Get.put(DriverDashBoardHomeController());
          Get.put(DriverGarageController());
          Get.put(DriverChatHomeController());
          Get.put(DriverMoreController());

          //  Get.lazyPut<DriverGarageController>(() => DriverGarageController());
        })),

    ///login binding
    GetPage(
        name: DriverSignInScreen.id,
        page: () => DriverSignInScreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut<LoginDriverController>(
            () => LoginDriverController(),
          );
        })),

    GetPage(
        name: DriverAddNewVehiclePage.id,
        page: () => DriverAddNewVehiclePage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<AddNewVehicleController>(
            () => AddNewVehicleController(),
          );
        })),

    GetPage(
        name: ChatScreen.id,
        page: () => ChatScreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut<DriverChatWithUserController>(
            () => DriverChatWithUserController(),
          );
        })),
  ];
}
