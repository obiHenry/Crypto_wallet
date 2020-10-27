import 'package:Crypto_wallet/services/dialog_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart'; 

import '../button.dart';
import '../text_botton.dart';

class RecieveCoinScreen extends StatefulWidget {
  final currency;
  final value;
  RecieveCoinScreen({this.currency, this.value});
  @override
  _RecieveCoinScreenState createState() => _RecieveCoinScreenState();
}

class _RecieveCoinScreenState extends State<RecieveCoinScreen> {
  @override
  Widget build(BuildContext context) {
    String address = widget.value['message']['response']['result']['address'];
    return SingleChildScrollView(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 20),
          Text(
            '${widget.currency['name']} Address ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          InkWell(
            // onTap: loadAsset,
            splashColor: Colors.purple,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purple),
              ),
              child: Image.network(
                  widget.value['message']['response']['result']['qrcode_url']),
            ),
          ),
          // RoundedInputField(
          //   initialValue: widget.currency['price'],
          //   hintText: "adddress",
          // ),
          SizedBox(height: 20),

          ButtonText(
            text: address,
          ),
          SizedBox(height: 20),

          Button(
            text: 'Copy to cliboard',
            icon: Icons.copy,
            press: () {
              Clipboard.setData(ClipboardData(text: address));
              Fluttertoast.showToast(
                  msg: 'Copied',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  // timeInSecForIosWeb: 1,
                  
                  // timeInSecForIos: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white);
              // DialogService().getSnackBar(context, 'Copied', Colors.lightGreen);
            },
          ),
          // RoundedButton(
          //   text: "copy to clipboard",
          //   press: () {
          //     setState(() {
          //       print('object');
          //     });
          //   },
          // ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
