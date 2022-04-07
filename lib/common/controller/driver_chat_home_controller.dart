import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../modules/drivers/utils/app_popups.dart';
import '../../modules/drivers/utils/utils.dart';
import '../../routes.dart';

class ChatHomeController extends GetxController {
  var haveChat = false.obs;

  void deleteChat(
      {onComplete, required String userId, required String docId}) async {
    AppPopUps().showProgressDialog(context: myContext!);

    if (userId.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('Messages')
          .doc(userId)
          .update({docId: FieldValue.delete()});

      QuerySnapshot<Map<String, dynamic>> kk = await FirebaseFirestore.instance
          .collection('Messages')
          .doc(userId)
          .collection(docId)
          .get();
      printWrapped("maapppp");
      for (final doc in kk.docs) {
        Map<String, dynamic> map = doc.data();

        printWrapped(map.toString());

        await doc.reference.delete();
      }

      AppPopUps().dissmissDialog();
      //onComplete(false);
      onComplete(true);
    } else {
      onComplete(false);
    }
  }

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('hh:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return time;
  }
}
