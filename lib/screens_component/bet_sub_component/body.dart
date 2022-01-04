
import 'package:Crypto_wallet/screens/bills_payment_screen.dart';
import 'package:Crypto_wallet/services/dialog_service.dart';
import 'package:Crypto_wallet/services/validator.dart';
import 'package:Crypto_wallet/shared/alert_sheet.dart';
import 'package:Crypto_wallet/shared/bills-payment_form.dart';
import 'package:Crypto_wallet/shared/succesful_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Crypto_wallet/services/auth.dart';
import 'package:Crypto_wallet/shared/outLined_box.dart';
import 'package:Crypto_wallet/shared/bills_check_out_screen.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Body extends StatefulWidget {
  final List walletList;
  Body({this.walletList});
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String balance;
  String biller;
  // String product;
  dynamic amount;
  String equivalence;
  String account;
  final TextEditingController mobileNumber = TextEditingController();
  final nairaAmount = TextEditingController();
  final currencyAmount = TextEditingController();
  // PhoneNumber number = PhoneNumber(isoCode: 'NG');
  bool enableButton = false;
  bool isNairaWallet = true;
  bool isNaira = false;
  bool isCurrency = false;
  dynamic price;
  dynamic price1;
  dynamic nairaRate1;
  dynamic nairaRate;
  dynamic symbol;
  dynamic symbol1;
  String userName, userId;
  bool accountSelected = false;
  dynamic date = DateTime.now().millisecondsSinceEpoch;
    

  // @override
  // void initState() {
  //   setState(() {
  //     isNairaWallet = true;
  //     accountSelected = false;
  //   });
  //   super.initState();
  // }

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

  void enableSubmitButton() {
    // final enteredName = accountName.text;
    String bill = Validators.biller(biller);
    String prod = Validators.product(userId);
    String mobile = Validators.referenceNumber(userName);
    String acct = Validators.account(account);
    String amt = Validators.amount(nairaAmount.text);
    String equi = Validators.equivalence(currencyAmount.text);
    if ((bill == 'valid') &&
        (prod == 'valid') &&
        (mobile == 'valid') &&
        (acct == 'valid') &&
        (amt == 'valid') &&
        (equi == 'valid')) {
      setState(() {
        enableButton = true;
      });
      // } else if(accountname == null)  {
      //   setState(() {
      //     enableButton = false;
      //   });
    } else {
      setState(() {
        enableButton = false;
      });
    }
  }

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  getSnackBar(
    String value,
    MaterialColor color,
  ) {
    Scaffold.of(context).removeCurrentSnackBar();
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: new Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold",
          ),
        ),
        backgroundColor: color,
        duration: Duration(seconds: 3),
      ),
    );
  }

  ProgressDialog _progressDialog;
  // dynamic cableList;
  // List packages;
  // bool _loading = false;
  // @override
  // void didChangeDependencies() {
  //   _loading = true;
  //   CableList().getCableList().then((value) {
  //     if (mounted) {
  //       setState(() {
  //         // currencies = nairaWallet;
  //         dynamic data = json.decode(value['message']);
  //         print(data.toString());
  //         cableList = data['TV_ID'];
  //         print('anytime am ready');
  //         print(cableList.toString());

  //         _loading = false;
  //       });

  //       // print(_loaders.toString());
  //     }
  //   });

  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    String oid = date.toString();
    //  isNairaWallet = true;

    final List billers = [
      {'network': 'Betway', 'code': '01'},
      {'network': 'Melbet', 'code': '02'},
      {'network': '22bet', 'code': '04'},
      {'network': 'bet365', 'code': '01'},
      {'network': 'Betwinner', 'code': '02'},
      {'network': 'Bet9ja', 'code': '04'},
      {'network': 'Betfair', 'code': '01'},
      {'network': 'Nairabet', 'code': '02'},
      {'network': 'Wazobet', 'code': '04'},
      {'network': 'SportyBet', 'code': '04'},
    ];

    // final List products = [
    //   {'name': 'MTN VTU', 'code': '044'},
    //   {'name': 'GLO VTU', 'code': '023'},
    //   {'name': 'AIRTEL VTU', 'code': '559'},
    //   {'name': '9 MOBILE VTU', 'code': '050'},
    // ];
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
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            // height: MediaQuery.of(context).size.height * 0.9,
            // child: SingleChildScrollView(
            // child: Container(

            child: BillsPaymentForm(
              isSpectranet: false,
              isInBetScreen: true,
              billerList: billers,

              // productList: packages,
              // numberOrReferenceText: 'Mobile',
              chooseAccountOnChanged: (value) async {
                account = value;

                String isValid = Validators.account(value);
                setState(() {
                  enableButton = false;
                });
                if (isValid == 'valid') {
                  setState(() {
                    accountSelected = true;
                    DialogService()
                        .getSnackBar(context, ' valid ', Colors.lightGreen);
                    enableSubmitButton();
                    // accountSelected = true;
                  });

                  widget.walletList.forEach((element) async {
                    if (value == element['walletName'].toString()) {
                      balance = element['balance'].toString();
                      if (element['walletName'] == 'Naira Wallet') {
                        setState(() {
                          isNairaWallet = true;
                        });
                        price = element['price'].toString();
                        nairaRate = element['nairaRate'].toString();
                        symbol = element['symbol'];
                        print(symbol);
                        print(price);
                      } else {
                        setState(() {
                          isNairaWallet = false;
                        });
                        price1 = element['price'].toString();
                        nairaRate1 = element['nairaRate'].toString();
                        symbol1 = element['symbol'];
                        print(symbol1);
                        print(price1);
                      }

                      print('this is the $balance');
                      print(value);
                    }
                  });
                } else {
                  DialogService().getSnackBar(
                    context,
                    isValid,
                    Colors.red,
                  );
                }
              },

              widget1: Focus(
                onFocusChange: (hasFocus) {
                  if (hasFocus && mounted) {
                    setState(() {
                      isNaira = true;
                      isCurrency = false;
                    });
                  }
                },
                child: OutLinedBox(
                  // enable: false,
                  readOnly: false,

                  // hintText: '2000',
                  label: 'Amount',
                  controller: nairaAmount,
                  validate: accountSelected,
                  // isNaira,
                  press: (value) {
                    // amount = value;
                    setState(() {
                      enableButton = false;
                      if (value.isEmpty) {
                        setState(() {
                          enableButton = false;
                        });
                      } else {
                        enableSubmitButton();
                        if (accountSelected) {
                          if (isNairaWallet) {
                            Future.value(Duration(seconds: 1)).whenComplete(() {
                              dynamic nairaUsdEquivalance =
                                  double.parse(value) / double.parse(price);
                              currencyAmount.text =
                                  nairaUsdEquivalance.toStringAsFixed(8);
                            });
                          } else {
                            dynamic nairaPrice =
                                double.parse(price1) * double.parse(nairaRate1);

                            Future.value(Duration(seconds: 1)).whenComplete(() {
                              dynamic currency =
                                  double.parse(value) / nairaPrice;
                              currencyAmount.text = currency.toStringAsFixed(8);
                            });
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: 'please choose account to pay from',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.black,
                              textColor: Colors.white);
                        }
                      }
                    });
                  },
                  validator: (value) {
                    // amount = value;
                    // setState(() {
                    // enableButton = false;
                    // });
                    if (value.isNotEmpty) {
                      // enableButton = true;
                      // enableSubmitButton();
                      if (accountSelected) {
                        if (isNairaWallet) {
                          Future.value(Duration(seconds: 1)).whenComplete(() {
                            dynamic nairaUsdEquivalance =
                                double.parse(value) / double.parse(price);
                            currencyAmount.text =
                                nairaUsdEquivalance.toStringAsFixed(8);
                          });
                        } else {
                          dynamic nairaPrice =
                              double.parse(price1) * double.parse(nairaRate1);

                          Future.value(Duration(seconds: 1)).whenComplete(() {
                            dynamic currency = double.parse(value) / nairaPrice;
                            currencyAmount.text = currency.toStringAsFixed(8);
                          });
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: 'please choose account to pay from',
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.black,
                            textColor: Colors.white);
                      }
                    } else {
                      // setState(() {
                      // enableButton = false;
                      // });

                      Future.value(Duration(seconds: 1)).whenComplete(() {
                        currencyAmount.text = '0.0';
                        return 'Please enter value';
                      });
                    }
                    return null;
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
              widget2: Focus(
                onFocusChange: (hasFocus) {
                  if (hasFocus && mounted) {
                    setState(() {
                      isNaira = false;
                      isCurrency = true;
                    });
                  }
                },
                child: OutLinedBox(
                  // hintText: '0.02344',
                  readOnly: false,

                  label: 'Equivalence',
                  controller: currencyAmount,
                  isNumberType: true,
                  validate: isCurrency,
                  text: Container(
                    padding: EdgeInsets.only(top: 15),
                    child: !isNairaWallet
                        ? Text(
                            symbol1 != null ? symbol1 : 'loading',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        : Text(
                            symbol != null ? symbol : 'loading',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                  ),
                  press: (value) {
                    setState(() {
                      enableButton = false;
                    });
                    if (value.isEmpty) {
                      setState(() {
                        enableButton = false;
                      });

                      Future.value(Duration(seconds: 1)).whenComplete(() {
                        nairaAmount.text = "0.0";
                      });
                      // return null;
                      return 'Please enter value';
                    } else {
                      enableSubmitButton();
                      if (isNairaWallet) {
                        Future.value(Duration(seconds: 1)).whenComplete(() {
                          dynamic cal =
                              double.parse(price) * double.parse(value);
                          dynamic naira = cal;

                          nairaAmount.text = naira.toStringAsFixed(4);
                        });
                      } else {
                        dynamic nairaPrice =
                            double.parse(price1) * double.parse(nairaRate1);
                        Future.value(Duration(seconds: 1)).whenComplete(() {
                          dynamic cal = ((nairaPrice * double.parse(value)));
                          dynamic naira = cal;

                          nairaAmount.text = naira.toStringAsFixed(8);
                        });
                      }
                      // var price = double.parse(widget.currency['price']);

                      return null;
                    }
                  },
                ),
              ),

              billerOnChanged: (value) {
                biller = value.toLowerCase();

                String isValid = Validators.biller(value);
                setState(() {
                  enableButton = false;
                });
                if (isValid == 'valid') {
                  setState(() {
                    DialogService()
                        .getSnackBar(context, ' valid ', Colors.lightGreen);
                    enableSubmitButton();
                  });
                  billers.forEach((element) async {
                    if (value == element['network'].toString()) {
                      // if (cableList != null) {
                      //   if (element['network'] == 'dstv') {
                      //     //  if (packages != null) {
                      //     //   packages.clear();
                      //     // }
                      //     List data = cableList['DStv'];
                      //     print(data.toString());

                      //     data.forEach((element) {
                      //       packages = element['PRODUCT'];
                      //     });
                      //     // code = '01';
                      //     // bundles = data['PRODUCT'];
                      //     print('anything');

                      //     print(packages);
                      //   } else if (element['network'] == 'gotv') {
                      //     //  if (packages != null) {
                      //     //   packages.clear();
                      //     // }
                      //     List data = cableList['GOtv'];
                      //     print(data.toString());

                      //     data.forEach((element) {
                      //       packages = element['PRODUCT'];
                      //     });
                      //     // code = '02';
                      //     print('anything');

                      //     print(packages);
                      //   } else if (element['network'] == 'startimes') {
                      //     // packages.clear();
                      //     List data = cableList['Startimes'];
                      //     print(data.toString());
                      //     data.forEach((element) {
                      //       packages = element['PRODUCT'];
                      //     });
                      //     // code = '04';

                      //     print(packages);
                      //   }
                      // }

                      // print(value);
                    }
                  });
                } else {
                  DialogService().getSnackBar(
                    context,
                    isValid,
                    Colors.red,
                  );
                }
              },
              // productOnChanged: (value) {
              //   packageName = value.toLowerCase();
              //   String isValid = Validators.product(value);
              //   setState(() {
              //     enableButton = false;
              //   });
              //   if (isValid == 'valid') {
              //     setState(() {
              //       DialogService()
              //           .getSnackBar(context, ' valid ', Colors.lightGreen);
              //       enableSubmitButton();
              //     });

              //     packages.forEach((element) {
              //       if (value == element['PACKAGE_NAME']) {
              //         packageId = element['PACKAGE_ID'];

              //         amount = double.parse(element['PACKAGE_AMOUNT']);
              //         nairaAmount.text = amount.toStringAsFixed(0);
              //         // print(product);
              //       }
              //     });
              //     print(amount);
              //     // print(product);
              //   } else {
              //     DialogService().getSnackBar(
              //       context,
              //       isValid,
              //       Colors.red,
              //     );
              //   }
              // },

              walletList: widget.walletList,
              numberOrReferenceText: 'Bet account Username',
              refrenceOrNumberOnChanged: (value) {
                userName = value.toString();
                // String isValid = Validators.referenceNumber(value);
                setState(() {
                  enableButton = false;
                });
                if (value.isNotEmpty) {
                  setState(() {
                    enableSubmitButton();
                  });
                } else {
                  setState(() {
                    enableButton = false;
                  });
                  DialogService().getSnackBar(
                    context,
                    'please enter bets username ',
                    Colors.red,
                  );
                }
              },
              userId: ' Bet account UserId' ,
              userIdOnChanged: (value) {
                userId = value.toString();
                // String isValid = Validators.referenceNumber(value);
                setState(() {
                  enableButton = false;
                });
                if (value.isNotEmpty) {
                  setState(() {
                    enableSubmitButton();
                  });
                } else {
                  setState(() {
                    enableButton = false;
                  });
                  DialogService().getSnackBar(
                    context,
                    'please enter bets user id',
                    Colors.red,
                  );
                }
              },

              continuePressed: !enableButton
                  ? null
                  : () async {
                      // dynamic nairaCharge =
                      //     double.parse(nairaAmount.text) / 100;
                      // dynamic nairaTotalAmount =
                      //     nairaCharge + double.parse(nairaAmount.text);
                      // dynamic coinCharge =
                      //     double.parse(currencyAmount.text) / 100;
                      // dynamic coinTotalAmount =
                      //     coinCharge + double.parse(currencyAmount.text);
                      dynamic coin = double.parse(currencyAmount.text);
                      dynamic naira = double.parse(nairaAmount.text);
                      dynamic user = await AuthService().getUserDataById();
                      _showBottomSheet(BillsCheckOutScreen(
                        text:
                            'You are about to Sub your $biller account with  ${nairaAmount.text}',
                        text1: !isNairaWallet
                            ? 'Exchange rate \$1 \~ $nairaRate1'
                            : 'Exchange rate \$1 \~ $nairaRate',
                        userItem: account,
                        userItem1: user['userName'],
                        userItem2: user['email'],
                        biller: biller,
                        product: '$biller Sub',
                        reference: userName,
                        userId: userId,
                        chargeInCoin: 0.0,
                        symbol: !isNairaWallet ? symbol1 : symbol,
                        chargeInOtherCurrency: 0.0,
                        coinAmount: currencyAmount.text,
                        otherCurrencyAmount: nairaAmount.text,
                        coinTotalAmountToSend: coin.toStringAsFixed(8),
                        otherCurrencyTotalAmountToSend:
                            naira.toStringAsFixed(2),
                        press: () async {
                          dynamic currentBalance = double.parse(balance);

                          if (isNairaWallet) {
                            if (currentBalance < naira) {
                              _progressDialog.hide();
                              Fluttertoast.showToast(
                                  msg: 'Insufficient fund ',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white);
                              _showBottomSheet(AlertSheet(
                                text1: 'you do not have sufficient funds ',
                                text2: 'you can deposit to ur account ',
                                text3: 'deposit Now',
                                press: () {
                                  Navigator.pushNamed(context, 'naira_deposit');
                                },
                              ));
                            } else {
                              _progressDialog.show();
                              dynamic result = await AuthService().updateOrder(
                                  symbol,
                                  currencyAmount.text,
                                  nairaAmount.text,
                                  user['userName'],
                                  user['email'],
                                  'betSubscription',
                                  user['mobile'],
                                  false,
                                  biller,
                                  userName,
                                  userId,
                                  true);

                              if (result['status'] = true) {
                                dynamic nairaBalance =
                                    double.parse(balance) - naira;
                                dynamic result1 = await AuthService()
                                    .updateWallet(
                                        nairaBalance.toString(), 'naira');
                                if (result1['status']) {
                                  dynamic result2 = await AuthService()
                                      .updateTransactionList(
                                          "Bet Subscription",
                                          'Naira Wallet',
                                          '$biller, username: $userName',
                                          currencyAmount.text,
                                          nairaAmount.text,
                                          'nairaWalletTransactionList',
                                          symbol,
                                          false,
                                          oid,
                                          'nairaWalletTransactionList',);
                                  if (result2['status']) {
                                    _progressDialog.hide();
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SuccessfulPage(
                                            text:
                                                'Bet  Subscription order was recieved',
                                            text1:
                                                'You\'ve successfully ordered for  your $biller account to be funded with  \₦${nairaAmount.text}',
                                                text2: 'You will recieve your order in the next 24 hours',
                                            press: () {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BillsPaymentScreen()),
                                                  (route) => false);
                                            },
                                          ),
                                        ),
                                        (route) => false);
                                  } else {
                                    _progressDialog.hide();
                                    Fluttertoast.showToast(
                                        msg: result2['message'].toString(),
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white);
                                  }
                                } else {
                                  _progressDialog.hide();
                                  Fluttertoast.showToast(
                                      msg: result1['message'].toString(),
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white);
                                }
                                // } else {
                                //   _progressDialog.hide();
                                //   print(name['status'].toString());
                                //   Fluttertoast.showToast(
                                //       msg: name['status'].toString(),
                                //       toastLength: Toast.LENGTH_LONG,
                                //       gravity: ToastGravity.BOTTOM,
                                //       backgroundColor: Colors.black,
                                //       textColor: Colors.white);
                                // }
                              } else {
                                _progressDialog.hide();
                                print(result['message'].toString());
                                Fluttertoast.showToast(
                                    msg: result['message'].toString(),
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white);
                              }
                            }
                          } else {
                            if (currentBalance < coin) {
                              _progressDialog.hide();
                              Fluttertoast.showToast(
                                  msg: 'Insufficient fund ',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white);
                              _showBottomSheet(AlertSheet(
                                text1: 'you do not have sufficient funds ',
                                text2: 'you can deposit to ur account ',
                                text3: 'deposit Now',
                                press: () {
                                  Navigator.pushNamed(
                                      context, 'naira_transfer');
                                },
                              ));
                            } else {
                              _progressDialog.show();
                              dynamic result = await AuthService().updateOrder(
                                  symbol1,
                                  currencyAmount.text,
                                  nairaAmount.text,
                                  user['userName'],
                                  user['email'],
                                  'betSubscription',
                                  user['mobile'],
                                  false,
                                 biller,
                                  userName,
                                  userId,
                                  true);

                              if (result['status'] = true) {
                                
                                  dynamic coinBalance =
                                      double.parse(balance) - coin;
                                  dynamic response = await AuthService()
                                      .updateWallet(
                                          coinBalance.toString(), symbol1);
                                  if (response['status']) {
                                    dynamic response1 = await AuthService()
                                        .updateTransactionList(
                                            "Bet Subscription",
                                            '$symbol1 Wallet',
                                            '$biller, username: $userName',
                                            currencyAmount.text,
                                            nairaAmount.text,
                                            "${symbol1}WalletTransactionList",
                                            symbol1,
                                            false,
                                            oid,
                                            "${symbol1}WalletTransactionList",);
                                    if (response1['status']) {
                                      _progressDialog.hide();
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SuccessfulPage(
                                              text:
                                                  'bet subscription was successful',
                                              text1:
                                                  'You\'ve successfully Subscribed your $biller account  with  \₦${nairaAmount.text}',
                                              press: () {
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BillsPaymentScreen()),
                                                    (route) => false);
                                              },
                                            ),
                                          ),
                                          (route) => false);
                                    } else {
                                      _progressDialog.hide();
                                      Fluttertoast.showToast(
                                          msg: response1['message'].toString(),
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white);
                                    }
                                  } else {
                                    _progressDialog.hide();
                                    Fluttertoast.showToast(
                                        msg: response['message'].toString(),
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white);
                                  }
                                // } else {
                                //   _progressDialog.hide();
                                //   print(name['status'].toString());
                                //   Fluttertoast.showToast(
                                //       msg: name['status'].toString(),
                                //       toastLength: Toast.LENGTH_LONG,
                                //       gravity: ToastGravity.BOTTOM,
                                //       backgroundColor: Colors.black,
                                //       textColor: Colors.white);
                                // }
                              } else {
                                _progressDialog.hide();
                                print(result['message'].toString());
                                Fluttertoast.showToast(
                                    msg: result['message'].toString(),
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white);
                              }
                            }
                          }
                        },
                      ));
                    },
            ),
          ),
          // ),
          // )
        ],
      ),
    );
  }
}
