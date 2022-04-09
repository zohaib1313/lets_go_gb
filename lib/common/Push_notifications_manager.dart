import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:let_go_gb/modules/drivers/utils/firebase_paths.dart';
import 'package:let_go_gb/modules/drivers/utils/utils.dart';

import '../modules/drivers/utils/user_defaults.dart';
import 'models/notification_model.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      NotificationSettings settings =
          await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
      );

      _initialized = await flutterLocalNotificationsPlugin
              .initialize(initializationSettings,
                  onSelectNotification: (String? payload) async {
            if (payload != null) {}
          }) ??
          false;
    }
    String? token = await _firebaseMessaging.getToken();
    printWrapped("FCM TOKEN= ${token.toString()}");
    String userId = UserDefaults.getCurrentUserId() ?? '';
    if ((userId).isNotEmpty) {
      FirebaseFirestore.instance
          .collection(FirebasePathNodes.users)
          .doc(userId)
          .update({"deviceTokenId": token});
    }
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      printWrapped("FCM TOKEN REfresh=== ${newToken}");
      if ((userId).isNotEmpty) {
        FirebaseFirestore.instance
            .collection(FirebasePathNodes.users)
            .doc(userId)
            .update({"deviceTokenId": newToken});
      }
    });

    _listenToNotifications();
  }

  void _listenToNotifications() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      printWrapped("Notification received ${message.notification.toString()}");
      _demoNotification(message);
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
/////////////////////////////////
sendPushNotification(
    {required String? toDeviceId,
    required NotificationModel notificationModel}) async {
  if (toDeviceId != null) {
    var headers = {
      'Authorization':
          'key=AAAAsB_8VR4:APA91bGxI4RqGly0UCY6rsL65a54phCFTNR7DIOvxZo448iOaBI8sFpPRW6YljoSUlF4fyBM87HhPd8oUOzlCd1KbD9pTodlbbr7k84qF-t_K3XuyLSF-MjBMCIXs6hHtIfLPiTpkXo6',
      'Content-Type': 'application/json'
    };
    var request =
        http.Request('POST', Uri.parse('https://fcm.googleapis.com/fcm/send'));
    request.body = json.encode({
      "to": toDeviceId,
      // "ceoTbCODQ96_r3XdkVKtCn:APA91bGp5kDevP1wkbX2TFF980soSFXLIvfxQVuaV7ZTje_vvQqsOh1vcx6RB0QccyHnJGSAduLnY8kYLWIchp71FswWgupThLtDtaETUq3iIJDFYcuhLx9VWj4RwIbMnXHdyq-sxzlt",
      "notification": notificationModel
          .toMap() /* {"title": "Portugal vs. Denmark", "body": "great match!"}*/
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    printWrapped("sending notification");
    printWrapped(response.toString());

    if (response.statusCode == 200) {
      printWrapped("notification sent success");
      _saveNotificationToFirebase(model: notificationModel);
    } else {
      printWrapped("notification send failed");
      printWrapped(response.reasonPhrase.toString());
    }
  }
}

void _saveNotificationToFirebase({required NotificationModel model}) {
  FirebaseFirestore.instance
      .collection(FirebasePathNodes.notifications)
      .doc(model.toId)
      .set(model.toMap());
}

Future<void> _demoNotification(RemoteMessage message) async {
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      "channel_id", 'channel_name',
      channelDescription: 'channel_description',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      showWhen: true,
      icon: "@mipmap/ic_launcher");

  var iOSChannelSpecifics = const IOSNotificationDetails(
    presentAlert: true,
    presentSound: true,
  );
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);

  String titleString = message.notification?.title ?? "";
  String messageString = message.notification?.body ?? '';

  await flutterLocalNotificationsPlugin.show(Random().nextInt(10), titleString,
      messageString, platformChannelSpecifics,
      payload: 'test');
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  printWrapped("Handling a background message: ${message.messageId}");
  await Firebase.initializeApp();
}
