import 'package:flutter/material.dart';
// For accessing the Platform Channel functionality
import 'package:flutter/services.dart';

class PaymentJazzCash extends StatelessWidget {
// Reference to the PlatformChannel
  // com.<YOUR_APPLICATION_NAME>/<YOUR_FUNCTION_NAME>
  static const platform = MethodChannel('com.flutter.khadijadev');

// Integrity Salt given by JazzCash
  // The salt is used in coordination with the hashing function
  static const integritySalt = '##########';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: RaisedButton(
              onPressed: pay,
              child: const Text('Pay'),
            ),
          ),
        ),
      ),
    );
  }

  void pay() async {
    Map<String, String> data = {
      "price": "10000",
      "Jazz_MerchantID": "MC37891",
      "Jazz_Password": "0u92fwz8t8",
      "Jazz_IntegritySalt": "1y4d9s9v5c",
      "paymentReturnUrl":
          "https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction"
      // "Jazz_MerchantID": "MC23528",
      // "Jazz_Password": "ye2t64auzz",
      // "Jazz_IntegritySalt": "2z134uey1s",
      // "paymentReturnUrl":
      //     "https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction"
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
