import 'package:Crypto_wallet/shared/rounded_button.dart';
import 'package:Crypto_wallet/shared/rounded_input_field.dart';
import 'package:Crypto_wallet/shared/constants.dart';
import 'package:Crypto_wallet/services/auth.dart';
import 'package:Crypto_wallet/services/dialog_service.dart';
import 'package:Crypto_wallet/services/validator.dart';
import 'package:flutter/material.dart';
import 'package:Crypto_wallet/screens/logins_and_signUp/sign_in/login.dart';


import 'background.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({
    Key key,
  }) : super(key: key);
  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final AuthService _auth = AuthService();
  final DialogService _dialog = DialogService();
  bool _loader = false;
  bool enableButton = false;
  String email = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Reset Password",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                email = value.toLowerCase();
                String isValid = Validators.email(value);
                setState(() {
                  enableButton = false;
                });
                if (isValid == null) {
                  enableSubmitButton();
                  _dialog.getSnackBar(
                      context, 'This is a valid email', Colors.green);
                } else {
                  _dialog.getSnackBar(context, isValid, Colors.red);
                }
              },
            ),
            !_loader
                ? RoundedButton(
                    text: "Submit",
                    press: !enableButton
                        ? null
                        : () async {
                            try {
                              setState(() {
                                _loader = true;
                              });
                              dynamic result =
                                  await _auth.sendPasswordResetEmail(
                                      email.trim().toLowerCase());

                              setState(() {
                                _loader = false;
                              });
                              if (result['status']) {
                                _dialog.getSnackBar(
                                    context, result['message'], Colors.green);
                                Future.delayed(Duration(seconds: 2), () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()),
                                      (route) => false);
                                 
                                });
                              } else {
                                String msg = (result['message'] != null &&
                                        result['message'].isNotEmpty)
                                    ? result['message']
                                    : 'An unknown error occured; retry';
                                _dialog.getSnackBar(context, msg, Colors.red);
                              }
                            } catch (e) {
                              print(e.toString());
                              _dialog.getSnackBar(context,
                                  'Something went wrong; retry', Colors.red);
                            }
                          },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
            FlatButton(
              child: Text(
                'Return to Login',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void enableSubmitButton() {
    String em = Validators.email(email);

    if (em == null) {
      setState(() {
        enableButton = true;
      });
    } else {
      setState(() {
        enableButton = false;
      });
    }
  }
}
