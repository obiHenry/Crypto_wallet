import 'package:Crypto_wallet/Screens/logins_and_signUp/password_reset/components/pwd_reset.dart';
import 'package:flutter/material.dart';

class PassReset extends StatefulWidget {
  @override
  _PassResetState createState() => _PassResetState();
}

class _PassResetState extends State<PassReset> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PasswordReset(),
    );
  }
}
