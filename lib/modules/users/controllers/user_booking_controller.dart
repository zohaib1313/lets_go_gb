import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/common/models/booking_model.dart';

import '../../drivers/utils/firebase_paths.dart';
import '../../drivers/utils/user_defaults.dart';

class UserBookingController extends GetxController {
  var temp = 0.obs;

  TextEditingController searchController = TextEditingController();
  RxList<BookingModel?> filteredBookingList = <BookingModel?>[].obs;
  final List<BookingModel?> allBookingList = [];

  RxBool isRecentFilterd = false.obs;
  var isSortFiltered = false.obs;

  void searchFromBookings() {
    filteredBookingList.clear();
    if (searchController.text.isEmpty) {
      filteredBookingList.addAll(allBookingList);
    } else {
      String text = searchController.text;

      for (var model in allBookingList) {
        if ((model?.pickUpAddress?.toLowerCase() ?? '')
                .contains(text.toLowerCase()) ||
            (model?.status?.toLowerCase() ?? '').contains(text.toLowerCase())) {
          filteredBookingList.add(model);
        }
      }
    }
  }

  void filterOnDates() {
    filteredBookingList.sort((a, b) {
      num aDate = a!.bookingDateStart!.millisecondsSinceEpoch;
      num bDate = b!.bookingDateStart!.millisecondsSinceEpoch;

      return isRecentFilterd.value
          ? aDate.compareTo(bDate)
          : bDate.compareTo(aDate);
    });
    isRecentFilterd.value = !isRecentFilterd.value;
  }

  void filterOnSort() {
    filteredBookingList.sort((a, b) {
      String aStatus = a?.id ?? "";
      String bStatus = b?.id ?? "";

      return isSortFiltered.value
          ? aStatus.compareTo(bStatus)
          : bStatus.compareTo(aStatus);
    });
    isSortFiltered.value = !isSortFiltered.value;
  }

  void getFilteredList({required String status}) {
    filteredBookingList.clear();
    if (status == "") {
      filteredBookingList.addAll(allBookingList);
    } else {
      for (var element in allBookingList) {
        if ((element?.status ?? "x") == status) {
          filteredBookingList.add(element);
        }
      }
    }
  }

  void loadData() {
    print("loadddinngg");
    filteredBookingList.clear();
    allBookingList.clear();
    FirebaseFirestore.instance
        .collection(FirebasePathNodes.bookings)
        .where('userId', isEqualTo: UserDefaults.getUserSession()?.id ?? '')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      filteredBookingList.clear();
      allBookingList.clear();
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
        BookingModel model = BookingModel.fromMap(data);
        filteredBookingList.add(model);
      }
      allBookingList.addAll(filteredBookingList);
    });
  }
}
