import 'package:Crypto_wallet/services/flutterwave/widgets/flutterwave_view_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:Crypto_wallet/services/flutterwave/core/card_payment_manager/card_payment_manager.dart';
import 'package:Crypto_wallet/services/flutterwave/core/flutterwave_payment_manager.dart';
import 'package:Crypto_wallet/services/flutterwave/core/pay_with_account_manager/bank_account_manager.dart';
import 'package:Crypto_wallet/services/flutterwave/core/ussd_payment_manager/ussd_manager.dart';
import 'package:Crypto_wallet/services/flutterwave/models/responses/charge_response.dart';
import 'package:Crypto_wallet/services/flutterwave/widgets/bank_account_payment/bank_account_payment.dart';
import 'package:Crypto_wallet/services/flutterwave/widgets/card_payment/card_payment.dart';
import 'package:Crypto_wallet/services/flutterwave/widgets/ussd_payment/pay_with_ussd.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'url';
import 'flutterwave_payment_option.dart';

class FlutterwaveUI extends StatefulWidget {
  final FlutterwavePaymentManager _flutterwavePaymentManager;

  FlutterwaveUI(this._flutterwavePaymentManager);

  @override
  _FlutterwaveUIState createState() => _FlutterwaveUIState();
}

class _FlutterwaveUIState extends State<FlutterwaveUI> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final FlutterwavePaymentManager paymentManager =
        this.widget._flutterwavePaymentManager;

    return MaterialApp(
      debugShowCheckedModeBanner: paymentManager.isDebugMode,
      home: Scaffold(
        key: this._scaffoldKey,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 50, 10, 70),
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.lock,
                              size: 10.0,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              "SECURED BY FLUTTERWAVE",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10.0,
                                letterSpacing: 1.0,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: kIsWeb ? 100 : 5,
                        ),
                        Container(
                          width: double.infinity,
                          margin: kIsWeb
                              ? EdgeInsets.fromLTRB(0, 100, 0, 0)
                              : EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Text(
                            "How would you \nlike to pay?",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 30.0,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 5,
                            width: 200,
                            color: Colors.pink,
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white38,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Visibility(
                          visible: paymentManager.acceptAccountPayment,
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: 50.0,
                                child: FlutterwavePaymentOption(
                                  handleClick: this._launchPayWithAccountWidget,
                                  buttonText: "Account",
                                ),
                              ),
                              SizedBox(
                                height: 0.5,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: paymentManager.acceptCardPayment,
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: 50.0,
                                child: FlutterwavePaymentOption(
                                  handleClick: this._launchCardPaymentWidget,
                                  buttonText: "Card",
                                ),
                              ),
                              SizedBox(
                                height: 0.5,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: paymentManager.acceptUSSDPayment,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50.0,
                                child: FlutterwavePaymentOption(
                                  handleClick: this._launchUSSDPaymentWidget,
                                  buttonText: "USSD",
                                ),
                              ),
                              SizedBox(
                                height: 0.5,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: false,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50.0,
                                child: FlutterwavePaymentOption(
                                  handleClick: () => {},
                                  buttonText: "Barter",
                                ),
                              ),
                              SizedBox(
                                height: 0.5,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: paymentManager.manualBankTransfer,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15.0),
                              Container(
                                color: Color(0xFFfff1d0),
                                padding: EdgeInsets.all(8.0),
                                width: double.infinity,
                                child: RichText(
                                  text: TextSpan(
                                    text:
                                        "Having issues paying with the above methods?\nYou can pay to the following account details and send a picture of your payment via WhatsApp to ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: "+234 703 3671 000\n\n",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              launch(
                                                  'https://api.whatsapp.com/send?phone=2347033671000');
                                            }),
                                      TextSpan(
                                        text: "Account Number: ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "1017206366\n",
                                      ),
                                      TextSpan(
                                        text: "Account Name: ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            "customizednativeschool.com ltd\n",
                                      ),
                                      TextSpan(
                                        text: "Bank name: ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Zenith Bank\n",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: Colors.pink,
                              ),
                              SizedBox(
                                height: 50.0,
                                child: FlutterwavePaymentOption(
                                  handleClick: this._confirmManualPayment,
                                  buttonText: "I have paid",
                                  isManual: true,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _launchCardPaymentWidget() async {
    final CardPaymentManager cardPaymentManager =
        this.widget._flutterwavePaymentManager.getCardPaymentManager();
    final ChargeResponse chargeResponse = await Navigator.push(
      this.context,
      MaterialPageRoute(builder: (context) => CardPayment(cardPaymentManager)),
    );
    String message;
    if (chargeResponse != null) {
      message = chargeResponse.message;
    } else {
      message = "Transaction cancelled";
    }
    this.showSnackBar(message);
    Navigator.pop(this.context, chargeResponse);
  }

  void _launchPayWithAccountWidget() async {
    final BankAccountPaymentManager bankAccountPaymentManager =
        this.widget._flutterwavePaymentManager.getBankAccountPaymentManager();
    final response = await Navigator.push(
      this.context,
      MaterialPageRoute(
          builder: (context) => PayWithBankAccount(bankAccountPaymentManager)),
    );
    Navigator.pop(this.context, response);
  }

  void _launchUSSDPaymentWidget() async {
    final USSDPaymentManager paymentManager =
        this.widget._flutterwavePaymentManager.getUSSDPaymentManager();
    final response = await Navigator.push(
      this.context,
      MaterialPageRoute(builder: (context) => PayWithUssd(paymentManager)),
    );
    Navigator.pop(this.context, response);
  }

  void showSnackBar(String message) {
    SnackBar snackBar = SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
    );
    this._scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void _confirmManualPayment() {
    FlutterwaveViewUtils.confirmManualPaymentModal(context,
        widget._flutterwavePaymentManager.amount, _saveManualPaymentOrder);
  }

  void _saveManualPaymentOrder() {
    Navigator.pop(this.context);
    ChargeResponse response = ChargeResponse(
      status: 'success',
      message: "Payment made; pending confirmation",
      isManual: true,
    );
    Navigator.pop(this.context, response);
  }
}
