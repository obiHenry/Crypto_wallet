import 'package:Crypto_wallet/shared/app_colors.dart';
import 'package:flutter/material.dart';

class ButtonText extends StatelessWidget {
  final Function press;
  final String text;
  final Color color;
  final IconData icon;
  ButtonText({
    this.press,
    this.text,
    this.color = yellowStart,
    this.icon ,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.82,
   
      child: InkWell(
        onTap: press,
        child: Container(
            // width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [yellowStart, yellowEnd],
              ),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Container(
                  //   // padding: EdgeInsets.all(10),
                  //   child: Icon(
                  //     icon,
                  //     // color: Colors.blue,
                  //   ),
                  // ),
                  Container(
                    // padding: EdgeInsets.all(10),
                    // child: Center(
                      width: 250,

                      child: SelectableText(
                        text,
                        style: TextStyle(fontSize: 16,color: Colors.white),
                        cursorColor: Colors.black54,
                        
                      ),
                    // ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}