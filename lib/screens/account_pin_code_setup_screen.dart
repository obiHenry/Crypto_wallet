import 'package:Crypto_wallet/screens_component/pin_code_setup_components/body.dart';
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
