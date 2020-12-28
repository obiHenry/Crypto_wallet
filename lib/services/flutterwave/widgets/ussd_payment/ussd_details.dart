import 'package:flutter/material.dart';
import 'package:Crypto_wallet/services/flutterwave/models/requests/authorization.dart';
import 'package:Crypto_wallet/services/flutterwave/models/responses/charge_response.dart';

class USSDDetails extends StatelessWidget {
  final Function _onPaymentMade;
  final ChargeResponse _chargeResponse;

  USSDDetails(this._chargeResponse, this._onPaymentMade);

  @override
  Widget build(BuildContext context) {
    final Authorization authorization = this._chargeResponse.meta.authorization;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        children: [
          Text(
            "Dial the code below to complete the payment:",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          SizedBox(height: 60),
          Text(
            authorization.note,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 60),
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: "Payment code:  ",
              style: TextStyle(fontSize: 17, color: Colors.black),
              children: [
                TextSpan(
                  text: this._chargeResponse.data.paymentCode,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                )
              ],
            ),
          ),
          SizedBox(height: 60),
          Container(
            height: 40,
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: RaisedButton(
              onPressed: this._onPaymentMade,
              color: Colors.orange,
              child: Text(
                "I have made the transfer",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
