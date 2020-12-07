import 'package:flutter/material.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';

class PaymentService {
  String selectedCurrency = "NGN";
  // String publicKey = 'FLWPUBK_TEST-SANDBOXDEMOKEY-X';
  // String encryptionKey = 'FLWSECK_TEST74e0b6c7db0e';

  final String publicKey = 'FLWPUBK-4ab13dc3cc43187792d94cdcb1ba7d8e-X';
  final String encryptionKey = 'dd78218a4fe9f20af0f8347a';

  Future handlePaymentInitialization(
      BuildContext context, String amount, Map user) async {
    String txRef = DateTime.now().toIso8601String();

    final flutterwave = Flutterwave.forUIPayment(
      amount: amount,
      currency: selectedCurrency,
      context: context,
      publicKey: publicKey,
      email: user['email'],
      fullName: user['userName'],
      txRef: txRef,
      narration: 'Payment for products ordered',
      phoneNumber: user['mobile'],
      
      acceptAccountPayment: true,
      acceptCardPayment: true,
      acceptUSSDPayment: true,
      isDebugMode: false,
      encryptionKey: encryptionKey,
    );
    try {
      final ChargeResponse response =
          await flutterwave.initializeForUiPayments();
      String msg = response.status;
      if (response != null) {
        final isSuccessful = checkPaymentIsSuccessful(
          response,
          selectedCurrency,
          amount,
          txRef,
        );
        return isSuccessful
            ? {'status': true, 'message': msg}
            : {'status': false, 'message': msg};
      } else {
        return {'status': false, 'message': msg != null ? msg : 'No Response!'};
      }
    } catch (error) {
      return {'status': false, 'message': 'Payment not successful; aborted'};
    }
  }

  bool checkPaymentIsSuccessful(final ChargeResponse response, String currency,
      String amount, String txRef) {
    return response.data.status == FlutterwaveConstants.SUCCESSFUL &&
        response.data.currency == currency &&
        double.parse(response.data.amount).toStringAsFixed(2) == amount &&
        response.data.txRef == txRef;
  }
}
