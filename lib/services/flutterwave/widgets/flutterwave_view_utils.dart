import 'package:flutter/material.dart';

class FlutterwaveViewUtils {

  /// Displays a modal to confirm payment
  static Future<void> showConfirmPaymentModal(final BuildContext context,
      final String currency, final String amount, final Function onContinuePressed) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          content: Container(
            margin: EdgeInsets.fromLTRB(20, 30, 20, 20),
            child: Text(
              "You will be charged a total of $currency "
              "$amount. Do you wish to continue? ",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                letterSpacing: 1.2,
              ),
            ),
          ),
          actions: [
            //Changed Continue to the right as confirmation buttons tend to be on the right for better UX.
            FlatButton(
              onPressed: () => {Navigator.of(context).pop()},
              child: Text(
                "CANCEL",
                style: TextStyle(fontSize: 16, letterSpacing: 1),
              ),
            ),
            FlatButton(
              onPressed: onContinuePressed,
              child: Text(
                "CONTINUE",
                style: TextStyle(fontSize: 16, letterSpacing: 1),
              ),
            ),

          ],
        );
      },
    );
  }
}
