import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/common/Push_notifications_manager.dart';
import 'package:let_go_gb/common/models/booking_model.dart';
import 'package:let_go_gb/common/models/notification_model.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/ui.dart';
import 'package:let_go_gb/modules/drivers/dashboard/models/driver_user_model.dart';
import 'package:let_go_gb/modules/drivers/utils/app_alert_bottom_sheet.dart';
import 'package:let_go_gb/modules/drivers/utils/user_defaults.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';
import 'package:let_go_gb/repositories/user_booking_repository.dart';
import 'package:let_go_gb/utils/Utils.dart';
import 'package:pay/pay.dart';
import 'package:uuid/uuid.dart';

import '../../drivers/utils/app_constants.dart';

class UserMakeBookingController extends GetxController {
  TextEditingController addressController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController locationPickController = TextEditingController();
  var passengers = 1.obs;
  var days = 1.obs;
  var totalPrice = 0.0.obs;
  var twentyPercentOfTax = 0.0.obs;
  RxBool locationChanged = false.obs;
  RxBool isLoading = false.obs;
  DateTimeRange? dateTimeRange;

  var formKey = GlobalKey<FormState>();
  late BookingRepository _userBookingRepository;

  @override
  void onInit() {
    _userBookingRepository = BookingRepository();
    super.onInit();
  }

  int daysElapsedSince(DateTime from, DateTime to) {
// get the difference in term of days, and not just a 24h difference
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);

    return to.difference(from).inDays;
  }

  void makeCalculations(double rentPerDay) {
    final total = days.value * rentPerDay;
    totalPrice.value = total;
    twentyPercentOfTax.value = ((20.0 / 100.0) * total).toPrecision(2);
  }

  Future<void> makeReservation(
      {required String vehicleId,
      required DriverUserModel? driverUserModel}) async {
    isLoading.value = true;
    BookingModel bookingModel = BookingModel()
      ..id = const Uuid().v1().toString()
      ..userId = UserDefaults.getUserSession()?.id ?? ''
      ..vehicleId = vehicleId
      ..passengers = passengers.value.toInt()
      ..bookingDateStart = dateTimeRange?.start
      ..bookingDateEnd = dateTimeRange?.end
      ..totalAmount = totalPrice.value.toDouble()
      ..twentyPercentAmount = twentyPercentOfTax.value.toDouble()
      ..transactionId = "unpaid"
      /*  ..transactionId = await AppUtils.getUniqueOrderId()*/
      ..bookingId = await AppUtils.getUniqueOrderId()
      ..bookingNotes = notesController.text
      ..pickUpAddress = addressController.text
      ..pickUpLat = 35.920618
      ..pickUpLng = 74.329363
      ..status = BookingStatus.pending
      ..pickUpDate = startDateController.text
      ..pickUpTime = startTimeController.text;

    _userBookingRepository.saveBooking(bookingModel).then((value) {
      if (value.toString() == "Success") {
        sendPushNotification(
            toDeviceId: driverUserModel?.deviceTokenId ?? '',
            notificationModel: NotificationModel(
                id: const Uuid().v1(),
                fromId: bookingModel.userId,
                toId: driverUserModel?.id ?? '',
                title: "New Booking",
                body: "You go new booking order",
                time: DateTime.now().toString(),
                isRead: false));

        Get.back();
        Get.showSnackbar(Ui.SuccessSnackBar(message: "Booking Created"));
        /*_showPaymentMethod(
            model: bookingModel,
            onResult: (result) {
              printWrapped(result.toString());
              _updateBookingToPaid(bookingModel);
              Get.back();
              Get.showSnackbar(Ui.SuccessSnackBar(message: "Booking Created"));
            });*/
      }
    }).catchError((onError) {
      Get.log(onError.toString(), isError: true);
      Get.showSnackbar(Ui.ErrorSnackBar(message: onError.toString()));
    }).whenComplete(() {
      isLoading.value = false;
    });
  }

  void _showPaymentMethod({required BookingModel? model, required onResult}) {
    final _paymentItems = [
      PaymentItem(
        label: 'Total',
        amount: (model?.totalAmount ?? 0.0).toString(),
        status: PaymentItemStatus.final_price,
      )
    ];

    AppBottomSheets.showAppAlertBottomSheet(
        isDismissable: false,
        child: Column(
          children: [
            ApplePayButton(
              paymentConfigurationAsset: 'gpay.json',
              paymentItems: _paymentItems,
              style: ApplePayButtonStyle.black,
              type: ApplePayButtonType.buy,
              width: 250,
              height: 50,
              margin: const EdgeInsets.only(top: 15.0),
              onPaymentResult: onResult,
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            GooglePayButton(
              paymentConfigurationAsset: 'gpay.json',
              paymentItems: _paymentItems,
              width: 250,
              height: 50,
              style: GooglePayButtonStyle.black,
              type: GooglePayButtonType.pay,
              margin: const EdgeInsets.only(top: 15.0),
              onPaymentResult: onResult,
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ));
  }

  void _updateBookingToPaid(BookingModel bookingModel) async {
    bookingModel.copyWith(transactionId: await AppUtils.getUniqueOrderId());
    await _userBookingRepository.updateBooking(bookingModel);
    printWrapped("booking updated with transaction");
  }
}
