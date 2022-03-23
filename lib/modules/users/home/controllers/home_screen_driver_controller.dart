import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/sing_in/models/login_model.dart';

class HomeScreenUserController extends GetxController {
  final loading = true.obs;

  final loginModel = UserModel().obs;

  HomeScreenUserController();
}
