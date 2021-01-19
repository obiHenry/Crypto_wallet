import 'package:Crypto_wallet/shared/app_colors.dart';
import 'package:flutter/material.dart';

class BillsButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const BillsButton({
    Key key,
    this.text,
    this.press,
    this.color = yellowStart,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8, 
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          disabledColor: Colors.grey,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: color,
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}