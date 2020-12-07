import 'package:Crypto_wallet/screens/tab_Screen/tab_screen.dart';
import 'package:Crypto_wallet/services/auth.dart';
import 'package:Crypto_wallet/services/price_formatter.dart';
import 'package:Crypto_wallet/shared/app_colors.dart';
import 'package:Crypto_wallet/theme/light_color.dart';
import 'package:Crypto_wallet/widgets/alert_sheet.dart';
import 'package:Crypto_wallet/widgets/button.dart';
import 'package:Crypto_wallet/widgets/send_textField.dart';
import 'package:Crypto_wallet/widgets/succesful_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'naira_deposit_check_out.dart';

class NairaTransferWallet extends StatefulWidget {
  final coinBalance;
  final user;
  final currency;
  final nairaBalance;
  final nairaRate;

  NairaTransferWallet(
      {this.coinBalance,
      this.user,
      this.currency,
      this.nairaBalance,
      this.nairaRate});

  _NairaTransferWalletState createState() => _NairaTransferWalletState();
}

class _NairaTransferWalletState extends State<NairaTransferWallet> {
  bool _loader = false;
  bool _loader1 = false;
  final _formKey = GlobalKey<FormState>();

  var coinAmount;
  var naira;
  final nairaAmount = TextEditingController();
  final currencyAmount = TextEditingController();
  final address = TextEditingController();
  bool isnaira = false;
  bool isCurrency = false;

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

  ProgressDialog _progressDialog;

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
    dynamic nairaRate = double.parse(widget.nairaRate);
    dynamic nairaBalance = double.parse(widget.nairaBalance);
    dynamic usdEqui = (1 * nairaBalance) / nairaRate;

