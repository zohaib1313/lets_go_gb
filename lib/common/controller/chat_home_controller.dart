import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

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
}
