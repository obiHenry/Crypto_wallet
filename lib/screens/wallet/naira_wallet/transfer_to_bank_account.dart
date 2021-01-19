import 'package:Crypto_wallet/screens/tab_Screen/tab_screen.dart';
import 'package:Crypto_wallet/services/auth.dart';
import 'package:Crypto_wallet/services/price_formatter.dart';
import 'package:Crypto_wallet/shared/button.dart';
import 'package:Crypto_wallet/shared/outlined_number_input_field.dart';
import 'package:Crypto_wallet/shared/alert_sheet.dart';
import 'package:Crypto_wallet/shared/transfer_checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Crypto_wallet/shared/succesful_page.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:Crypto_wallet/screens/logins_and_signUp/account_registration/account_pin_code_setup/confirm_pin_code_screen.dart';
import 'package:Crypto_wallet/screens/settings/users_settings_screen.dart';

class TransferToBankAccount extends StatefulWidget {
  final currency;
  final nairaBalance;
  final user;
  final nairaRate;
  TransferToBankAccount(
      {this.currency, this.nairaBalance, this.user, this.nairaRate});
  @override
  _TransferToBankAccountState createState() => _TransferToBankAccountState();
}

class _TransferToBankAccountState extends State<TransferToBankAccount> {
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
                'Transfer to your bank account from naira wallet',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              SizedBox(height: 20),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Amount to withdraw',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  OutlinedNumberInputField(
                    // hintText: '2000',
                    label: 'Amount',
                    controller: nairaAmount,

