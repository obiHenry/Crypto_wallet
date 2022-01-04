// import 'package:pin_code_view/pin_code_view.dart';
import 'package:flutter/material.dart';
import 'package:Crypto_wallet/services/auth.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'dart:async';
import 'package:Crypto_wallet/services/code_view.dart/pin_code_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import 'account_pin_code_setup_screen.dart';

class ConfirmPinCodeScreen extends StatefulWidget {
  final String initailCode,title,subtitle;
  final Function dofailMethod;
  final Function doSuccessMethod ;
  final bool fromTransaction;
  ConfirmPinCodeScreen(
      {this.initailCode,
      this.doSuccessMethod ,
      this.dofailMethod,
      this.fromTransaction,this.subtitle,this.title});

  @override
  _ConfirmPinCodeScreenState createState() => _ConfirmPinCodeScreenState();
}

class _ConfirmPinCodeScreenState extends State<ConfirmPinCodeScreen> {
  StreamController<ErrorAnimationType> errorController;
  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  bool isSuccess = false;
  bool output = false;

  // getSnackBar(
  //   String value,
  //   MaterialColor color,
  // ) {
  //   Scaffold.of(context).removeCurrentSnackBar();
  //   Scaffold.of(context).showSnackBar(
  //     SnackBar(
  //       content: new Text(
  //         value,
  //         textAlign: TextAlign.center,
  //         style: TextStyle(
  //           color: Colors.white,
  //           fontSize: 16.0,
  //           fontFamily: "WorkSansSemiBold",
  //         ),
  //       ),
  //       backgroundColor: color,
  //       duration: Duration(seconds: 3),
  //     ),
  //   );
  // }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  Widget build(BuildContext context) {
    String usersTransactionPin;
    return Scaffold(
      body: PinCode(
        title: Text(widget.fromTransaction?widget.title:
          "Confirm pin",
          style: TextStyle(
              color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
        obscurePin: true,

        subTitle: Text( widget.fromTransaction?widget.subtitle:
          "Enter the Transaction pin again",
          style: TextStyle(color: Colors.white),
        ),
        codeLength: 4,
        // you may skip correctPin and plugin will give you pin as
        // call back of [onCodeFail] before it clears pin
        correctPin: widget.initailCode,
        onCodeSuccess: (code) async {
          if (widget.fromTransaction) {
            setState(() {
              isSuccess = true;
              output = true;
            });
            widget.doSuccessMethod();
          } else {
            setState(() {
              isSuccess = true;
              output = true;
            });

            usersTransactionPin = code;
            print('correct');
            print(usersTransactionPin);
            dynamic result =
                await AuthService().setTransactionPin(usersTransactionPin);
            if (result['status']) {
              Navigator.pushNamedAndRemoveUntil(
                  context, 'tab_screen', (route) => false);
              Fluttertoast.showToast(
                  msg: 'transaction pin saved successfully',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.black,
                  textColor: Colors.white);
              setState(() {
                output = false;
              });
            } else {
              setState(() {
                output = false;
              });
              Fluttertoast.showToast(
                  msg: result['message'].toString(),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.black,
                  textColor: Colors.white);
              print(result['message']);
            }
          }
        },
        error: isSuccess ? 'correct!' : 'Incorrect pin!',
        isError: output,
        errorTextStyle: isSuccess
            ? TextStyle(
                color: Colors.white,
              )
            : TextStyle(color: Colors.red),

        onCodeFail: (code) {
          setState(() {
            // error = true;
            output = true;
            isSuccess = false;
          });
          // if (widget.fromTransaction) {
          //   // ignore: unnecessary_statements
          //   widget.dofailMethod;
          // }

          // getSnackBar('pin do not match', Colors.red);
          print('incorrect');
        },
      ),
    );
  }
}
