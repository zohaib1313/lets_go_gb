import 'package:get/get.dart';
import 'package:let_go_gb/common/booking_model.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/ui.dart';
import 'package:let_go_gb/modules/users/models/user_model.dart';
import 'package:let_go_gb/repositories/user_booking_repository.dart';

class DriverBookingDetailController extends GetxController {
  var isLoading = false.obs;
  late BookingRepository bookingRepository;

  @override
  void onInit() {
    super.onInit();
    bookingRepository = BookingRepository();
  }

  void changeBookingStatus(
      {required BookingModel booking,
      required UserModel user,
      required String status}) async {
    BookingModel bookingUpdate = booking.copyWith(status: status);

    isLoading.value = true;
    bookingRepository.updateBooking(bookingUpdate).then((value) {
      if (value.toString() == "Success") {
        Get.back();
        Get.showSnackbar(Ui.SuccessSnackBar(message: "Booking $status"));
      }
    }).catchError((onError) {
      Get.log(onError.toString(), isError: true);
      Get.showSnackbar(Ui.ErrorSnackBar(message: onError.toString()));
    }).whenComplete(() {
      isLoading.value = false;
    });

    ;
  }
}
