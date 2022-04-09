import 'package:get/get.dart';
import 'package:let_go_gb/common/models/booking_model.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/ui.dart';
import 'package:let_go_gb/modules/drivers/utils/user_defaults.dart';
import 'package:let_go_gb/modules/users/models/user_model.dart';
import 'package:let_go_gb/repositories/user_booking_repository.dart';
import 'package:uuid/uuid.dart';

import '../../../../common/Push_notifications_manager.dart';
import '../../../../common/models/notification_model.dart';

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
        ///sending notification to the user
        sendPushNotification(
          toDeviceId: user.deviceTokenId,
          notificationModel: NotificationModel(
              id: const Uuid().v1(),
              isRead: false,
              fromId: UserDefaults.getCurrentUserId() ?? '',
              toId: user.id ?? '',
              time: DateTime.now().toString(),
              title: 'Booking Confirmed',
              body: 'Your booking #${booking.bookingId} has been $status.'),
        );
        Get.back();
        Get.showSnackbar(Ui.SuccessSnackBar(message: "Booking $status"));
      }
    }).catchError((onError) {
      Get.log(onError.toString(), isError: true);
      Get.showSnackbar(Ui.ErrorSnackBar(message: onError.toString()));
    }).whenComplete(() {
      isLoading.value = false;
    });
  }
}
