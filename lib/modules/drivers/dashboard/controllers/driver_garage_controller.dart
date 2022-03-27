import 'package:get/get.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/ui.dart';
import 'package:let_go_gb/modules/drivers/dashboard/model/vehicle_model.dart';
import 'package:let_go_gb/repositories/driver_garage_controller_repository.dart';

class DriverGarageController extends GetxController {
  var temp = 0.obs;
  var haveVehicle = false;
  final loading = false.obs;
  List<VehicleModel> vehicleList = [];
  DriverGarageRepository? _driverGarageRepository;
  final List<String> imagesList = [
    'https://cdn.pixabay.com/photo/2015/10/03/06/04/porsche-969408__480.jpg',
    'https://cdn.pixabay.com/photo/2012/11/02/13/02/car-63930__340.jpg',
    'https://cdn.pixabay.com/photo/2015/05/21/12/56/car-777160__340.jpg',
    'https://media.istockphoto.com/photos/generic-modern-suv-car-in-concrete-garage-picture-id1307086567?b=1&k=20&m=1307086567&s=170667a&w=0&h=NjcM6LIOkmfhyqH-zrbFU7pHCPxIABvNhWaOElm_P-E=',
    'https://cdn.pixabay.com/photo/2018/04/07/16/30/auto-3298890__340.jpg',
  ];
  DriverGarageController() {
    _driverGarageRepository = DriverGarageRepository();
  }

  void loadCategories() {
    loading.value = true;
    _driverGarageRepository!.getVehicles().then((List<VehicleModel>? list) {
      vehicleList = list!;
    }).catchError((onError) {
      Get.log("$onError", isError: true);
      Get.showSnackbar(Ui.ErrorSnackBar(message: "$onError"));
    }).whenComplete(() {
      loading.value = false;
    });
  }
}
