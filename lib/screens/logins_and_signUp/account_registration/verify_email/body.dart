import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:Crypto_wallet/services/auth.dart';
import 'dart:math';
import 'package:Crypto_wallet/services/api_services.dart';
import 'dart:convert';

class PinCodeVerificationScreen extends StatefulWidget {
  final String email;
  final String token;

  PinCodeVerificationScreen({this.email, this.token});

  @override
  _PinCodeVerificationScreenState createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  bool processing = false;
  bool resendClicked = false;
  bool loading = false;
  dynamic gottenToken;
  String token;

  getSnackBar(
    String value,
    MaterialColor color,
  ) {
    Scaffold.of(context).removeCurrentSnackBar();
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: new Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold",
          ),
        ),
        backgroundColor: color,
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  void initState() {
    token = widget.token;
    // token = resendClicked ? gottenToken : widget.token;

    onTapRecognizer = TapGestureRecognizer()..onTap = () async {};
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  resendMessage() async {
    setState(() {
      resendClicked = true;
      loading = true;
    });
    dynamic user = await AuthService().getUserDataById();
    var rnd = new Random();
    var next = rnd.nextDouble() * 1000000;
    while (next < 100000) {
      next *= 10;
    }
    print('rndomnumber ${next.toInt()}');
    gottenToken = next.toInt();
    print('gottenToken $gottenToken');

    // if (resendClicked) {
    token = gottenToken.toString();
    // } else {
    //   token = widget.token;
    // }

    // dynamic userName = user['userName'].toString();
    String email = user['email'].toString();
    var userName = email.split('@').take(1);
    print(userName.toString());
    dynamic result1 = await ApiServices().sendEmailVerificationToken(
        userEmail: user['email'],
        subject: 'Email address verification',
        content:
            'Verify your email for Veloce,    Use the code below to verify  your email.   $token ',
        userName: userName);
    if (result1['status']) {
      dynamic result2 = json.decode(result1['message']);

      if (result2['status'] == '1') {
        print('this is the email result ${result1['message'].toString()}');
        getSnackBar('Sent', Colors.lightGreen);

        setState(() {
          loading = false;
        });
      } else {
        getSnackBar(result2['response'].toString(), Colors.lightGreen);

        // getSnackBar(
        //   result2['response'].toString(),
        //   Colors.red,
        // );
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      key: scaffoldKey,
      body: GestureDetector(
        onTap: () {},
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 30),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: FlareActor(
                  "assets/otp.flr",
                  animation: "otp",
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.center,
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Email Address Verification',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: RichText(
                  text: TextSpan(
                      text: "Enter the code sent to ",
                      children: [
                        TextSpan(
                            text: widget.email,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                        //       TextSpan(
                        // text: 'check your spam if u didnt see it in the primary',
                        // style: TextStyle(
                        //     color: Colors.black,
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 14)),
                      ],
                      style: TextStyle(color: Colors.black54, fontSize: 15)),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(child: Text('check your spam if u didn\'t see the mail in the primary')),
              SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 10),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green,
                        // backgroundColor: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      obscureText: false,
                      obscuringCharacter: '*',
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v.length < 3) {
                          return "I'm from validator";
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 60,
                        fieldWidth: 50,
                        // activeColor: Colors.white,
                        activeFillColor:
                            hasError ? Colors.orange : Colors.white,
                      ),
                      cursorColor: Colors.black,
                      animationDuration: Duration(milliseconds: 300),
                      textStyle: TextStyle(fontSize: 20, height: 1.6),
                      backgroundColor: Colors.blue.shade50,

                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      boxShadows: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        print("Completed");
                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? "*Please fill up all the cells correctly with the code sent to you" : "",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Didn\'t receive the code? ',
                    style: TextStyle(color: Colors.black54, fontSize: 17.5),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        resendClicked = true;
                        // loading = true;
                      });
                      resendMessage();
                    },
                    child: loading
                        ? CircularProgressIndicator()
                        : Text(
                            " RESEND",
                            style: TextStyle(
                                color: Color(0xFF91D3B3),
                                fontWeight: FontWeight.bold,
                                fontSize: 19),
                          ),
                  ),
                ],
              ),
              // RichText(
              //   textAlign: TextAlign.center,
              //   text: TextSpan(
              //       text: "Didn't receive the code? ",
              //       style: TextStyle(color: Colors.black54, fontSize: 15),
              //       children: [
              //         loading
              //             ? CircularProgressIndicator()
              //             : TextSpan(
              //                 text: " RESEND",
              //                 recognizer: onTapRecognizer,
              //                 style: TextStyle(
              //                     color: Color(0xFF91D3B3),
              //                     fontWeight: FontWeight.bold,
              //                     fontSize: 16),
              //               )
              //       ]),
              // ),
              SizedBox(
                height: 14,
              ),
              processing
                  ? CircularProgressIndicator()
                  : Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 30),
                      child: ButtonTheme(
                        height: 50,
                        child: FlatButton(
                          onPressed: () async {
                            setState(() {
                              processing = true;
                            });
                            formKey.currentState.validate();
                            // conditions for validating
                            print(token);
                            if (currentText.length != 6 ||
                                currentText != token) {
                              errorController.add(ErrorAnimationType
                                  .shake); // Triggering error shake animation
                              setState(() {
                                hasError = true;
                                processing = false;
                              });
                            } else {
                              dynamic result1 =
                                  await AuthService().verifyUser();
                              if (result1['status']) {
                                setState(() {
                                  processing = false;
                                  hasError = false;
                                  scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                    content: Text("verified"),
                                    duration: Duration(seconds: 4),
                                  ));
                                });
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    'set_up', (route) => false);
                              } else {
                                scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(result1['message']),
                                  duration: Duration(seconds: 4),
                                ));
                              }
                            }
                          },
                          child: Center(
                              child: Text(
                            "VERIFY".toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.green.shade300,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.green.shade200,
                                offset: Offset(1, -2),
                                blurRadius: 5),
                            BoxShadow(
                                color: Colors.green.shade200,
                                offset: Offset(-1, 2),
                                blurRadius: 5)
                          ]),
                    ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: Text("Clear"),
                    onPressed: () {
                      textEditingController.clear();
                    },
                  ),
                  FlatButton(
                    child: Text("Set Text"),
                    onPressed: () {
                      textEditingController.text = "123456";
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
