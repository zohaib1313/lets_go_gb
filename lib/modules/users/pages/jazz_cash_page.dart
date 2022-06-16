import 'package:flutter/material.dart';
// For accessing the Platform Channel functionality
import 'package:flutter/services.dart';

class PaymentJazzCash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: RaisedButton(
              onPressed: start,
              child: const Text('Pay'),
            ),
          ),
        ),
      ),
    );
  }

  static const platform = MethodChannel('com.flutter.letsgogb');
  void start() async {
    Map<String, String> data = {
      "price": "400000",
      /* "Jazz_MerchantID": "MC37891",
      "Jazz_Password": "0u92fwz8t8",
      "Jazz_IntegritySalt": "1y4d9s9v5c",
      "paymentReturnUrl": "https://localhost:2020/"*/

      "Jazz_MerchantID": "MC37891",
      "Jazz_Password": "0u92fwz8t8",
      "Jazz_IntegritySalt": "1y4d9s9v5c",
      "paymentReturnUrl":
          "https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction"
    };
    String value = "";

    try {
      value = await platform.invokeMethod("Print", data);
    } catch (e) {
      print(e);
    }

    print(value.toString());
  }
}