                    text: Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        'NGN',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    isNumberType: true,
                  ),
                ],
              ),

              SizedBox(height: 20),

              SizedBox(height: 20),

              Button(
                text: 'Continue',
                press: () {
                  // var toSend = int.parse(currencyAmount.text);
                  var balance = double.parse(widget.nairaBalance);
                  // var amount = double.parse(currencyAmount.text);
                  var naira = double.parse(nairaAmount.text);
                  double chargeInNaira = (naira * 2.5) / 100;
                  double totalInNaira = chargeInNaira + naira;
                  dynamic totalAmountInNaira = totalInNaira.toStringAsFixed(2);
                  // coinAmount = amount.toStringAsFixed(8);
                  nairaMoney = naira.toStringAsFixed(2);
                  if (_formKey.currentState.validate()) {
                    _showBottomSheet(
                      TransferCheckoutscreen(
                          address: 'Naira Wallet',
                          coinAmount: coinAmount.toString(),
                          currency: widget.currency,
                          user: widget.user,
                          otherCurrencyAmount: nairaMoney.toString(),
                          chargeInOtherCurrency: chargeInNaira.toString(),
                          otherCurrencyTotalAmountToSend:
                              totalAmountInNaira.toString(),
                          text:
                              'You are about to transfer  \₦${formatPrice(nairaMoney)} ',
                          symbol: '\₦',
                          text1:
                              'from  your naira wallet to your bank account ',
                          press: () async {
                            if (balance < totalInNaira) {
                              Fluttertoast.showToast(
                                  msg:
                                      'Insufficient fund, Note that our charges are included ',
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
                                      builder: (context) =>
                                          ConfirmPinCodeScreen(
                                        initailCode: transactionpin,
                                        fromTransaction: true,
                                        doSuccessMethod: () async {
                                          print('is a success');

                                          _progressDialog.show();
                                          dynamic result =
                                              await AuthService().updateOrder(
                                            'naira',
                                            '',
                                            nairaMoney.toString(),
                                            widget.user['userName'].toString(),
                                            widget.user['email'].toString(),
                                            'withdrawOrder',
                                            widget.user['mobile'].toString(),
                                            false,
                                            widget.user['bankAccountName'],
                                            widget.user['bankName'],
                                            widget.user['bankAccountNumber']
                                                .toString(),
                                          );

                                          if (result['status']) {
                                            dynamic remainedNairaBalance =
                                                balance - totalInNaira;

                                            dynamic result1 =
                                                await AuthService()
                                                    .updateWallet(
                                                        remainedNairaBalance
                                                            .toString(),
                                                        'naira');
                                            if (result1['status']) {
                                              dynamic result2 = await AuthService()
                                                  .updateTransactionList(
                                                      'withdrawal',
                                                      'Naira Wallet',
                                                      'Bank Account',
                                                      '',
                                                      nairaMoney.toString(),
                                                      'nairaWalletTransactionList',
                                                      '',
                                                      false);

                                              if (result2['status']) {
                                                _progressDialog.hide();
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SuccessfulPage(
                                                        text:
                                                            'Order recieved , you will receive your money in the next 24 hours',
                                                        text1:
                                                            'You\'ve successfully placed order to withdraw sum of \₦${formatPrice(nairaMoney)}',
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
                                                Fluttertoast.showToast(
                                                    msg: result2['message'],
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    backgroundColor:
                                                        Colors.black,
                                                    textColor: Colors.white);
                                              }
                                            } else {
                                              _progressDialog.hide();
                                              Fluttertoast.showToast(
                                                  msg: result1['message'],
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
                                        },
                                        title: 'verify Transaction pin',
                                        subtitle: 'Enter your transaction pin ',
                                      ),
                                    ));
                              } else {
                                _showBottomSheet(AlertSheet(
                                  text1:
                                      'We noticed you don\'t have a transaction pin yet',
                                  text2:
                                      'you can create one in your settings to be able to transact ',
                                  text3: 'Create one now',
                                  press: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UsersSettingsScreen()));
                                  },
                                ));
                              }

                              // _progressDialog.show();
                              // dynamic result = await AuthService().updateOrder(
                              //   'naira',
                              //   '',
                              //   nairaMoney.toString(),
                              //   widget.user['userName'].toString(),
                              //   widget.user['email'].toString(),
                              //   'withdrawOrder',
                              //   widget.user['mobile'].toString(),
                              //   false,
                              //   widget.user['bankAccountName'],
                              //   widget.user['bankName'],
                              //   widget.user['bankAccountNumber'].toString(),
                              // );

                              // if (result['status']) {
                              //   dynamic remainedNairaBalance =
                              //       balance - totalInNaira;

                              //   dynamic result1 = await AuthService()
                              //       .updateWallet(
                              //           remainedNairaBalance.toString(),
                              //           'naira');
                              //   if (result1['status']) {
                              //     dynamic result2 = await AuthService()
                              //         .updateTransactionList(
                              //             'withdraw',
                              //             'Naira Wallet',
                              //             'Bank Account',
                              //             '',
                              //             nairaMoney.toString(),
                              //             'nairaWalletTransactionList',
                              //             '',
                              //             false);

                              //     if (result2['status']) {
                              //       _progressDialog.hide();
                              //       Navigator.pushAndRemoveUntil(
                              //           context,
                              //           MaterialPageRoute(
                              //             builder: (context) => SuccessfulPage(
                              //               text:
                              //                   'money is  successfully transferred, you will receive your money in the next 24 hours',
                              //               text1:
                              //                   'You\'ve successfully deposited  \₦${formatPrice(nairaMoney)}',
                              //               press: () {
                              //                 Navigator.pushAndRemoveUntil(
                              //                     context,
                              //                     MaterialPageRoute(
                              //                         builder: (context) =>
                              //                             TabScreen()),
                              //                     (route) => false);
                              //               },
                              //             ),
                              //           ),
                              //           (route) => false);
                              //     } else {
                              //       _progressDialog.hide();
                              //       Fluttertoast.showToast(
                              //           msg: result2['message'],
                              //           toastLength: Toast.LENGTH_SHORT,
                              //           gravity: ToastGravity.BOTTOM,
                              //           backgroundColor: Colors.black,
                              //           textColor: Colors.white);
                              //     }
                              //   } else {
                              //     _progressDialog.hide();
                              //     Fluttertoast.showToast(
                              //         msg: result1['message'],
                              //         toastLength: Toast.LENGTH_SHORT,
                              //         gravity: ToastGravity.BOTTOM,
                              //         backgroundColor: Colors.black,
                              //         textColor: Colors.white);
                              //   }
                              // } else {
                              //   _progressDialog.hide();
                              //   String msg = (result['message'] != null &&
                              //           result['message'].isNotEmpty)
                              //       ? result['message']
                              //       : 'An unknown error occured; retry';
                              //   Fluttertoast.showToast(
                              //       msg: msg,
                              //       toastLength: Toast.LENGTH_SHORT,
                              //       gravity: ToastGravity.BOTTOM,
                              //       backgroundColor: Colors.black,
                              //       textColor: Colors.white);
                              // }
                            }
                          }),
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
