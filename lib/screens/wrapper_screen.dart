import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Crypto_wallet/screens/tab_Screen/tab_screen.dart';
import 'package:Crypto_wallet/screens/logins_and_signUp/sign_in/login.dart';


class WrapperScreen extends StatefulWidget {
  @override
  _WrapperScreenState createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<WrapperScreen> {
 
  @override
  Widget build(BuildContext context) {
    return _decisionWrapper();
  }

  Widget _decisionWrapper() {
    dynamic user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Login();
    } else {
      return TabScreen();
    }
  }
}
