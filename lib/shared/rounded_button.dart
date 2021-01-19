import 'package:flutter/material.dart';

import 'app_colors.dart';


class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton({
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
        
        borderRadius: BorderRadius.circular(29,),
        //  BoxDecoration(
        //       borderRadius: BorderRadius.all(
        //         Radius.circular(5),
        //       ),
              
        //       gradient: LinearGradient(
        //         begin: Alignment.centerLeft,
        //         end: Alignment.centerRight,
        //         colors: [yellowStart, yellowStart],
        //       ),
        //     ),
        child: RaisedButton(
          // disabledColor: Colors.grey,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: Colors.lightGreen,
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
