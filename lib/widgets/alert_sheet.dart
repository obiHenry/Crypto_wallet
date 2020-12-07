import 'package:flutter/material.dart';

class AlertSheet extends StatefulWidget {
  final String text1, text2, text3;
  final Function press;
  AlertSheet({this.text1, this.text2, this.text3,this.press});
  @override
  _AlertSheetState createState() => _AlertSheetState();
}

// final _formKey = GlobalKey<FormState>();
// String amount, address, userId;

class _AlertSheetState extends State<AlertSheet> {
  @override
  Widget build(BuildContext context) {
    // String address = widget.value['message']['response']['result']['address'];
    return SingleChildScrollView(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // SizedBox(height: 20),
            Text(
              widget.text1,
              // 'No coin was found in your wallet, ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              widget.text2,
              // ' you can buy from us',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            // SizedBox(height: 20),
            Divider(
              color: Colors.grey,
            ),
            // SizedBox(height: 20),
            FlatButton(
                onPressed: widget.press,
                child: Text(
                  widget.text3,
                  // 'Buy now',
                  style: TextStyle(color: Colors.purple, fontSize: 25),
                )),
            // SizedBox(height: 20),
            // Divider(),

            // SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
