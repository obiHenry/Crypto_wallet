import 'package:Crypto_wallet/services/price_formatter.dart';
import 'package:Crypto_wallet/widgets/button.dart';
import 'package:Crypto_wallet/widgets/check_out_screen.dart';
import 'package:Crypto_wallet/widgets/send_textField.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SellCoinScreen extends StatefulWidget {
  final currency;
  final balance;
  final user;
  final nairaRate;
  SellCoinScreen({this.currency, this.balance, this.user, this.nairaRate});
  @override
  _SellCoinScreenState createState() => _SellCoinScreenState();
}

class _SellCoinScreenState extends State<SellCoinScreen> {
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
                'Sell ${widget.currency['name']}',
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
                          // return null;
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
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.only(right: 19, top: 10),
                  alignment: Alignment.bottomRight,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Text('${widget.nairaRate} #/\$'),
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
                  coinAmount = amount.toStringAsFixed(5);
                  nairaMoney = naira.toStringAsFixed(2);
                  double chargeInCoin = ((amount) / 100);
                  double chargeInNaira = naira / 100;
                  dynamic coinCharge = chargeInCoin.toStringAsFixed(5);
                  dynamic usdCharge = chargeInNaira.toStringAsFixed(2);
                  double totalInNaira = chargeInNaira + naira;
                  double totalInCoin = chargeInCoin + (amount);
                  dynamic totalAmountInNaira = totalInNaira.toStringAsFixed(2);
                  dynamic totalAmountInCoin = totalInCoin.toStringAsFixed(5);

                  if (_formKey.currentState.validate()) {
                    if (balance < totalInCoin) {
                      Fluttertoast.showToast(
                          msg: 'Insufficient fund ',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.black,
                          textColor: Colors.white);
                    } else {
                      _showBottomSheet(
                        CheckOutScreen(
                          address: 'veloce',
                          coinAmount: coinAmount.toString(),
                          currency: widget.currency,
                          user: widget.user,
                          otherCurrencyAmount: nairaMoney.toString(),
                          chargeInCoin: coinCharge.toString(),
                          chargeInOtherCurrency: usdCharge.toString(),
                          coinTotalAmountToSend: totalAmountInCoin.toString(),
                          otherCurrencyTotalAmountToSend:
                              totalAmountInNaira.toString(),
                          text:
                              'You are about to sell  $coinAmount${widget.currency['currency']}  for  \#${formatPrice(nairaMoney)}',
                          symbol: '\#',
                          text1:
                              'Exchange rate: 1 ${widget.currency['currency']} \=  \#${formatPrice(nairaPrice)} ',
                        ),
                      );
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
