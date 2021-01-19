import 'package:Crypto_wallet/services/code_view.dart/pin_code_view.dart';
import 'package:flutter/material.dart';

import 'confirm_pin_code_screen.dart';

class Body extends StatelessWidget {
  // final String initailCode;
  // Body({this.initailCode});

  Widget build(BuildContext context) {
    String inputtedCode;
    return PinCode(
      title: Text(
        "Set Transaction pin",
        style: TextStyle(
            color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
      ),
      obscurePin: true,

      subTitle: Text(
        "Enter your Transaction pin",
        style: TextStyle(color: Colors.white),
      ),
      codeLength: 4,
      
      // you may skip correctPin and plugin will give you pin as
      // call back of [onCodeFail] before it clears pin
      correctPin: inputtedCode,
      onCodeSuccess: (code) {
        
       
        print(code);
      },
      onCodeFail: (code) {
        inputtedCode = code;
         Navigator.push(context, MaterialPageRoute(builder: (context)=> 
          ConfirmPinCodeScreen(initailCode: inputtedCode,fromTransaction: false,),
        ));
        print(code);
      },
    );
  }
}
