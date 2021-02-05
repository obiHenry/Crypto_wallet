import 'package:Crypto_wallet/screens/tab_Screen/tab_screen.dart';
import 'package:Crypto_wallet/services/auth.dart';
import 'package:Crypto_wallet/services/price_formatter.dart';
import 'package:Crypto_wallet/shared/button.dart';
import 'package:Crypto_wallet/shared/check_out_screen.dart';
import 'package:Crypto_wallet/shared/send_textField.dart';
import 'package:Crypto_wallet/shared/succesful_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:Crypto_wallet/shared/alert_sheet.dart';
import 'package:Crypto_wallet/screens/logins_and_signUp/account_registration/account_pin_code_setup/confirm_pin_code_screen.dart';

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
  ProgressDialog _progressDialog;
  dynamic transactionpin;

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
                          return 'Please enter value';
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
                  double chargeInCoin = ((amount * 2.5) / 100);
                  double chargeInNaira = (naira * 2.5) / 100;
                  dynamic coinCharge = chargeInCoin.toStringAsFixed(8);
                  dynamic usdCharge = chargeInNaira.toStringAsFixed(2);
                  double totalInNaira = chargeInNaira + naira;
                  double totalInCoin = chargeInCoin + (amount);
                  dynamic totalAmountInNaira = totalInNaira.toStringAsFixed(2);
                  dynamic totalAmountInCoin = totalInCoin.toStringAsFixed(8);

                  if (_formKey.currentState.validate()) {
                    _showBottomSheet(
                      CheckOutScreen(
                        address: 'Veloce',
                        coinAmount: coinAmount.toString(),
                        currency: widget.currency,
                        user: widget.user,
                        otherCurrencyAmount: nairaMoney.toString(),
                        chargeInCoin: coinCharge.toString(),
                        chargeInOtherCurrency: usdCharge.toString(),
                        coinTotalAmountToSend: totalAmountInCoin.toString(),
                        otherCurrencyTotalAmountToSend:
                            totalAmountInNaira.toString(),
                        bankName: widget.user['bankName'].toString(),
                        accountName: widget.user['bankAccountName'].toString(),
                        accountNumber:
                            widget.user['bankAccountNumber'].toString(),
                        text:
                            'You are about to sell  $coinAmount${widget.currency['currency']}  for  \₦${formatPrice(nairaMoney)}',
                        symbol: '\₦',
                        text1:
                            'Exchange rate: 1 ${widget.currency['currency']} \=  \₦${formatPrice(nairaPrice.toString())} ',
                        onEditClicked: () {
                          Navigator.pushNamed(context, 'user_profile');
                        },
                        press: () async {
                          if (balance < totalInCoin) {
                            Fluttertoast.showToast(
                                msg:
                                    'Insufficient fund, Note that our charges is included',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.black,
                                textColor: Colors.white);
                          } else {
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
                                        dynamic remainedCoinBalance =
                                            balance - totalInCoin;
                                        dynamic result =
                                            await AuthService().updateOrder(
                                          '${widget.currency['currency']}',
                                          coinAmount.toString(),
                                          nairaMoney.toString(),
                                          widget.user['userName'].toString(),
                                          widget.user['email'].toString(),
                                          'sellOrder',
                                          widget.user['mobile'].toString(),
                                          false,
                                          widget.user['bankAccountName'],
                                          widget.user['bankName'],
                                          widget.user['bankAccountNumber']
                                              .toString(),
                                        );
                                        if (result['status']) {
                                          dynamic result1 = await AuthService()
                                              .updateTransactionList(
                                                  'Sold',
                                                  '${widget.currency['currency']} Wallet',
                                                  'Veloce',
                                                  coinAmount.toString(),
                                                  nairaMoney.toString(),
                                                  '${widget.currency['currency']}WalletTransactionList',
                                                  '${widget.currency['currency']}',
                                                  false);
                                          if (result1['status']) {
                                            dynamic result2 =
                                                await AuthService()
                                                    .updateWallet(
                                                        remainedCoinBalance
                                                            .toString(),
                                                        widget.currency[
                                                            'currency']);
                                            if (result2['status']) {
                                              print('success');
                                              _progressDialog.hide();
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SuccessfulPage(
                                                      text:
                                                          'Coin is sent successfully, you will receive your money in the next 24 hours',
                                                      text1:
                                                          'You\'ve successfully sent ${currencyAmount.text} ${widget.currency['currency']} for  \₦${formatPrice(nairaMoney)}',
                                                      press: () {
                                                        Navigator.pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        TabScreen()),
                                                            (route) => false);
                                                      },
                                                    ),
                                                  ),
                                                  (route) => false);
                                            } else {
                                              _progressDialog.hide();
                                              String msg = (result['message'] !=
                                                          null &&
                                                      result['message']
                                                          .isNotEmpty)
                                                  ? result['message']
                                                  : 'An unknown error occured; retry';
                                              Fluttertoast.showToast(
                                                  msg: msg,
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white);
                                            }
                                          } else {
                                            _progressDialog.hide();
                                            String msg = (result['message'] !=
                                                        null &&
                                                    result['message']
                                                        .isNotEmpty)
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
                                      },),
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
                          }
                        },
                      ),
                    );
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
