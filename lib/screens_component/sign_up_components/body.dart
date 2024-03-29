// import 'dart:html';

import 'package:Crypto_wallet/screens/signin_screen.dart';
import 'package:Crypto_wallet/services/auth.dart';
import 'package:Crypto_wallet/services/validator.dart';
import 'package:Crypto_wallet/services/api_services.dart';
import 'package:Crypto_wallet/shared/app_colors.dart';
import 'package:Crypto_wallet/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math';
import 'dart:convert';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

bool showPassword = true;
bool enableButton = false;

class _BodyState extends State<Body> {
  // final _formKey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();

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

  void enableSubmitButton() {
    String pwd = Validators.password(password);
    String em = Validators.email(email);
    String cp = Validators.confirmPassword(confirmPassword);

    if ((pwd == null) && (em == null) && (cp == null)) {
      setState(() {
        enableButton = true;
      });
    } else {
      setState(() {
        enableButton = false;
      });
    }
  }

  void getTokenNumber() {}

  String email = "";

  String password = "";

  String confirmPassword = "";

  bool _loader = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.amberAccent,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [lightBlueStart, lightBlueEnd],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: MediaQuery.of(context).size.height / 1.10,
                right: MediaQuery.of(context).size.width / 5,
                child: RotationTransition(
                  turns: AlwaysStoppedAnimation(45 / 360),
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: rectColorLightBlue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height / 1.20,
                right: MediaQuery.of(context).size.width / 13,
                child: RotationTransition(
                  turns: AlwaysStoppedAnimation(45 / 360),
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: rectColorLightBlue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height / 1.4,
                right: MediaQuery.of(context).size.width / 4.8,
                child: RotationTransition(
                  turns: AlwaysStoppedAnimation(45 / 360),
                  child: Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      color: rectColorLightBlue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height / 2.4,
                left: MediaQuery.of(context).size.width / 1.33,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: rectColorLightBlue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(150),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2,
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SvgPicture.asset('assets/images/logo.svg'),
                SizedBox(height: 25),
                Text('Welcome,', style: welcomeStyle),
                Text('Sign up to continue', style: welcomeSubStyle),
                Text(
                  'If you already have an account with us then login',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2,
            padding: EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              color: blueMain,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(50),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  // initialValue: 'hello@work.com',
                  onChanged: (value) {
                    email = value.trim().toLowerCase();
                    String isValid = Validators.email(email);
                    setState(() {
                      enableButton = false;
                    });
                    print(isValid);
                    if (isValid == null) {
                      enableSubmitButton();
                      setState(() {
                        getSnackBar(
                          ' valid ',
                          Colors.lightGreen,
                        );
                      });
                    } else {
                      getSnackBar(
                        isValid,
                        Colors.red,
                      );
                    }
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: textFieldLabel,
                    fillColor: Colors.white,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  // initialValue: '123456',
                  onChanged: (value) {
                    password = value;
                    String isValid = Validators.password(password);

                    setState(() {
                      enableButton = false;
                    });
                    print(isValid);
                    if (isValid == null) {
                      if (confirmPassword == password) {
                        enableSubmitButton();
                        setState(() {
                          getSnackBar(
                            'passwords okay',
                            Colors.lightGreen,
                          );
                        });
                      } else {
                        setState(() {
                          getSnackBar(
                            'passwords do not match',
                            Colors.red,
                          );
                        });
                      }
                    } else {
                      getSnackBar(
                        isValid,
                        Colors.red,
                      );
                    }
                  },
                  obscureText: showPassword,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: textFieldLabel,
                    fillColor: Colors.white,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54),
                    ),
                    suffixIcon: showPassword
                        ? IconButton(
                            icon: Icon(Icons.visibility_off),
                            color: Colors.white,
                            onPressed: () {
                              setState(() {
                                showPassword = false;
                              });
                            },
                          )
                        : IconButton(
                            icon: Icon(Icons.visibility),
                            color: Colors.white,
                            onPressed: () {
                              setState(() {
                                showPassword = true;
                              });
                            },
                          ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  // initialValue: '123456',
                  onChanged: (value) {
                    confirmPassword = value;
                    String isValid = Validators.confirmPassword(
                      value,
                    );

                    setState(() {
                      enableButton = false;
                    });
                    print(isValid);
                    if (isValid == null) {
                      if (confirmPassword == password) {
                        enableSubmitButton();
                        setState(() {
                          getSnackBar(
                            'passwords okay',
                            Colors.lightGreen,
                          );
                        });
                      } else {
                        setState(() {
                          getSnackBar(
                            'passwords do not match',
                            Colors.red,
                          );
                        });
                      }
                    } else {
                      getSnackBar(
                        isValid,
                        Colors.red,
                      );
                    }
                  },
                  obscureText: showPassword,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Confirm password',
                    labelStyle: textFieldLabel,
                    fillColor: Colors.white,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54),
                    ),
                    suffixIcon: showPassword
                        ? IconButton(
                            icon: Icon(Icons.visibility_off),
                            color: Colors.white,
                            onPressed: () {
                              setState(() {
                                showPassword = false;
                              });
                            },
                          )
                        : IconButton(
                            icon: Icon(Icons.visibility),
                            color: Colors.white,
                            onPressed: () {
                              setState(() {
                                showPassword = true;
                              });
                            },
                          ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  child: !_loader
                      ? RaisedButton(
                          onPressed: !enableButton
                              ? null
                              : () async {
                                  setState(() {
                                    _loader = true;
                                  });

                                  dynamic result = await _auth
                                      .registerWithEmail(email, password);

                                  if (result['status']) {

                                    
                                    dynamic user =
                                        await _auth.getUserDataById();
                                    var rnd = new Random();
                                    var next = rnd.nextDouble() * 1000000;
                                    while (next < 100000) {
                                      next *= 10;
                                    }
                                    print('rndomnumber ${next.toInt()}');
                                    dynamic token = next.toInt();
                                    // dynamic userName = user['userName'].toString();
                                    // String email = user['email'].toString();
                                    var userName = email.split('@').take(1);
                                    // print(userName.toString());
                                    dynamic result1 = await ApiServices()
                                        .sendEmailVerificationToken(
                                            userEmail: user['email'],
                                            subject:
                                                'Email address verification',
                                            content:
                                                'Verify your email for Veloce,    Use the code below to verify  your email.   $token ',
                                            userName: userName);
                                    if (result1['status']) {
                                      dynamic result2 =
                                          json.decode(result1['message']);

                                      if (result2['status'] == '1') {
                                        print(
                                            'this is the email result ${result1['message'].toString()}');

                                        Navigator.of(context).pushNamed(
                                            'verification_screen',
                                            arguments: {
                                              'email': user['email'],
                                              'token': token.toString(),
                                              'fromExternal': false,
                                            });
                                        setState(() {
                                          _loader = false;
                                        });
                                      } else {
                                        getSnackBar(
                                          result2['response'].toString(),
                                          Colors.red,
                                        );
                                        setState(() {
                                          _loader = false;
                                        });
                                        print(result2['response'].toString());
                                      }
                                    } else {
                                      getSnackBar(
                                          result1['message'], Colors.red);
                                      print(result1['message'].toString());
                                      setState(() {
                                        _loader = false;
                                      });
                                    }
                                  } else {
                                    String msg = (result['message'] != null &&
                                            result['message'].isNotEmpty)
                                        ? result['message']
                                        : 'An unknown error occured; retry';
                                    getSnackBar(
                                      msg,
                                      Colors.red,
                                    );
                                  }
                                },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),

                              // gradient: LinearGradient(
                              //   begin: Alignment.centerLeft,
                              //   end: Alignment.centerRight,
                              //   colors: [yellowStart, yellowEnd],
                              // ),
                            ),
                            child: Center(
                              child: Text(
                                'Sign up',
                                style: loginButtonLabel,
                              ),
                            ),
                          ),
                          disabledColor: Colors.grey,
                          color: yellowStart,
                        )
                      : CircularProgressIndicator(),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an Account?',
                        style: TextStyle(color: Colors.white),
                      ),
                      FlatButton(
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SiginScreen()));
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(color: yellowEnd, fontSize: 15),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
