import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/ui.dart';
import 'package:let_go_gb/modules/drivers/sing_in/models/login_model.dart';
import 'package:let_go_gb/repositories/driver_dashboard_home_repository.dart';

class HomeScreenUserController extends GetxController {
  final loading = true.obs;

  final loginModel = UserModel().obs;
  HomeScreenUserController(){
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }



}