    return Scaffold(
      backgroundColor: lightBlueStart,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: yellowEndWallet,
                gradient: LinearGradient(
                  // yellowStartWallet, yellowEndWallet
                  colors: [
                    Colors.green,
                    Colors.lightGreen,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment(0.6, 0.3),
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(height: 55),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset('assets/images/back.svg'),
                            ),
                            Text(
                              "Naira Wallet",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            SvgPicture.asset('assets/images/back.svg',
                                color: Colors.transparent),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Avaliable Balance :',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 20),

                      // container(widget.balance, widget.currency),
                      // SizedBox(height: 10),
                      Text(
                        " NGN${nairaBalance.toStringAsFixed(1)}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      ),
                      // SizedBox(height: 30),
                      Text(
                        "\~ \$${usdEqui.toStringAsFixed(2)}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 15),

                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          "NGN ${widget.nairaRate}  ~ \$1",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(height: 30),

                      SizedBox(height: 40),
                    ],
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * .12,
                    left: -5,
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(45 / 360),
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * .16,
                    left: MediaQuery.of(context).size.width * 0.05,
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(45 / 360),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * .05,
                    right: 30,
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(45 / 360),
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * .09,
                    right: -15,
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(45 / 360),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Text(
                      'Transfer Naira',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('From:'),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: 50,
                              padding: EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: LightColor.lightGrey,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Text(
                                'Naira Wallet',
                                style: TextStyle(
                                  // color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('To:'),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              padding: EdgeInsets.only(left: 10),
                              height: 50,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: LightColor.lightGrey,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Text(
                                ' ${widget.currency['currency']} Wallet',
                                style: TextStyle(
                                  // color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
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
                                isnaira = true;
                                isCurrency = false;
                              });
                            }
                          },
                          child: SendtextField(
                            label: 'Amount',
                            controller: nairaAmount,
                            validate: isnaira,
                            validator: (value) {
                              if (value.isEmpty) {
                                Future.value(Duration(seconds: 1))
                                    .whenComplete(() {
                                  currencyAmount.text = '0.0';
                                  return 'Please enter value';
                                });
                                // return null;
                                // return 'Please enter value';
                              } else {
                                var price =
                                    double.parse(widget.currency['price']);
                                naira = double.parse(value);
                                Future.value(Duration(seconds: 1))
                                    .whenComplete(() {
                                  dynamic currency = ((naira * 1) / price);
                                  currencyAmount.text =
                                      currency.toStringAsFixed(7);
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
                    Focus(
                      onFocusChange: (hasFocus) {
                        if (hasFocus && mounted) {
                          setState(() {
                            isnaira = false;
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
                          if (value.isEmpty || currencyAmount == 0.0) {
                            Future.value(Duration(seconds: 1)).whenComplete(() {
                              nairaAmount.text = "0.0";
                            });
                            // return null;
                            return 'Please enter value';
                          } else {
                            var price = double.parse(widget.currency['price']);

                            coinAmount = double.parse(value);
                            Future.value(Duration(seconds: 1)).whenComplete(() {
                              dynamic naira = ((price * coinAmount) / 1);
                              nairaAmount.text = naira.toStringAsFixed(7);
                            });
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 20),

                    SizedBox(height: 20),

                    Button(
                      text: 'Continue',
                      press: () {
                        // var toSend = int.parse(currencyAmount.text);
                        var nairabalance = double.parse(widget.nairaBalance);
                        var coin = double.parse(currencyAmount.text);
                        var naira = double.parse(nairaAmount.text);
                        dynamic nairaMoney = naira.toStringAsFixed(2);
                        dynamic chargeInCoin = (coin * 1) / 100;
                        dynamic chargeInNaira = (naira * 1) / 100;
                        dynamic totalNairaAmountToSend = naira + chargeInNaira;
                        if (_formKey.currentState.validate()) {
                          if (nairabalance < totalNairaAmountToSend) {
                            Fluttertoast.showToast(
                                msg: 'Insufficient fund,  ',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.black,
                                textColor: Colors.white);
                            // _showBottomSheet(AlertSheet(text1: '',
                            // text2: '',
                            // text3: '',));

                            _showBottomSheet(AlertSheet(
                              text1:
                                  'you dont\t have up to the amount u want to transfer,',
                              text2:
                                  'try depositing to your naira wallet to be able to transfer ',
                              text3: 'Deposit now',
                            ));
                          } else {
                            _showBottomSheet(
                              NairaDepositeCheckoutScreen(
                                address:
                                    ' ${widget.currency['currency']} Wallet',
                                coinAmount: currencyAmount.text,
                                currency: widget.currency,
                                user: 'Naira wallet',
                                currentWalletBalance: nairabalance.toString(),
                                nairaAmount: nairaAmount.text,
                                chargeInCoin: chargeInCoin.toString(),
                                chargeInNaira: chargeInNaira.toString(),
                                text:
                                    'You are about to Transfer  ${currencyAmount.text}${widget.currency['currency']}  for  \₦${formatPrice(nairaMoney)}',
                                text1:
                                    'Exchange rate: 1 ${widget.currency['currency']} \=  \₦${formatPrice(widget.currency['price'])}',
                                press: () async {
                                  _progressDialog.show();

                                  print('come');
                                  dynamic nairaBalanceInWallet =
                                      double.parse(nairabalance.toString());
                                  dynamic sentNaira =
                                      double.parse(nairaAmount.text);
                                  dynamic remainedNairaBalance =
                                      nairaBalanceInWallet -
                                          (sentNaira + chargeInNaira);
                                  String remainedNairaWalletBalance =
                                      remainedNairaBalance.toStringAsFixed(2);
                                  print(remainedNairaWalletBalance);

                                  dynamic coinBalanceInWallet =
                                      double.parse(widget.coinBalance);

                                  dynamic coinToSend =
                                      double.parse(currencyAmount.text);

                                  print(coinToSend);

                                  dynamic totalCoinCalculated =
                                      coinBalanceInWallet + coinToSend;
                                  print(totalCoinCalculated);

                                  dynamic result = await AuthService()
                                      .updateWalletData(
                                          totalCoinCalculated.toString(),
                                          remainedNairaWalletBalance.toString(),
                                          widget.currency['currency']);

                                  if (result['status']) {
                                    dynamic result1 = await AuthService()
                                        .updateTransactionList(
                                            'Sent',
                                            'Naira wallet',
                                            '${widget.currency['currency']} Wallet',
                                            coinToSend.toString(),
                                            sentNaira.toString(),
                                            'nairaWalletTransactionList',
                                            '${widget.currency['currency']}',
                                            true);

                                    if (result1['status']) {
                                      dynamic result2 = await AuthService()
                                          .updateTransactionList(
                                              'Recieved',
                                              'Naira wallet',
                                              '${widget.currency['currency']} Wallet',
                                              coinToSend.toString(),
                                              sentNaira.toString(),
                                              '${widget.currency['currency']}WalletTransactionList',
                                              '${widget.currency['currency']}',
                                              true);
                                      if (result2['status']) {
                                        _progressDialog.hide();
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SuccessfulPage(
                                                text: 'Your Transfer was successful',
                                                text1:
                                                    'You\'ve successfully transferred ${currencyAmount.text} ${widget.currency['currency']} for  \₦${formatPrice(nairaMoney)}',
                                                press: () {
                                                  Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
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
                                },
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
          ],
        ),
      ),
    );
  }
}
