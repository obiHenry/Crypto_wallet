import 'package:Crypto_wallet/screens/logins_and_signUp/account_registration/account_pin_code_setup/body.dart';
import 'package:flutter/material.dart';

class AccountPinCodeSetup extends StatelessWidget {
  final String initailCode;
  AccountPinCodeSetup({this.initailCode});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
