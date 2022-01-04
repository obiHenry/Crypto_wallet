import 'package:Crypto_wallet/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Crypto_wallet/screens/tab_screen.dart';


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
      return SiginScreen();
    } else {
      return TabScreen();
    }
  }
}
