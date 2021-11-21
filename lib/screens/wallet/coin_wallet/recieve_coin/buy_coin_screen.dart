
import 'package:Crypto_wallet/screens/homepage/home_page_screen.dart';
import 'package:Crypto_wallet/services/auth.dart';
import 'package:Crypto_wallet/services/flutterwave_payment.dart';
import 'package:Crypto_wallet/services/price_formatter.dart';
import 'package:Crypto_wallet/shared/button.dart';
import 'package:Crypto_wallet/shared/buy_checkOut_scrren.dart';
import 'package:Crypto_wallet/shared/send_textField.dart';
import 'package:Crypto_wallet/shared/succesful_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';

class BuyCoinScreen extends StatefulWidget {
  final currency;
  final balance;
  final user;
  final nairaRate;
  BuyCoinScreen({this.currency, this.balance, this.user, this.nairaRate});
  @override
  _BuyCoinScreenState createState() => _BuyCoinScreenState();
}

class _BuyCoinScreenState extends State<BuyCoinScreen> {
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

  final _formKey = GlobalKey<FormState>();
  dynamic nairaPrice;
  var coinAmount;
  var nairaMoney;
  final nairaAmount = TextEditingController();
  final currencyAmount = TextEditingController();
  final address = TextEditingController();
  bool isNaira = false;
  bool isCurrency = false;
  ProgressDialog _progressDialog;
  dynamic date = DateTime.now().millisecondsSinceEpoch;

  @override
  Widget build(BuildContext context) {
    String oid = date.toString();
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
                'Buy ${widget.currency['name']}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              SizedBox(height: 20),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('You Send',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Focus(
                    onFocusChange: (hasFocus) {
                      if (hasFocus && mounted) {
                        setState(() {
                          isNaira = true;
                          isCurrency = false;
                        });
                      }
                    },
                    child: SendtextField(
                      // hintText: '2000',
                      label: 'Amount',
                      controller: nairaAmount,
                      validate: isNaira,
                      validator: (value) {
                        if (value.isEmpty) {
                          Future.value(Duration(seconds: 1)).whenComplete(() {
                            currencyAmount.text = '0.0';
                            return 'Please enter value';
                          });
                          return null;
                          // return 'Please enter value';
                        } else {
                          var price = double.parse(widget.currency['price']);
                          dynamic nairaRate = double.parse(widget.nairaRate);
                          nairaPrice = price * nairaRate;
                          dynamic naira = double.parse(value);
                          Future.value(Duration(seconds: 1)).whenComplete(() {
                            dynamic currency = ((naira) / nairaPrice);
                            currencyAmount.text = currency.toStringAsFixed(8);
                          });
                          return null;
                        }
                      },
                      text: Container(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          'NGN',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      isNumberType: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('You Receive',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Focus(
                    onFocusChange: (hasFocus) {
                      if (hasFocus && mounted) {
                        setState(() {
                          isNaira = false;
                          isCurrency = true;
                        });
                      }
                    },
                    child: SendtextField(
                      // hintText: '0.02344',

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
                            nairaAmount.text = "0.0";
                          });
                          // return null;
                          return 'Please enter value';
                        } else {
                          var price = double.parse(widget.currency['price']);
                          dynamic nairaRate = double.parse(widget.nairaRate);

                          dynamic coin = double.parse(value);
                          dynamic nairaPrice = price * nairaRate;
                          Future.value(Duration(seconds: 1)).whenComplete(() {
                            dynamic cal = ((nairaPrice * coin));
                            dynamic naira = cal;

                            nairaAmount.text = naira.toStringAsFixed(8);
                            // dynamic money = formatPrice(amount);
                            // nairaAmount.text = money;
                          });
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.only(right: 19, top: 10),
                  alignment: Alignment.bottomRight,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Text('${widget.nairaRate} ₦/\$'),
                ),
              ),

              SizedBox(height: 20),

              SizedBox(height: 20),

              Button(
                text: 'Continue',
                press: () {
                  // var toSend = int.parse(currencyAmount.text);
                  var balance = double.parse(widget.balance);
                  var amount = double.parse(currencyAmount.text);
                  var naira = double.parse(nairaAmount.text);
                  coinAmount = amount.toStringAsFixed(8);
                  nairaMoney = naira.toStringAsFixed(2);
                  if (_formKey.currentState.validate()) {
                    _showBottomSheet(
                      BuyCheckOutScreen(
                        address: 'Veloce',
                        coinAmount: coinAmount.toString(),
                        currency: widget.currency,
                        user: widget.user,
                        otherCurrencyAmount: nairaMoney.toString(),
                        text:
                            'You are about to buy  $coinAmount${widget.currency['currency']}  for  \₦${formatPrice(nairaMoney)}',
                        symbol: '\₦',
                        text1:
                            'Exchange rate: 1 ${widget.currency['currency']} \=  \₦${formatPrice(nairaPrice.toString())} ',
                        press: () async {
                          Map response = await PaymentService()
                              .handlePaymentInitialization(
                                  context, nairaMoney.toString(), widget.user);
                          if (response['status']) {
                            _progressDialog.show();
                            dynamic calculatedCoin = balance + coinAmount;
                            dynamic result = await AuthService().updateWallet(
                                calculatedCoin.toString(),
                                widget.currency['currency']);

                            if (result['status']) {
                              dynamic result1 = await AuthService().updateOrder(
                                '${widget.currency['currency']}',
                                coinAmount.toString(),
                                nairaMoney.toString(),
                                widget.user['userName'].toString(),
                                widget.user['email'].toString(),
                                'buyOrder',
                                widget.user['mobile'].toString(),
                                true,
                                '',
                                '',
                                '',
                                false
                              );

                              if (result1['status']) {
                                dynamic result2 =
                                    await AuthService().updateTransactionList(
                                  'Bought',
                                  'Veloce',
                                  '${widget.currency['currency']} Wallet',
                                  coinAmount.toString(),
                                  nairaMoney.toString(),
                                  '${widget.currency['currency']}WalletTransactionList',
                                  '${widget.currency['currency']}',
                                  true,
                                  oid,
                                  '${widget.currency['currency']}WalletTransactionList',
                                );

                                if (result2['status']) {
                                  _progressDialog.hide();
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SuccessfulPage(
                                          text: 'Coin is  successfully bought',
                                          text1:
                                              'You\'ve successfully sent ${currencyAmount.text} ${widget.currency['currency']} for  \₦${formatPrice(nairaMoney)}',
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
                                }
                              } else {
                                _progressDialog.hide();
                                String msg = (result1['message'] != null &&
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
                            } else {
                              _progressDialog.hide();
                              String msg = (result['message'] != null &&
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
                          } else {
                            _progressDialog.hide();
                            Fluttertoast.showToast(
                                msg: response['message'],
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.black,
                                textColor: Colors.white);
                          }
                        },
                      ),
                    );
                    // }
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
