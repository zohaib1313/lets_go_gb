import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/common/booking_model.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/ui.dart';
import 'package:let_go_gb/modules/drivers/utils/user_defaults.dart';
import 'package:let_go_gb/repositories/user_booking_repository.dart';
import 'package:uuid/uuid.dart';

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
  late UserBookingRepository _userBookingRepository;

  @override
  void onInit() {
    _userBookingRepository = UserBookingRepository();
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

  void makeReservation(String vehicleId) {
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
      ..transactionId = const Uuid().v1().toString()
      ..bookingNotes = notesController.text
      ..pickUpAddress = addressController.text
      ..pickUpLat = 35.920618
      ..pickUpLng = 74.329363
      ..status = "Pending"
      ..pickUpDate = startDateController.text
      ..pickUpTime = startTimeController.text;

    _userBookingRepository.saveBooking(bookingModel).then((value) {
      if (value.toString() == "Success") {
        Get.back();
        Get.showSnackbar(Ui.SuccessSnackBar(message: "Booking Created"));
      }
    }).catchError((onError) {
      Get.log(onError.toString(), isError: true);
      Get.showSnackbar(Ui.ErrorSnackBar(message: onError.toString()));
    }).whenComplete(() {
      isLoading.value = false;
    });
  }
}
