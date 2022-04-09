import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/common/models/booking_model.dart';

class UserBookingController extends GetxController {
  var temp = 0.obs;

  TextEditingController searchTextController = TextEditingController();
  RxList<BookingModel?> showingBookingList = <BookingModel?>[].obs;
  List<BookingModel?> allBookingList = [];

  void searchFromBookings() {
    showingBookingList.clear();
    if (searchTextController.text.isEmpty) {
      showingBookingList.addAll(allBookingList);
    } else {
      String text = searchTextController.text;
      print(text);
      for (var model in allBookingList) {
        if ((model?.pickUpAddress?.toLowerCase() ?? '')
                .contains(text.toLowerCase()) ||
            (model?.status?.toLowerCase() ?? '').contains(text.toLowerCase())) {
          showingBookingList.add(model);
        }
      }
    }
  }
}
