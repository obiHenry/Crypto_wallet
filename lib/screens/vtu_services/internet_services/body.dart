import 'package:Crypto_wallet/screens/tab_Screen/tab_screen.dart';
import 'package:Crypto_wallet/services/dialog_service.dart';
import 'package:Crypto_wallet/services/send_data.dart';
import 'package:Crypto_wallet/services/smile_and_spectranet_payment.dart';
import 'package:Crypto_wallet/services/validator.dart';
import 'package:Crypto_wallet/widgets/alert_sheet.dart';
import 'package:Crypto_wallet/widgets/bills-payment_form.dart';
import 'package:Crypto_wallet/widgets/succesful_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Crypto_wallet/services/auth.dart';
import 'package:Crypto_wallet/services/get_internet_bundles.dart';
import 'package:Crypto_wallet/screens/vtu_services/components/outLined_box.dart';
import 'package:Crypto_wallet/screens/vtu_services/components/bills_check_out_screen.dart';
import 'dart:convert';
import 'package:Crypto_wallet/services/price_formatter.dart';

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
  String product;
  // dynamic amount;
  String equivalence;
  String phoneNumber;
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
  bool accountSelected = false;
  String packageName;
  dynamic dataPlan;
  dynamic code;
  String dropDownValue;
  dynamic productCode;
  bool isSmileAndSpectranet = false;
  bool isSmile = false;
  bool isSpectranet = false;
  dynamic serialNumber, pin, expiaryDate;
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
    String prod = Validators.product(packageName);
    String mobile = Validators.mobileNumber(phoneNumber);
    String acct = Validators.account(account);
    String amt = Validators.amount(nairaAmount.text);
    String equi = Validators.equivalence(currencyAmount.text);
    if ((bill == 'valid') &&
        (prod == 'valid') &&
        (mobile == 'valid' || isSpectranet) &&
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
  dynamic dataBundles;
  List bundles = [];
  // bool _loading = false;
  @override
  void didChangeDependencies() {
    // _loading = true;
    InternetService().getDataBundles().then((value) {
      if (mounted) {
        setState(() {
          // currencies = nairaWallet;
          dynamic data = json.decode(value['message']);
          print(data.toString());
          dataBundles = data['MOBILE_NETWORK'];
          print('anytime am ready');
          print(dataBundles.toString());

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
      {'network': 'MTN', 'code': '01'},
      {'network': 'GLO', 'code': '02'},
      {'network': 'AIRTEL', 'code': '04'},
      {'network': '9 MOBILE', 'code': '03'},
      {'network': 'SMILE', 'code': '05'},
      {'network': 'SPECTRANET', 'code': '06'},
    ];
    final List products1 = [
      {
        'network': '1000 Spectranet Pin',
        'package_code': 'SPEC10',
        'price': '1000'
      },
      {
        'network': '2000 Spectranet Pin',
        'package_code': 'SPEC20',
        'price': '2000'
      },
      {
        'network': '5000 Spectranet Pin',
        'package_code': 'SPEC50',
        'price': '5000'
      },
      {
        'network': '7000 Spectranet Pin',
        'package_code': 'SPEC70',
        'price': '7000'
      },
      {
        'network': '10000 Spectranet Pin',
        'package_code': 'SPEC100',
        'price': '10000',
      }
    ];

    final List products = [
      {
        'network':
            'FlexiDaily plan - Diverse Validity (\₦${formatPrice(500.toString())})',
        'package_code': 'FPDV356',
        'price': '500'
      },
      {
        'network':
            'FlexiWeekly plan - Diverse Validity (\₦${formatPrice(1200.toString())})',
        'package_code': 'FPDV357',
        'price': '1200'
      },
      {
        'network':
            'SmileVoice ONLY 75 - 30days Validity (\₦${formatPrice(500.toString())})',
        'package_code': 'SOV495',
        'price': '500'
      },
      {
        'network':
            'SmileVoice ONLY 500 - 30days Validity (\₦${formatPrice(3000.toString())})',
        'package_code': 'SOV497',
        'price': '3000'
      },
      {
        'network':
            'SmileVoice ONLY 165 - 30days Validity (\₦${formatPrice(1000.toString())})',
        'package_code': 'SOV496',
        'price': '1000'
      },
      {
        'network':
            '1GB SmileLite plan - 30days Validity (\₦${formatPrice(1000.toString())})',
        'package_code': 'SPV220',
        'price': '1000'
      },
      {
        'network':
            '2GB SmileLite plan - 30days Validity (\₦${formatPrice(2000.toString())})',
        'package_code': 'SPV280',
        'price': '2000'
      },
      {
        'network': '2GB MidNite Plan - 7days Validity (\₦${formatPrice(1000)})',
        'package_code': 'MPV413',
        'price': '1000'
      },
      {
        'network':
            '3GB MidNite Plan - 7days Validity (\₦${formatPrice(1500.toString())})',
        'package_code': 'MPV414',
        'price': '1500'
      },
      {
        'network':
            '3GB Weekend Only Plan - 3days Validity (\₦${formatPrice(1500.toString())})',
        'package_code': 'WOPV415',
        'price': '1500'
      },
      {
        'network':
            '3GB Anytime plan - 7days Validity (\₦${formatPrice(3000.toString())})',
        'package_code': 'APV102',
        'price': '3000'
      },
      {
        'network':
            '5GB Anytime plan - 7days Validity (\₦${formatPrice(4000.toString())})',
        'package_code': 'APV150',
        'price': '4000'
      },
      {
        'network':
            '7GB Anytime plan - 7days Validity (\₦${formatPrice(5000.toString())})',
        'package_code': 'APV274',
        'price': '5000'
      },
      {
        'network':
            '10GB 30 Days Anytime plan - 7days Validity (\₦${formatPrice(7500.toString())})',
        'package_code': 'DAPV404',
        'price': '7500'
      },
      {
        'network':
            'Unlimited Lite Plan - 30days Validity (\₦${formatPrice(10000.toString())})',
        'package_code': 'ULPV476',
        'price': '10000'
      },
      {
        'network':
            'Unlimited Premium Plan - 30days Validity (\₦${formatPrice(19800.toString())})',
        'package_code': 'UPPV475',
        'price': '19800'
      },
      {
        'network':
            '30GB BumpaValue plan - Diverse Validity (\₦${formatPrice(15000.toString())})',
        'package_code': 'BPDV358',
        'price': '15000'
      },
      {
        'network':
            '60GB BumpaValue plan - Diverse Validity (\₦${formatPrice(30000.toString())})',
        'package_code': 'BPDV359',
        'price': '30000'
      },
      {
        'network':
            '80GB BumpaValue plan - Diverse Validity (\₦${formatPrice(50000.toString())})',
        'package_code': 'BPDV360',
        'price': '50000'
      },
      {
        'network':
            '10GB Anytime plan - 365days Validity (\₦${formatPrice(9000.toString())})',
        'package_code': 'APV103',
        'price': '9000'
      },
      {
        'network':
            '15GB Anytime plan - 365days Validity (\₦${formatPrice(10000.toString())})',
        'package_code': 'APV273',
        'price': '10000'
      },
      {
        'network':
            '20GB Anytime plan - 365days Validity (\₦${formatPrice(17000.toString())})',
        'package_code': 'APV104',
        'price': '17000'
      },
      {
        'network':
            '50GB Anytime plan - 365days Validity (\₦${formatPrice(36000.toString())})',
        'package_code': 'APV105',
        'price': '36000'
      },
      {
        'network':
            '100GB Anytime plan - 365days Validity (\₦${formatPrice(70000.toString())})',
        'package_code': 'APV128',
        'price': '70000'
      },
      {
        'network':
            '200GB Anytime plan - 365days Validity (\₦${formatPrice(135000.toString())})',
        'package_code': 'APV129',
        'price': '135000'
      },
    ];
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
              isSpectranet: isSpectranet,
              isInBetScreen: false,
              billerList: billers,
              productList: bundles,
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
                  readOnly: true,
                  // hintText: '2000',
                  label: 'Amount',
                  controller: nairaAmount,
                  validate: accountSelected,
                  // isNaira,
                  // press: (value) {
                  //   // amount = value;
                  //   setState(() {
                  //     enableButton = false;
                  //     if (value.isEmpty) {
                  //       setState(() {
                  //         enableButton = false;
                  //       });
                  //     } else {
                  //       enableSubmitButton();
                  //       if (accountSelected) {
                  //         if (isNairaWallet) {
                  //           Future.value(Duration(seconds: 1)).whenComplete(() {
                  //             dynamic nairaUsdEquivalance =
                  //                 double.parse(value) / double.parse(price);
                  //             currencyAmount.text =
                  //                 nairaUsdEquivalance.toStringAsFixed(8);
                  //           });
                  //         } else {
                  //           dynamic nairaPrice =
                  //               double.parse(price1) * double.parse(nairaRate1);

                  //           Future.value(Duration(seconds: 1)).whenComplete(() {
                  //             dynamic currency =
                  //                 double.parse(value) / nairaPrice;
                  //             currencyAmount.text = currency.toStringAsFixed(8);
                  //           });
                  //         }
                  //       } else {
                  //         Fluttertoast.showToast(
                  //             msg: 'please choose account to pay from',
                  //             toastLength: Toast.LENGTH_LONG,
                  //             gravity: ToastGravity.BOTTOM,
                  //             backgroundColor: Colors.black,
                  //             textColor: Colors.white);
                  //       }
                  //     }
                  //   });
                  // },
                  validator: (value) {
                    // amount = value;
                    // setState(() {
                    // enableButton = false;
                    // });
                    if (value.isNotEmpty) {
                      enableButton = true;
                      // enableSubmitButton();
                      if (accountSelected) {
                        if (isNairaWallet) {
                          Future.value(Duration(seconds: 1)).whenComplete(() {
                            dynamic nairaUsdEquivalance =
                                double.parse(value) / double.parse(price);
                            currencyAmount.text =
                                nairaUsdEquivalance.toStringAsFixed(8);
                            if (currencyAmount.text != null) {
                              enableSubmitButton();
                              // enableButton = true;
                            }
                          });
                        } else {
                          dynamic nairaPrice =
                              double.parse(price1) * double.parse(nairaRate1);

                          Future.value(Duration(seconds: 1)).whenComplete(() {
                            dynamic currency = double.parse(value) / nairaPrice;
                            currencyAmount.text = currency.toStringAsFixed(8);
                            if (currencyAmount.text != null) {
                              enableSubmitButton();
                              // enableButton = true;
                            }
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
                      enableButton = false;
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
                  readOnly: true,
                  // hintText: '0.02344',

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
                  // press: (value) {
                  //   setState(() {
                  //     enableButton = false;
                  //   });
                  //   if (value.isEmpty) {
                  //     setState(() {
                  //       enableButton = false;
                  //     });

                  //     Future.value(Duration(seconds: 1)).whenComplete(() {
                  //       nairaAmount.text = "0.0";
                  //     });
                  //     // return null;
                  //     return 'Please enter value';
                  //   } else {
                  //     enableSubmitButton();
                  //     if (isNairaWallet) {
                  //       Future.value(Duration(seconds: 1)).whenComplete(() {
                  //         dynamic cal =
                  //             double.parse(price) * double.parse(value);
                  //         dynamic naira = cal;

                  //         nairaAmount.text = naira.toStringAsFixed(4);
                  //       });
                  //     } else {
                  //       dynamic nairaPrice =
                  //           double.parse(price1) * double.parse(nairaRate1);
                  //       Future.value(Duration(seconds: 1)).whenComplete(() {
                  //         dynamic cal = ((nairaPrice * double.parse(value)));
                  //         dynamic naira = cal;

                  //         nairaAmount.text = naira.toStringAsFixed(8);
                  //       });
                  //     }
                  //     // var price = double.parse(widget.currency['price']);

                  //     return null;
                  //   }
                  // },
                ),
              ),

              billerOnChanged: (value) {
                biller = value.toLowerCase();
                dropDownValue = value;
                print(dataBundles.toString());

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
                      if (dataBundles != null) {
                        if (element['network'] == 'MTN') {
                          setState(() {
                            dropDownValue = null;
                            isSmileAndSpectranet = false;
                            isSmile = false;
                            isSpectranet = false;
                          });

                          List data = dataBundles['MTN'];
                          print(data.toString());
                          data.forEach((element) {
                            print(element['PRODUCT'].toString());
                            bundles = element['PRODUCT'];
                          });
                          code = '01';
                          // bundles = data['PRODUCT'];
                          print('anything');

                          print(bundles);
                        } else if (element['network'] == 'GLO') {
                          setState(() {
                            dropDownValue = null;
                            isSmileAndSpectranet = false;
                            isSmile = false;
                            isSpectranet = false;
                          });
                          List data = dataBundles['Glo'];
                          print(data.toString());
                          data.forEach((element) {
                            bundles = element['PRODUCT'];
                          });
                          code = '02';
                          print('anything');

                          print(bundles);
                        } else if (element['network'] == 'AIRTEL') {
                          setState(() {
                            dropDownValue = null;
                            isSmileAndSpectranet = false;
                            isSmile = false;
                            isSpectranet = false;
                          });

                          List data = dataBundles['Airtel'];
                          print(data.toString());
                          data.forEach((element) {
                            bundles = element['PRODUCT'];
                          });
                          code = '04';
                          print(bundles);
                        } else if (element['network'] == '9 MOBILE') {
                          dropDownValue = null;
                          setState(() {
                            isSmileAndSpectranet = false;
                            isSmile = false;
                            isSpectranet = false;
                          });
                          List data = dataBundles['9mobile'];
                          print(data.toString());
                          data.forEach((element) {
                            bundles = element['PRODUCT'];
                          });
                          code = '03';

                          print(bundles);
                        } else if (element['network'] == 'SMILE') {
                          dropDownValue = null;
                          setState(() {
                            isSmile = true;
                            isSpectranet = false;
                          });
                          if (isSmile || isSpectranet) {
                            isSmileAndSpectranet = true;
                            // reference = 'Smart Number';
                          }

                          // List data = dataBundles['9mobile'];
                          // print(data.toString());
                          // data.forEach((element) {
                          bundles = products;
                          // });
                          // code = '0';

                          print(bundles);
                        } else if (element['network'] == 'SPECTRANET') {
                          dropDownValue = null;
                          setState(() {
                            isSpectranet = true;
                          });
                          if (isSmile || isSpectranet) {
                            isSmileAndSpectranet = true;
                            // reference = 'Smart Number';
                          } else {
                            // reference = 'Mobile';
                          }

                          // List data = dataBundles['9mobile'];
                          // print(data.toString());
                          // data.forEach((element) {
                          bundles = products1;
                          // });
                          // code = '0';

                          print(bundles);
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
              valueText: dropDownValue,
              productOnChanged: (value) {
                packageName = value.toLowerCase();
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

                  bundles.forEach((element) {
                    if (value == element['PRODUCT_NAME']) {
                      dataPlan = element['PRODUCT_ID'];

                      dynamic charge =
                          double.parse(element['PRODUCT_AMOUNT']) * 0.066;
                      dynamic amount =
                          double.parse(element['PRODUCT_AMOUNT']) + charge;
                      nairaAmount.text = amount.toStringAsFixed(0);
                      // print(product);
                    } else if (value == element['network']) {
                      productCode = element['package_code'];
                      // dynamic charge =
                      //     double.parse(element['price']) * 0.066;
                      dynamic amount = double.parse(element['price']);
                      nairaAmount.text = amount.toStringAsFixed(0);
                      print(amount);
                    }
                  });

                  // print(product);
                } else {
                  DialogService().getSnackBar(
                    context,
                    isValid,
                    Colors.red,
                  );
                }
              },

              walletList: widget.walletList,
              numberOrReferenceText:
                  isSmileAndSpectranet ? 'Smartno' : 'Mobile',
              refrenceOrNumberOnChanged: (value) {
                phoneNumber = value.toLowerCase();
                String isValid = Validators.mobileNumber(value);
                setState(() {
                  enableButton = false;
                });
                if (isValid == 'valid') {
                  setState(() {
                    DialogService()
                        .getSnackBar(context, ' valid ', Colors.lightGreen);
                    enableSubmitButton();
                  });
                } else {
                  DialogService().getSnackBar(
                    context,
                    isValid,
                    Colors.red,
                  );
                }
              },

              // widget: Container(
              //   width: MediaQuery.of(context).size.width * 0.9,
              //   child:

              //    InternationalPhoneNumberInput(
              //     // CustomDecoration()

              //     onInputChanged: (PhoneNumber number) {
              //       print(number.phoneNumber);
              //       mobile = number.phoneNumber;
              //       print(number);
              //     },
              //     onInputValidated: (bool value) {
              //       phoneValue = value;
              //       String isValid = Validators.mobileNumber(value);
              //       setState(() {
              //         enableButton = false;
              //       });
              //       if (isValid == 'valid') {
              //         setState(() {
              //           DialogService()
              //               .getSnackBar(context, ' valid ', Colors.lightGreen);
              //           enableSubmitButton();
              //         });
              //       } else {
              //         DialogService().getSnackBar(
              //           context,
              //           isValid,
              //           Colors.red,
              //         );
              //       }
              //       print(value);
              //     },
              //     selectorConfig: SelectorConfig(
              //       selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              //       backgroundColor: Colors.white,
              //     ),

              //     ignoreBlank: false,
              //     autoValidateMode: AutovalidateMode.disabled,
              //     selectorTextStyle: TextStyle(color: Colors.black),
              //     initialValue: number,
              //     textFieldController: mobileNumber,
              //     inputBorder: OutlineInputBorder(),
              //   ),
              // ),
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
                            'You are about to Sub $phoneNumber with $packageName for ${nairaAmount.text}',
                        text1: !isNairaWallet
                            ? 'Exchange rate \$1 \~ $nairaRate1'
                            : 'Exchange rate \$1 \~ $nairaRate',
                        userItem: account,
                        userItem1: user['userName'],
                        userItem2: user['email'],
                        biller: biller,
                        product: packageName,
                        reference: phoneNumber,
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
                              if (isSmile) {
                                _progressDialog.show();
                                dynamic result =
                                    await SmileAndSpectranetPayment()
                                        .sendSmileData(phoneNumber,
                                            nairaAmount.text, productCode);
                                if (result['status'] = true) {
                                  dynamic rep = result['message'].toString();
                                  print(rep.toString());
                                  dynamic name = json.decode(rep);
                                  dynamic me = name['description'];
                                  print(me);

                                  if (name['code'] != 'ERR101' &&
                                      name['code'] != 'ERR102' &&
                                      name['code'] != 'ERR103' &&
                                      name['code'] != 'ERR104' &&
                                      name['code'] != 'ERR105' &&
                                      name['code'] != 'ERR106' &&
                                      name['code'] != 'ERR107' &&
                                      name['code'] != 'ERR202' &&
                                      name['code'] != 'ERR206' &&
                                      name['code'] != 'ERR208') {
                                    dynamic response = name['details'];
                                    // serialNumber = response['serial_number'];
                                    // pin = response['pin'];
                                    // expiaryDate = response['expiresOn'];
                                    // print(name['status'].toString());
                                    print(response);

                                    dynamic nairaBalance =
                                        double.parse(balance) - naira;
                                    dynamic result1 = await AuthService()
                                        .updateWallet(
                                            nairaBalance.toString(), 'naira');
                                    if (result1['status']) {
                                      dynamic result2 = await AuthService()
                                          .updateTransactionList(
                                              "Smile data purchase",
                                              'Naira Wallet',
                                              '$packageName smartno: $phoneNumber',
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
                                                    ' Smile data purchase was successful',
                                                text1:
                                                    'You\'ve successfully Subscribed your $biller $phoneNumber  with  \₦${nairaAmount.text}',
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
                                    print(name['description'].toString());
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
                              } else if (isSpectranet) {
                                _progressDialog.show();
                                dynamic result =
                                    await SmileAndSpectranetPayment()
                                        .sendSpectranetData(
                                            nairaAmount.text, productCode);

                                if (result['status'] = true) {
                                  dynamic rep = result['message'].toString();
                                  print(rep.toString());
                                  dynamic name = json.decode(rep);
                                  dynamic me = name['description'];
                                  print(me);

                                  if (name['code'] != 'ERR101' &&
                                      name['code'] != 'ERR102' &&
                                      name['code'] != 'ERR103' &&
                                      name['code'] != 'ERR104' &&
                                      name['code'] != 'ERR105' &&
                                      name['code'] != 'ERR106' &&
                                      name['code'] != 'ERR107' &&
                                      name['code'] != 'ERR202' &&
                                      name['code'] != 'ERR206' &&
                                      name['code'] != 'ERR208') {
                                    dynamic response = name['details']['pins'];
                                    serialNumber = response['serial_number'];
                                    pin = response['pin'];
                                    expiaryDate = response['expiresOn'];
                                    // print(name['status'].toString());
                                    print(response);

                                    dynamic nairaBalance =
                                        double.parse(balance) - naira;
                                    dynamic result1 = await AuthService()
                                        .updateWallet(
                                            nairaBalance.toString(), 'naira');
                                    if (result1['status']) {
                                      dynamic result2 = await AuthService()
                                          .updateTransactionList(
                                              "Spectranet data purchase",
                                              'Naira Wallet',
                                              '$biller package: $packageName pin: $pin',
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
                                                    'Spectranet data purchase was successful',
                                                text1:
                                                    'You\'ve successfully payed for  $packageName  with  \₦${nairaAmount.text}',
                                                text2:
                                                    '( serial_number: $serialNumber, pin: $pin, expiresOn: $expiaryDate) ',
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
                                    print(name['description'].toString());
                                    Fluttertoast.showToast(
                                        msg:'error occurred try again',
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
                              } else {
                                _progressDialog.show();
                                dynamic result = await SendData()
                                    .sendData(dataPlan, phoneNumber, code);

                                if (result['status'] = true) {
                                  dynamic rep = result['message'].toString();
                                  dynamic name = json.decode(rep);

                                  if (name['status'] == 'ORDER_RECEIVED') {
                                    print(name['status'].toString());

                                    dynamic nairaBalance =
                                        double.parse(balance) - naira;
                                    dynamic result1 = await AuthService()
                                        .updateWallet(
                                            nairaBalance.toString(), 'naira');
                                    if (result1['status']) {
                                      dynamic result2 = await AuthService()
                                          .updateTransactionList(
                                              "Data purchase",
                                              'Naira Wallet',
                                              '$biller mobile: $phoneNumber',
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
                                                    'Data purchase was successful',
                                                text1:
                                                    'You\'ve successfully Subscribed $phoneNumber  with  \₦${nairaAmount.text}',
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






                               if (isSmile) {
                                _progressDialog.show();
                                dynamic result =
                                    await SmileAndSpectranetPayment()
                                        .sendSmileData(phoneNumber,
                                            nairaAmount.text, productCode);
                                if (result['status'] = true) {
                                  dynamic rep = result['message'].toString();
                                  print(rep.toString());
                                  dynamic name = json.decode(rep);
                                  dynamic me = name['description'];
                                  print(me);

                                  if (name['code'] != 'ERR101' &&
                                      name['code'] != 'ERR102' &&
                                      name['code'] != 'ERR103' &&
                                      name['code'] != 'ERR104' &&
                                      name['code'] != 'ERR105' &&
                                      name['code'] != 'ERR106' &&
                                      name['code'] != 'ERR107' &&
                                      name['code'] != 'ERR202' &&
                                      name['code'] != 'ERR206' &&
                                      name['code'] != 'ERR208') {
                                    dynamic response = name['details'];
                                    // serialNumber = response['serial_number'];
                                    // pin = response['pin'];
                                    // expiaryDate = response['expiresOn'];
                                    // print(name['status'].toString());
                                    print(response);

                                    dynamic nairaBalance =
                                        double.parse(balance) - naira;
                                    dynamic result1 = await AuthService()
                                        .updateWallet(
                                            nairaBalance.toString(), 'naira');
                                    if (result1['status']) {
                                      dynamic result2 = await AuthService()
                                          .updateTransactionList(
                                              "Smile data purchase",
                                              'Naira Wallet',
                                              '$packageName smartno: $phoneNumber',
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
                                                    ' Smile data purchase was successful',
                                                text1:
                                                    'You\'ve successfully Subscribed your $biller $phoneNumber  with  \₦${nairaAmount.text}',
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
                                    print(name['description'].toString());
                                    Fluttertoast.showToast(
                                        msg: 'error occurred try again ',
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
                              } else if (isSpectranet) {
                                _progressDialog.show();
                                dynamic result =
                                    await SmileAndSpectranetPayment()
                                        .sendSpectranetData(
                                            nairaAmount.text, productCode);

                                if (result['status'] = true) {
                                  dynamic rep = result['message'].toString();
                                  print(rep.toString());
                                  dynamic name = json.decode(rep);
                                  dynamic me = name['description'];
                                  print(me);

                                  if (name['code'] != 'ERR101' &&
                                      name['code'] != 'ERR102' &&
                                      name['code'] != 'ERR103' &&
                                      name['code'] != 'ERR104' &&
                                      name['code'] != 'ERR105' &&
                                      name['code'] != 'ERR106' &&
                                      name['code'] != 'ERR107' &&
                                      name['code'] != 'ERR202' &&
                                      name['code'] != 'ERR206' &&
                                      name['code'] != 'ERR208') {
                                    dynamic response = name['details']['pins'];
                                    serialNumber = response['serial_number'];
                                    pin = response['pin'];
                                    expiaryDate = response['expiresOn'];
                                    // print(name['status'].toString());
                                    print(response);

                                    dynamic nairaBalance =
                                        double.parse(balance) - naira;
                                    dynamic result1 = await AuthService()
                                        .updateWallet(
                                            nairaBalance.toString(), 'naira');
                                    if (result1['status']) {
                                      dynamic result2 = await AuthService()
                                          .updateTransactionList(
                                              "Spectranet data purchase",
                                              'Naira Wallet',
                                              '$biller, package: $packageName pin: $pin',
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
                                                    'Spectranet data purchase was successful',
                                                text1:
                                                    'You\'ve successfully payed for  $packageName  with  \₦${nairaAmount.text}',
                                                text2:
                                                    '( serial_number: $serialNumber, pin: $pin, expiresOn: $expiaryDate) ',
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
                                    print(name['description'].toString());
                                    Fluttertoast.showToast(
                                        msg: 'error occcurred try again',
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
                              } else {
                                _progressDialog.show();
                                dynamic result = await SendData()
                                    .sendData(dataPlan, phoneNumber, code);

                                if (result['status'] = true) {
                                  dynamic rep = result['message'].toString();
                                  dynamic name = json.decode(rep);

                                  if (name['status'] == 'ORDER_COMPLETED') {
                                    print(name['status'].toString());
                                    dynamic coinBalance =
                                        double.parse(balance) - coin;
                                    dynamic response = await AuthService()
                                        .updateWallet(
                                            coinBalance.toString(), symbol1);
                                    if (response['status']) {
                                      dynamic response1 = await AuthService()
                                          .updateTransactionList(
                                              'Data purchase',
                                              '$symbol1 Wallet',
                                              '$biller mobile: $phoneNumber',
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
                                                    'Data purchase was successful',
                                                text1:
                                                    'You\'ve successfully Subscribed $phoneNumber  with  \₦${nairaAmount.text}',
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
                                            msg:
                                                response1['message'].toString(),
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
