
import 'package:Crypto_wallet/widgets/button.dart';
import 'package:Crypto_wallet/widgets/check_out_screen.dart';
import 'package:Crypto_wallet/widgets/outlined_number_input_field.dart';
import 'package:Crypto_wallet/widgets/send_textField.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class SendCoinScreen extends StatefulWidget {
  final currency;
  final balance;
  final user;
  SendCoinScreen({this.currency, this.balance, this.user});
  @override
  _SendCoinScreenState createState() => _SendCoinScreenState();
}

final _formKey = GlobalKey<FormState>();

var coinAmount;
var dollarAmount;
final usdAmount = TextEditingController();
final currencyAmount = TextEditingController();
final address = TextEditingController();
bool isUsd = false;
bool isCurrency = false;

class _SendCoinScreenState extends State<SendCoinScreen> {
  void _showBottomSheet(Widget widget) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        )),
        isScrollControlled: true,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: widget,
            // behavior: HitTestBehavior.opaque,
          );
        });
  }

  Future _scan() async {
    try {
      String barcode = await scanner.scan();
      setState(() {
        address.text = barcode;
      });
    } catch (e) {
      if (e.code == scanner.CameraAccessDenied) {
        setState(() {
          address.text = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => address.text = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => address.text =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => address.text = 'Unknown error: $e');
    }
  }

  @override
  void dispose() {
    currencyAmount.clear();
    usdAmount.clear();
    address.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    icon: Icon(Icons.close_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              SizedBox(height: 20),
              Text(
                'Send ${widget.currency['name']}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Focus(
                    onFocusChange: (hasFocus) {
                      if (hasFocus && mounted) {
                        setState(() {
                          isUsd = true;
                          isCurrency = false;
                        });
                      }
                    },
                    child: SendtextField(
                      label: 'Amount',
                      controller: usdAmount,
                      validate: isUsd,
                      validator: (value) {
                        if (value.isEmpty) {
                          Future.value(Duration(seconds: 1)).whenComplete(() {
                            currencyAmount.text = '0.0';
                            return 'Please enter value';
                          });
                          // return null;
                          // return 'Please enter value';
                        } else {
                          var price = double.parse(widget.currency['price']);
                          dollarAmount = double.parse(value);
                          Future.value(Duration(seconds: 1)).whenComplete(() {
                            dynamic currency = ((dollarAmount * 1) / price);
                            currencyAmount.text = currency.toStringAsFixed(8);
                          });
                          return null;
                        }
                      },
                      text: Container(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          'USD',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      isNumberType: true,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              Focus(
                onFocusChange: (hasFocus) {
                  if (hasFocus && mounted) {
                    setState(() {
                      isUsd = false;
                      isCurrency = true;
                    });
                  }
                },
                child: SendtextField(
                  label: 'Equivalence',
                  controller: currencyAmount,
                  isNumberType: true,
                  validate: isCurrency,
                  text: Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      widget.currency['currency'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty ) {
                      Future.value(Duration(seconds: 1)).whenComplete(() {
                        usdAmount.text = "0.0";
                      });
                      // return null;
                      return 'Please enter value';
                    } else {
                      var price = double.parse(widget.currency['price']);

                      coinAmount = double.parse(value);
                      Future.value(Duration(seconds: 1)).whenComplete(() {
                        dynamic usd = ((price * coinAmount) / 1);
                        usdAmount.text = usd.toStringAsFixed(8);
                      });
                      return null;
                    }
                  },
                ),
              ),

              SizedBox(height: 20),
              OutlinedNumberInputField(
                label: 'To address',
                controller: address,
                isNumberType: false,
              ),
              SizedBox(height: 20),

              SizedBox(height: 20),

              Button(
                  text: 'Scan qr code',
                  press: () {
                    print('hxfbj');
                    _scan();
                  }),

              Button(
                text: 'Continue',
                press: () {
                  // var toSend = int.parse(currencyAmount.text);
                  var balance = double.parse(widget.balance);
                  var amount = double.parse(currencyAmount.text);
                  dynamic charge = (amount) / 100;
                  dynamic totalAmount = charge + (amount);
                  if (_formKey.currentState.validate()) {
                    if (balance < totalAmount) {
                      Fluttertoast.showToast(
                          msg: 'Insufficient fund ',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.black,
                          textColor: Colors.white);
                    } else {
                      _showBottomSheet(CheckOutScreen(
                          address: address.text,
                          amount: currencyAmount.text,
                          currency: widget.currency,
                          user: widget.user));
                    }
                  } else {
                    Fluttertoast.showToast(
                        msg: 'some fields are empty ',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.black,
                        textColor: Colors.white);
                  }
                },
              ),
              // SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
