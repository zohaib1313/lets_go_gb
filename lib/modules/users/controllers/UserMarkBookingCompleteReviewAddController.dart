import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/common/Push_notifications_manager.dart';
import 'package:let_go_gb/common/models/notification_model.dart';
import 'package:let_go_gb/common/reviews_model.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/helper.dart';
import 'package:let_go_gb/modules/drivers/dashboard/models/driver_user_model.dart';
import 'package:let_go_gb/modules/drivers/utils/app_constants.dart';
import 'package:let_go_gb/modules/drivers/utils/firebase_paths.dart';
import 'package:uuid/uuid.dart';

import '../../../common/models/booking_model.dart';
import '../../drivers/common_widgets/ui.dart';

class UserMarkBookingCompleteReviewAddController extends GetxController {
  late FirebaseHelper _firebaseHelper;

  TextEditingController reviewTextController = TextEditingController();

  RxBool isLoading = false.obs;

  var ratings = 0.0.obs;

  final formKey = GlobalKey<FormState>();

  markBookingComplete({required BookingModel booking}) async {
    isLoading.value = true;
    ReviewModel reviewModel = ReviewModel()
      ..id = const Uuid().v1()
      ..userId = booking.userId
      ..reviewMessage = reviewTextController.text
      ..driverId = booking.vehicleId
      ..ratings = ratings.value
      ..dateTime = DateTime.now().toString()
      ..bookingId = booking.id;
    try {
      final isSuccess = await _firebaseHelper.saveDocument(
          FirebasePathNodes.reviews, reviewModel.toMap());
      if (isSuccess) {
        booking = booking.copyWith(status: BookingStatus.completed);
        final isSuccess = await _firebaseHelper.updateDocument(
            FirebasePathNodes.bookings, booking.toMap());
        isLoading.value = false;
        if (isSuccess) {
          _sendNotification(booking: booking, review: reviewModel);
          Get.back();
          Get.showSnackbar(
              Ui.SuccessSnackBar(message: "Booking Marked Completed"));
        } else {
          Get.showSnackbar(
              Ui.ErrorSnackBar(message: "Something went wrong..!"));
        }
      } else {
        isLoading.value = false;
        Get.showSnackbar(Ui.ErrorSnackBar(message: "Something went wrong..!"));
      }
    } on FirebaseFirestore catch (onError) {
      isLoading.value = false;
      Get.log("$onError", isError: true);
      Get.showSnackbar(Ui.ErrorSnackBar(message: "$onError"));
    } catch (onError) {
      isLoading.value = false;
      Get.log("$onError", isError: true);
      Get.showSnackbar(Ui.ErrorSnackBar(message: "$onError"));
    }
  }

  @override
  void onInit() {
    _firebaseHelper = FirebaseHelper();

    super.onInit();
  }

  Future<void> _sendNotification(
      {required BookingModel booking, required ReviewModel review}) async {
    ///sending to driver
    try {
      final userDocument = await _firebaseHelper.getDoc(
          FirebasePathNodes.users, booking.vehicleId!);

      Map<String, dynamic> userMap =
          userDocument.data() as Map<String, dynamic>;

      DriverUserModel driverUserModel = DriverUserModel.fromMap(userMap);

      NotificationModel notificationModel = NotificationModel(
          id: const Uuid().v1(),
          fromId: booking.userId,
          toId: booking.vehicleId,
          title: "Booking Completed",
          body: "Booking #${booking.bookingId} was marked completed",
          time: DateTime.now().toString(),
          isRead: false);

      sendPushNotification(
          toDeviceId: driverUserModel.deviceTokenId,
          notificationModel: notificationModel);
    } on FirebaseFirestore catch (onError) {
      Get.log("$onError", isError: true);
    } catch (onError) {
      Get.log("$onError", isError: true);
    }
  }
}
