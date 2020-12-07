import 'package:Crypto_wallet/screens/tab_Screen/tab_screen.dart';
import 'package:Crypto_wallet/services/auth.dart';
import 'package:Crypto_wallet/services/flutterwave_payment.dart';
import 'package:Crypto_wallet/services/price_formatter.dart';
import 'package:Crypto_wallet/widgets/bank_deposit_checkout_screen.dart';
import 'package:Crypto_wallet/widgets/button.dart';
import 'package:Crypto_wallet/widgets/outlined_number_input_field.dart';
import 'package:Crypto_wallet/widgets/succesful_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';

class DepositFromBankAccount extends StatefulWidget {
  final currency;
  final nairaBalance;
  final user;
  final nairaRate;
  DepositFromBankAccount(
      {this.currency, this.nairaBalance, this.user, this.nairaRate});
  @override
  _DepositFromBankAccountState createState() => _DepositFromBankAccountState();
}

class _DepositFromBankAccountState extends State<DepositFromBankAccount> {
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
                'Deposit to naira wallet from your bank account',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              SizedBox(height: 20),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Amount to deposit',
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
                  // coinAmount = amount.toStringAsFixed(8);
                  nairaMoney = naira.toStringAsFixed(2);
                  if (_formKey.currentState.validate()) {
                  
                    _showBottomSheet(
                      BankDepositCheckoutScreen(
                        address: 'Naira Wallet',
                        coinAmount: coinAmount.toString(),
                        currency: widget.currency,
                        user: widget.user,
                        otherCurrencyAmount: nairaMoney.toString(),
                        text:
                            'You are about to deposit    \₦${formatPrice(nairaMoney)} ',
                        symbol: '\₦',
                        text1: 'from  your bank account to your naira wallet ',
                        press: () async {
                          
                          Map response = await PaymentService()
                              .handlePaymentInitialization(
                                  context, nairaMoney.toString(), widget.user);
                          if (response['status']) {
                            _progressDialog.show();
                            dynamic calculatedNaira = balance + nairaMoney;
                            dynamic result = await AuthService()
                                .updateWallet(calculatedNaira.toString(), 'naira');

                            // if (result['status']) {
                            //   dynamic result1 = await AuthService().updateOrder(
                            //     '${widget.currency['currency']}',
                            //     coinAmount.toString(),
                            //     nairaMoney.toString(),
                            //     widget.user['userName'].toString(),
                            //     'sellOrder',
                            //     widget.user['mobile'].toString(),
                            //     true,
                            //   );

                              if (result['status']) {
                                dynamic result2 = await AuthService()
                                    .updateTransactionList(
                                        'Deposited',
                                        'Bank Account',
                                        'Naira Wallet',
                                        '',
                                        nairaMoney.toString(),
                                        'nairaWalletTransactionList',
                                        '',
                                        true);

                                if (result2['status']) {
                                  _progressDialog.hide();
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SuccessfulPage(
                                          text: 'money is  successfully deposited',
                                          text1:
                                              'You\'ve successfully deposited  \₦${formatPrice(nairaMoney)}',
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
