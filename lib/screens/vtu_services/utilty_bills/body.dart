import 'package:Crypto_wallet/screens/tab_Screen/tab_screen.dart';
import 'package:Crypto_wallet/services/dialog_service.dart';
import 'package:Crypto_wallet/services/validator.dart';
import 'package:Crypto_wallet/shared/alert_sheet.dart';
import 'package:Crypto_wallet/shared/bills-payment_form.dart';
import 'package:Crypto_wallet/shared/succesful_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Crypto_wallet/services/auth.dart';
import 'package:Crypto_wallet/services/api_services.dart';
import 'package:Crypto_wallet/screens/vtu_services/components/outLined_box.dart';
import 'package:Crypto_wallet/screens/vtu_services/components/bills_check_out_screen.dart';
import 'dart:convert';

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
  String equivalence;
  String account;
  // final TextEditingController mobileNumber = TextEditingController();
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
  dynamic meterToken;
  dynamic shortName, electricityCode, productType, meterType, meterNumber;
  // dynamic packageName, packageId;
  //  String smartCardNumber;
  bool accountSelected = false;

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
    String bill = Validators.biller(biller);
    String prod = Validators.product(productType);
    String mobile = Validators.referenceNumber(meterNumber);
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
  dynamic electricityList;
  List product;
  // bool _loading = false;
  @override
  void didChangeDependencies() {
    // _loading = true;
    ApiServices().getUtilityBillList().then((value) {
      if (mounted) {
        setState(() {
          // currencies = nairaWallet;
          dynamic data = json.decode(value['message']);
          print(data.toString());
          electricityList = data['ELECTRIC_COMPANY'];
          print('anytime am ready');
          print(electricityList.toString());

          // _loading = false;
        });

        // print(_loaders.toString());
      }
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //  isNairaWallet = true;

    final List billers = [
      {
        'network': 'Eko Electric - EKEDC (PHCN)',
        'code': 'EKEDC (PHCN)',
        'companyCode': '01'
      },
      {
        'network': 'Ikeja Electric - IKEDC (PHCN)',
        'code': 'IKEDC (PHCN)',
        'companyCode': '02'
      },
      {'network': 'Abuja Electric - AEDC', 'code': 'AEDC', 'companyCode': '03'},
      {'network': 'Kano Electric - KEDC', 'code': 'KEDC', 'companyCode': '04'},
      {
        'network': 'Portharcourt Electric - PHEDC',
        'code': 'PHEDC',
        'companyCode': '05'
      },
      {'network': 'Jos Electric - JEDC', 'code': 'JEDC', 'companyCode': '06'},
      {
        'network': 'Ibadan Electric - IBEDC',
        'code': 'IBEDC',
        'companyCode': '07'
      },
      {
        'network': 'Kaduna Electric - KAEDC',
        'code': 'KAEDC',
        'companyCode': '08'
      },
      {'network': 'ENUGU Electric - EEDC', 'code': 'EEDC', 'companyCode': '09'},
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
              isInBetScreen: false,
              billerList: billers,
              productList: product,
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
                print(electricityList.toString());

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
                      shortName = element['code'];
                      electricityCode = element['companyCode'];
                      print(electricityCode);
                      if (electricityList != null) {
                        if (element['network'] ==
                            'Eko Electric - EKEDC (PHCN)') {
                          //  if (packages != null) {
                          //   packages.clear();
                          // }
                          List data = electricityList['EKO_ELECTRIC'];
                          print(data.toString());

                          data.forEach((element) {
                            product = element['PRODUCT'];
                          });
                          // code = '01';
                          // bundles = data['PRODUCT'];
                          print('anything');

                          print(product);
                        } else if (element['network'] ==
                            'Ikeja Electric - IKEDC (PHCN)') {
                          //  if (packages != null) {
                          //   packages.clear();
                          // }
                          List data = electricityList['IKEJA_ELECTRIC'];
                          print(data.toString());

                          data.forEach((element) {
                            product = element['PRODUCT'];
                          });
                          // code = '02';
                          print('anything');

                          print(product);
                        } else if (element['network'] ==
                            'Abuja Electric - AEDC') {
                          // packages.clear();
                          List data = electricityList['ABUJA_ELECTRIC'];
                          print(data.toString());
                          data.forEach((element) {
                            product = element['PRODUCT'];
                          });
                          // code = '04';

                          print(product);
                        } else if (element['network'] ==
                            'Kano Electric - KEDC') {
                          // packages.clear();
                          List data = electricityList['KANO_ELECTRIC'];
                          print(data.toString());
                          data.forEach((element) {
                            product = element['PRODUCT'];
                          });
                          // code = '04';

                          print(product);
                        } else if (element['network'] ==
                            'Portharcourt Electric - PHEDC') {
                          // packages.clear();
                          List data = electricityList['PORTHARCOURT_ELECTRIC'];
                          print(data.toString());
                          data.forEach((element) {
                            product = element['PRODUCT'];
                          });
                          // code = '04';

                          print(product);
                        } else if (element['network'] ==
                            'Jos Electric - JEDC') {
                          // packages.clear();
                          List data = electricityList['JOS_ELECTRIC'];
                          print(data.toString());
                          data.forEach((element) {
                            product = element['PRODUCT'];
                          });
                          // code = '04';

                          print(product);
                        } else if (element['network'] ==
                            'Ibadan Electric - IBEDC') {
                          // packages.clear();
                          List data = electricityList['IBADAN_ELECTRIC'];
                          print(data.toString());
                          data.forEach((element) {
                            product = element['PRODUCT'];
                          });
                          // code = '04';

                          print(product);
                        } else if (element['network'] ==
                            'Kaduna Electric - KAEDC') {
                          // packages.clear();
                          List data = electricityList['Kaduna_ELECTRIC'];
                          print(data.toString());
                          data.forEach((element) {
                            product = element['PRODUCT'];
                          });
                          // code = '04';

                          print(product);
                        } else if (element['network'] ==
                            'ENUGU Electric - EEDC') {
                          // packages.clear();
                          List data = electricityList['ENUGU_ELECTRIC'];
                          print(data.toString());
                          data.forEach((element) {
                            product = element['PRODUCT'];
                          });
                          // code = '04';

                          print(product);
                        }
                      }

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
              productOnChanged: (value) {
                productType = value.toLowerCase();
                String isValid = Validators.product(value);
                setState(() {
                  enableButton = false;
                });
                if (isValid == 'valid') {
                  setState(() {
                    DialogService()
                        .getSnackBar(context, ' valid ', Colors.lightGreen);
                    enableSubmitButton();
                  });

                  product.forEach((element) {
                    if (value == element['PRODUCT_TYPE']) {
                      meterType = element['PRODUCT_ID'];
                      // productType = element['PRODUCT_TYPE'];

                      // print(product);
                    }
                  });
                  print(productType);
                  print(meterType);
                } else {
                  DialogService().getSnackBar(
                    context,
                    isValid,
                    Colors.red,
                  );
                }
              },

              walletList: widget.walletList,
              numberOrReferenceText: 'Meter Number',
              refrenceOrNumberOnChanged: (value) {
                meterNumber = value.toString();
                // String isValid = Validators.referenceNumber(value);
                setState(() {
                  enableButton = false;
                });
                if (value.isNotEmpty) {
                  setState(() {
                    DialogService()
                        .getSnackBar(context, ' valid ', Colors.lightGreen);
                    enableSubmitButton();
                  });
                } else {
                  setState(() {
                    enableButton = false;
                  });
                  DialogService().getSnackBar(
                    context,
                    'please enter reference number',
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
                            'You are about to pay for your $shortName electricity bill with  ${nairaAmount.text}',
                        text1: !isNairaWallet
                            ? 'Exchange rate \$1 \~ $nairaRate1'
                            : 'Exchange rate \$1 \~ $nairaRate',
                        userItem: account,
                        userItem1: user['userName'],
                        userItem2: user['email'],
                        biller: biller,
                        product: '$shortName $productType',
                        reference: meterNumber,
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
                              dynamic result = await ApiServices()
                                  .payElectricityBill(electricityCode,
                                      meterType, meterNumber, nairaAmount.text);

                              if (result['status'] = true) {
                                dynamic rep = result['message'].toString();
                                dynamic name = json.decode(rep);

                                if (name['status'] == 'ORDER_RECEIVED') {
                                  print(name['status'].toString());
                                  meterToken = name['metertoken'];

                                  dynamic nairaBalance =
                                      double.parse(balance) - naira;
                                  dynamic result1 = await AuthService()
                                      .updateWallet(
                                          nairaBalance.toString(), 'naira');
                                  if (result1['status']) {
                                    dynamic result2 = await AuthService()
                                        .updateTransactionList(
                                            "Utility payment",
                                            'Naira Wallet',
                                            'Meter number: $meterNumber Type: $shortName $productType',
                                            currencyAmount.text,
                                            nairaAmount.text,
                                            'nairaWalletTransactionList',
                                            symbol,
                                            true);
                                    if (result2['status']) {
                                      _progressDialog.hide();
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SuccessfulPage(
                                              text:
                                                  'Utility  payment was successful',
                                              text1:
                                                  'You\'ve successfully payed for your $biller  with  \₦${nairaAmount.text}',
                                              text2:
                                                  '(Your MeterToken: $meterToken)',
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
                                } else {
                                  _progressDialog.hide();
                                  print(name['status'].toString());
                                  Fluttertoast.showToast(
                                      msg: 'error occurred try again',
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white);
                                }
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
                              dynamic result = await ApiServices()
                                  .payElectricityBill(electricityCode,
                                      meterType, meterNumber, nairaAmount.text);

                              if (result['status'] = true) {
                                dynamic rep = result['message'].toString();
                                dynamic name = json.decode(rep);

                                if (name['status'] == 'ORDER_RECEIVED') {
                                  print(name.toString());
                                  meterToken = name['metertoken'];
                                  print(name['status'].toString());
                                  dynamic coinBalance =
                                      double.parse(balance) - coin;
                                  dynamic response = await AuthService()
                                      .updateWallet(
                                          coinBalance.toString(), symbol1);
                                  if (response['status']) {
                                    dynamic response1 = await AuthService()
                                        .updateTransactionList(
                                            "Utility payment",
                                            '$symbol1 Wallet',
                                            '$meterNumber Type: $shortName $productType',
                                            currencyAmount.text,
                                            nairaAmount.text,
                                            "${symbol1}WalletTransactionList",
                                            symbol1,
                                            true);
                                    if (response1['status']) {
                                      _progressDialog.hide();
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SuccessfulPage(
                                              text:
                                                  'Utility payment was successful',
                                              text1:
                                                  'You\'ve successfully payed for your $biller  with  \₦${nairaAmount.text}',
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
                                } else {
                                  _progressDialog.hide();
                                  print(name['status'].toString());
                                  Fluttertoast.showToast(
                                      msg: 'error occurred try again',
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white);
                                }
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
          // ),
        ],
      ),
    );
  }
}
