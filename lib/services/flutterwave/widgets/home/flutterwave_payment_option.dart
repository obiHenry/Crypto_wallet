import 'package:flutter/material.dart';

class FlutterwavePaymentOption extends StatelessWidget {
  final Function handleClick;
  final String buttonText;
  final bool isManual;

  FlutterwavePaymentOption(
      {this.handleClick, this.buttonText, this.isManual = false});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: this.handleClick,
      color: Color(0xFFfff1d0),
      child: Container(
        width: double.infinity,
        child: RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            text: !isManual ? "Pay with " : "",
            style: TextStyle(fontSize: 20, color: Colors.black),
            children: [
              TextSpan(
                text: buttonText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
