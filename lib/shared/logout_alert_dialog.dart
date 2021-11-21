import 'package:flutter/material.dart';
import 'package:Crypto_wallet/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Crypto_wallet/screens/wrapper_screen.dart';

class LogoutAlertDialog extends StatefulWidget {
  final Function yesPressed;
  final bool userIsnull;
  LogoutAlertDialog({
    this.yesPressed,
    this.userIsnull,
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
            onPressed:
                // widget.yesPressed,
                () async {
              Map res = await _auth.signOut();

              if (res['status']) {
                Fluttertoast.showToast(
                    msg: 'You are logged out',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black,
                    textColor: Colors.white);
                setState(() {
                  userIsNull = true;
                });
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => WrapperScreen(),));
              } else {
                Fluttertoast.showToast(
                    msg: res['message'].toString(),
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black,
                    textColor: Colors.white);
                setState(() {
                  userIsNull = false;
                });
                Navigator.of(context).pop();
              }
            }
            //  Navigator.of(context).pop();

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
