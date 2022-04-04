import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:let_go_gb/common/booking_model.dart';
import 'package:let_go_gb/modules/drivers/common_widgets/helper.dart';
import 'package:let_go_gb/modules/drivers/utils/firebase_paths.dart';

class UserBookingRepository {
  late FirebaseHelper _firebaseHelper;
  CollectionReference? _collectionReference;

  UserBookingRepository() {
    _firebaseHelper = FirebaseHelper();
    _collectionReference =
        FirebaseFirestore.instance.collection(FirebasePathNodes.bookings);
  }
  Future<String?> saveBooking(BookingModel model) async {
    try {
      final isSuccess = await _firebaseHelper.saveDocument(
          FirebasePathNodes.bookings, model.toMap());

      if (isSuccess) {
        return Future.value("Success");
      } else {
        return Future.value("Failed to make booking");
      }
    } on FirebaseFirestore catch (onError) {
      Get.log("$onError", isError: true);

      return Future.value(onError.toString());
    } catch (onError) {
      Get.log("$onError", isError: true);

      return Future.value("Failed to save booking");
    }
  }
}
