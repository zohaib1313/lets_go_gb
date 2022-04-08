import 'package:flutter/cupertino.dart';
import 'package:nanoid/nanoid.dart';
import 'package:uuid/uuid.dart';

class AppUtils {
  static Future<String> getUniqueOrderId() async {
    return customAlphabet('letsGoGb ${const Uuid().v1()}', 8);
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
