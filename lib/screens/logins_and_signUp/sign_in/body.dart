import 'package:Crypto_wallet/services/auth.dart';
import 'package:Crypto_wallet/services/validator.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../../shared/shared.dart';

class Body extends StatefulWidget {
  _BodyState createState() => _BodyState();
}

bool enableButton = false;

class _BodyState extends State<Body> {
  final AuthService _auth = AuthService();

  getSnackBar(String value, MaterialColor color) {
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

    if ((pwd == null) && (em == null)) {
      setState(() {
        enableButton = true;
      });
    } else {
      setState(() {
        enableButton = false;
      });
    }
  }

  String email = "";

  String password = "";

  String confirmPassword = "";

  bool _loader = false;
  bool showPassword = true;

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
                Text('Sign in to continue', style: welcomeSubStyle),
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
                    if (isValid == null) {
                      enableSubmitButton();
                      getSnackBar(
                        ' valid ',
                        Colors.lightGreen,
                      );
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
                    password = value.trim().toLowerCase();
                    String isValid = Validators.password(password);
                    setState(() {
                      enableButton = false;
                    });
                    if (isValid == null) {
                      enableSubmitButton();
                      getSnackBar(
                        ' valid ',
                        Colors.lightGreen,
                      );
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
                SizedBox(height: 30),
                Container(
                  child: !_loader
                      ? RaisedButton(
                        color: yellowStart,
                        disabledColor: Colors.grey,
                          onPressed: !enableButton? 
                          null
                          :() async {
                            setState(() {
                              _loader = true;
                            });
                            dynamic result =
                                await _auth.signInWithEmail(email, password);
                            setState(() {
                              _loader = false;
                            });
                            dynamic users = await _auth.getUserDataById();

                            if (result['status']) {
                              if (users.containsKey('userName')) {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    'tab_screen', (route) => false);
                                getSnackBar(
                                  'signed in successfully',
                                  Colors.lightGreen,
                                );
                              } else {
                                Navigator.of(context).pushNamed(
                                  'set_up',
                                );
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

                            // Navigator.pushNamedAndRemoveUntil(context, 'bitcoin',
                            //     (Route<dynamic> route) => false);
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
                                'Login',
                                style: loginButtonLabel,
                              ),
                            ),
                          ),
                        )
                      : CircularProgressIndicator(),
                ),
                SizedBox(height: 25),
                 Container(
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t  have an Account?',
                        style: TextStyle(color: Colors.white),
                      ),
                      FlatButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, 'sign_up');
                          },
                          child: Text(
                            'sign up',
                            style: TextStyle(color: yellowEnd, fontSize: 15),
                          ))
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Text('Forgot your password?', style: forgotPassword),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
