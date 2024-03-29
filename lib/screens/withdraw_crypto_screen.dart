import 'package:Crypto_wallet/services/price_formatter.dart';
import 'package:Crypto_wallet/services/api_services.dart';
import 'package:Crypto_wallet/shared/button.dart';
import 'package:Crypto_wallet/shared/check_out_screen.dart';
import 'package:Crypto_wallet/shared/outlined_number_input_field.dart';
import 'package:Crypto_wallet/shared/send_textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Crypto_wallet/screens/confirm_pin_code_screen.dart';
import 'package:Crypto_wallet/shared/alert_sheet.dart';

import 'package:Crypto_wallet/shared/succesful_page.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import 'home_page_screen.dart';

class SendCoinScreen extends StatefulWidget {
  final currency;
  final balance;
  final user;
  SendCoinScreen({this.currency, this.balance, this.user});
  @override
  _SendCoinScreenState createState() => _SendCoinScreenState();
}

final _formKey = GlobalKey<FormState>();

dynamic coinAmount;
dynamic dollarAmount;
final usdAmount = TextEditingController();
final currencyAmount = TextEditingController();
final address = TextEditingController();
bool isUsd = false;
bool isCurrency = false;
dynamic transactionpin;
ProgressDialog _progressDialog;

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
      // ignore: dead_code_catch_following_catch
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
    _progressDialog = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      textDirection: TextDirection.rtl,
      isDismissible: true,
    );

    _progressDialog.style(
      message: 'wait while we process your transaction',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      progressWidgetAlignment: Alignment.center,
      maxProgress: 100,
      progressTextStyle: TextStyle(
          color: Colors.purple, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.purple, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
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
                          return 'Please enter value';
                        } else {
                          var price = double.parse(widget.currency['price']);
                          dynamic usd = double.parse(value);
                          Future.value(Duration(seconds: 1)).whenComplete(() {
                            dynamic currency = ((usd * 1) / price);
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
                    if (value.isEmpty) {
                      Future.value(Duration(seconds: 1)).whenComplete(() {
                        usdAmount.text = "0.0";
                      });
                      // return null;
                      return 'Please enter value';
                    } else {
                      var price = double.parse(widget.currency['price']);

                      dynamic coin = double.parse(value);
                      Future.value(Duration(seconds: 1)).whenComplete(() {
                        dynamic usd = ((price * coin) / 1);
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
                  var dollar = double.parse(usdAmount.text);
                  coinAmount = amount.toStringAsFixed(7);
                  dollarAmount = dollar.toStringAsFixed(2);
                  double chargeInCoin = ((amount) / 100);
                  double chargeInUsd = dollar / 100;
                  dynamic coinCharge = chargeInCoin.toStringAsFixed(7);
                  dynamic usdCharge = chargeInUsd.toStringAsFixed(2);
                  double totalInUsd = chargeInUsd + dollar;
                  double totalInCoin = chargeInCoin + (amount);
                  dynamic totalAmountInUsd = totalInUsd.toStringAsFixed(2);
                  dynamic totalAmountInCoin = totalInCoin.toStringAsFixed(7);

                  if (_formKey.currentState.validate()) {
                    if (balance < totalInCoin) {
                      Fluttertoast.showToast(
                          msg: 'Insufficient fund ',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.black,
                          textColor: Colors.white);
                    } else {
                      _showBottomSheet(CheckOutScreen(
                        address: address.text,
                        coinAmount: coinAmount.toString(),
                        currency: widget.currency,
                        user: widget.user,
                        otherCurrencyAmount: dollarAmount.toString(),
                        chargeInCoin: coinCharge.toString(),
                        chargeInOtherCurrency: usdCharge.toString(),
                        coinTotalAmountToSend: totalAmountInCoin.toString(),
                        otherCurrencyTotalAmountToSend:
                            totalAmountInUsd.toString(),
                        text:
                            'you are about to send $coinAmount${widget.currency['currency']} for \$${formatPrice(dollarAmount)}',
                        symbol: '\$',
                        text1:
                            'Exchange rate: 1 ${widget.currency['currency']} \=  \$${formatPrice(widget.currency['price'])} ',
                        press: () async {
                          if (widget.user.containsKey('transactionPin')) {
                            transactionpin = widget.user['transactionPin'];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConfirmPinCodeScreen(
                                    initailCode: transactionpin.toString(),
                                    fromTransaction: true,
                                    title: 'verify Transaction pin',
                                    subtitle: 'Enter your transaction pin ',
                                    doSuccessMethod: () async {
                                      _progressDialog.show();
                                      print('is a success');
                                      print('come');
                                      dynamic userId =
                                          FirebaseAuth.instance.currentUser.uid;
                                      dynamic apiKey =
                                          '8293ui423kjsadhas9oujwasd';
                                      Map result = await ApiServices().sendCoin(
                                        apiKey,
                                        widget.currency['currency'],
                                        userId,
                                        currencyAmount.text,
                                        address.text,
                                        chargeInCoin.toString(),
                                      );
                                      // print(result.toString());

                                      if (result['status']) {
                                        _progressDialog.hide();
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SuccessfulPage(
                                                text:
                                                    'Order recieved , you transaction will be completed in the next 1 hours',
                                                text1:
                                                    'You\'ve successfully placed order to send $coinAmount${widget.currency['currency']} for \$${formatPrice(dollarAmount)}',
                                                press: () {
                                                  Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomePageScreen()),
                                                      (route) => false);
                                                },
                                              ),
                                            ),
                                            (route) => false);

                                        print('success');
                                      } else {
                                        String msg = (result['message'] !=
                                                    null &&
                                                result['message'].isNotEmpty)
                                            ? result['message']
                                            : 'An unknown error occured; retry';
                                        Fluttertoast.showToast(
                                            msg: msg,
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            backgroundColor: Colors.black,
                                            textColor: Colors.white);
                                      }
                                    }),
                              ),
                            );
                          } else {
                            _showBottomSheet(AlertSheet(
                              text1:
                                  'We noticed you don\'t have a transaction pin yet',
                              text2:
                                  'you can create one in your settings to be able to transact ',
                              text3: 'Create one now',
                              press: () {
                                Navigator.pushNamed(context, 'user_profile');
                              },
                            ));
                          }
                        },
                      ));
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
