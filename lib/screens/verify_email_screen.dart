
import 'package:Crypto_wallet/screens_component/verify_email_components/body.dart';
import 'package:flutter/material.dart';

class VerifyEmailAddress extends StatelessWidget {
  final Map user;
  VerifyEmailAddress(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Email Address'),
        backgroundColor: Colors.blue.shade50,
        elevation: 0,
      ),
      body: PinCodeVerificationScreen(email: user['email'], token: user['token'].toString(),fromExternal: user['fromExternal'],onVerifySuccess: user['onVerifySuccess'],mailContent: user['mailContent'],mailSubject: user['mailSubject'],),
    );
  }
}
