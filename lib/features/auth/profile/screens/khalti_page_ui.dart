import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:test/constants/global_variables.dart';

class KhaltiPageUI extends StatefulWidget {
  const KhaltiPageUI({Key? key}) : super(key: key);

  @override
  State<KhaltiPageUI> createState() => _HomePageState();
}

class _HomePageState extends State<KhaltiPageUI> {
  String referenceId = "";
  TextEditingController amountController =
      TextEditingController(); // Controller for the text field

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Khalti Try Handim Na"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text field for entering the payment amount
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: amountController,
                keyboardType: TextInputType.number, // Allow only numeric input
                decoration: const InputDecoration(
                  labelText: "Enter Amount",
                ),
              ),
            ),

            // Button to initiate payment
            ElevatedButton(
              onPressed: () {
                String paymentAmount =
                    amountController.text; // Get the amount from the text field
                payWithKhaltiInApp(int.parse(
                    paymentAmount)); // Convert the string to an integer
              },
              child: const Text("Pay with Khalti"),
            ),

            Text(referenceId),
          ],
        ),
      ),
    );
  }

  void payWithKhaltiInApp(int amount) {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
        amount: amount * 100, // Convert the amount to paisa
        productIdentity: 'Product Id',
        productName: 'Product Name',
        mobileReadOnly: false,
      ),
      preferences: [
        PaymentPreference.khalti,
      ],
      onSuccess: onSuccess,
      onFailure: onFailure,
      onCancel: onCancel,
    );
  }

  void onSuccess(PaymentSuccessModel success) async {
    try {
      // Send the PaymentSuccessModel data as a GET request to the URL
      final response = await http.get(Uri.parse(
          '$uri/donation/khaltiResponse?idx=${success.idx}&amount=${success.amount}&token=${success.token}'));

      if (response.statusCode == 200) {
        // Successfully sent data to the server
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Payment Successful'),
              actions: [
                SimpleDialogOption(
                  child: const Text('OK'),
                  onPressed: () {
                    setState(() {
                      referenceId = success.idx;
                    });
                    Navigator.pop(context);
                  },
                )
              ],
            );
          },
        );
      } else {
        // Handle server response error
        print(
            'Failed to send data to server. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that occur during the request
      print('Error sending data to server: $e');
    }
  }

  void onFailure(PaymentFailureModel failure) {
    debugPrint(failure.toString());
  }

  void onCancel() {
    debugPrint('Cancelled');
  }

  @override
  void dispose() {
    amountController
        .dispose(); // Dispose of the controller when the widget is disposed
    super.dispose();
  }
}