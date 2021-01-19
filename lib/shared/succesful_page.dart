import 'package:Crypto_wallet/shared/app_colors.dart';
import 'package:Crypto_wallet/shared/button.dart';
import 'package:flutter/material.dart';

class SuccessfulPage extends StatefulWidget {
  final String text, text1, text2;
  final Function press, press1;
  SuccessfulPage({
    this.text,
    this.text2,
    this.press,
    this.press1,
    this.text1,
  });

  @override
  _SuccessfulPageState createState() => _SuccessfulPageState();
}

class _SuccessfulPageState extends State<SuccessfulPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlueStart,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: BoxDecoration(
                color: yellowEndWallet,
                gradient: LinearGradient(
                  // yellowStartWallet, yellowEndWallet
                  colors: [
                    Colors.green,
                    Colors.lightGreen,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment(0.6, 0.3),
                ),
                borderRadius: BorderRadius.only(
                  // bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(160),
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                       Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 100),
                        // child: FittedBox(
                          child: Text(
                            widget.text1,
                            // widget.currency['name'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          // ),
                        ),
                      ),
                      SizedBox(height: 10),
                       Container(
                         alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 5, right: 5, top: 10),
                        // child: FittedBox(
                          child: Text(
                            '${widget.text} ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              // fontWeight: FontWeight.bold
                            ),
                          ),
                        // ),
                      ),
                      SizedBox(height: 30,),
                      Container(
                          height: 100,
                          width: 100,
                          child: Image.asset(
                            'assets/images/success_logo.png',
                            fit: BoxFit.cover,
                          )),
                      // SizedBox(height: 55),
                      // SizedBox(height: 10),
                     

                      // SizedBox(
                      //   height: 10,
                      // ),
                     

                      widget.text2 != null
                          ? Container(
                              padding:
                                  EdgeInsets.only(left: 5, right: 5, top: 10),
                              // child: FittedBox(
                              child: Text(
                                widget.text2,
                                // widget.currency['name'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              // ),
                            )
                          : Container(),
                    ],
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * .12,
                    left: -5,
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(45 / 360),
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * .16,
                    left: MediaQuery.of(context).size.width * 0.05,
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(45 / 360),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * .05,
                    right: 30,
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(45 / 360),
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * .09,
                    right: -15,
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(45 / 360),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 180,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(80),
                // bottomRight: Radius.circular(30),
              )),
              child: Column(
                children: [
                  Button(
                    text: 'Go To Home',
                    press: widget.press,
                  ),
                  // SizedBox(height: 10,),

                  // Button(
                  //   text: 'Do more ${widget.text}',
                  //   press: widget.press1,
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
