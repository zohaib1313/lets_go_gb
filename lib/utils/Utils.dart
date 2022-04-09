import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nanoid/nanoid.dart';
import 'package:uuid/uuid.dart';

class AppUtils {
  static Future<String> getUniqueOrderId() async {
    return customAlphabet('letsGoGb ${const Uuid().v1()}', 8);
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static String readTimestamp(int timestamp) {
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

  static void showPicker({required BuildContext context, onComplete}) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext x) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () async {
                      _pickImage(
                          source: 0,
                          onCompletedd: (File? file) {
                            print(file!.path.toString());
                            onComplete(file);
                          });

                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () async {
                    _pickImage(
                        source: 1,
                        onCompletedd: (File file) {
                          onComplete(file);
                        });

                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  static void _pickImage({required int source, required onCompletedd}) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
          source: source == 1 ? ImageSource.camera : ImageSource.gallery);

      if (pickedFile != null) {
        onCompletedd(File(pickedFile.path));
      } else {
        Get.log('No image selected.');
        return null;
      }
    } catch (e) {
      Get.log(e.toString(), isError: true);
    }
  }
}
