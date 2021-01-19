import 'package:flutter/material.dart';
import 'package:Crypto_wallet/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogoutAlertDialog extends StatefulWidget {
  final Function yesPressed;
  LogoutAlertDialog({
    this.yesPressed,
  });

  @override
  _LogoutAlertDialogState createState() => _LogoutAlertDialogState();
}

class _LogoutAlertDialogState extends State<LogoutAlertDialog> {
  bool userIsNull;
  @override
  void initState() {
    if (user == null) {
      setState(() {
        userIsNull = true;
      });
    } else {
      setState(() {
        userIsNull = false;
      });
    }
    super.initState();
  }

  dynamic _auth = AuthService();
  var user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Sign out"),
      content: Text("Do you want to Sign out?"),
      actions: [
        FlatButton(
            child: Text("Yes"),
            onPressed: widget.yesPressed,
             
            ),
        FlatButton(
          child: Text("No"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
