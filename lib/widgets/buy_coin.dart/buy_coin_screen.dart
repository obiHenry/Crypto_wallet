import 'package:flutter/material.dart';
import '../button.dart';
import '../outlined_number_input_field.dart';

class BuyCoinScreen extends StatefulWidget {
  final currency;
  // final value;
  BuyCoinScreen({
    this.currency,
  });
  @override
  _BuyCoinScreenState createState() => _BuyCoinScreenState();
}

final _formKey = GlobalKey<FormState>();
String amount, address, userId;

class _BuyCoinScreenState extends State<BuyCoinScreen> {
  @override
  Widget build(BuildContext context) {
    // String address = widget.value['message']['response']['result']['address'];
    return SingleChildScrollView(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20),
      child: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // SizedBox(height: 20),
              Text(
                'Send ${widget.currency['name']}  ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedNumberInputField(
                    // icon: IconButton(
                    //     icon: Icon(Icons.arrow_drop_down_circle_outlined),
                    //     onPressed: () {}),
                    // iconPress: () {},
                    label: 'Amount',
                    press: (value) {
                      amount = value;
                    },
                    isNumberType: true,
                  ),
                ],
              ),

              SizedBox(height: 20),
              OutlinedNumberInputField(
                label: 'To address',
                press: (value) {
                  address = value;
                },
                isNumberType: false,
              ),
              SizedBox(height: 20),
              OutlinedNumberInputField(
                label: 'user Id',
                press: (value) {
                  userId = value;
                },
                isNumberType: false,
              ),
              SizedBox(height: 20),
              // OutlinedNumberInputField(
              //   label: 'User name',
              //   press: (value) {
              //     userName = value;
              //   },
              //   isNumberType: false,
              // ),
              // SizedBox(height: 20),

              Button(
                text: 'Scan qr code',
                // icon: Icons.copy,
                press: () {},
              ),
              // SizedBox(height: 20),

              Button(
                text: 'Send',
                // icon: Icons.copy,
                press: () {},
              ),
              // SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
