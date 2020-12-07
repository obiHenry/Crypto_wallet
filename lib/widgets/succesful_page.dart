import 'package:Crypto_wallet/shared/app_colors.dart';
import 'package:Crypto_wallet/widgets/button.dart';
import 'package:flutter/material.dart';

class SuccessfulPage extends StatefulWidget {
  final String text, text1;
  final Function press, press1;
  SuccessfulPage({
    this.text,

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
                  bottomRight: Radius.circular(190),
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // SizedBox(height: 10),
                      Container(
                        height: 150,
                        width: 150,
                        child: Image.asset('assets/images/done.jpg', fit: BoxFit.cover,)),
                      // SizedBox(height: 55),
                      // SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(6.5),
                              child: Text(
                                '${widget.text} ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    // fontWeight: FontWeight.bold
                                    ),
                              ),
                            ),
                            // SvgPicture.asset('assets/images/back.svg',
                            //     color: Colors.transparent),
                          ],
                        ),
                      ),
                    
                      // SizedBox(
                      //   height: 10,
                      // ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                         widget.text1,
                          // widget.currency['name'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
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
