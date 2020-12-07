import 'dart:convert';

import 'package:Crypto_wallet/services/aaccount_validator.dart';
import 'package:Crypto_wallet/services/auth.dart';
import 'package:Crypto_wallet/services/validator.dart';
import 'package:Crypto_wallet/shared/app_colors.dart';
import 'package:Crypto_wallet/widgets/drop_down_input_field.dart';
import 'package:Crypto_wallet/widgets/outlined_number_input_field.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final List banks = [
    {'name': 'Access Bank Plc', 'code': '044'},
    {'name': 'Citibank Nigeria Limited', 'code': '023'},
    {'name': 'Coronation Merchant Bank[6]', 'code': '559'},
    {'name': 'Ecobank Nigeria Plc', 'code': '050'},
    {'name': 'Fidelity Bank Plc', 'code': '070'},
    {'name': 'First City Monument Bank Limited', 'code': '214'},
    {'name': 'First Bank of Nigeria Limited', 'code': '011'},
    {'name': 'FSDH Merchant Bank[8]', 'code': '601'},
    {'name': 'Guaranty Trust Bank Plc', 'code': '058'},
    {'name': 'Heritage Banking Company Limited', 'code': '030'},
    {'name': 'Jaiz Bank Plc', 'code': '301'},
    {'name': 'Keystone Bank Limited', 'code': '082'},
    {'name': 'Polaris Bank Limited', 'code': '076'},
    // 'Providus Bank Limited',
    // 'Rand Merchant Bank',
    {'name': 'Stanbic IBTC Bank Plc', 'code': '304'},
    {'name': 'Standard Chartered', 'code': '068'},
    {'name': 'Sterling Bank Plc', 'code': '232'},
    {'name': 'SunTrust Bank Nigeria Limited', 'code': '100'},
    // {'name':'Titan Trust Bank Limited','code': '100'},
    // {'name':'TAJBank Limited[4][5]','code': '100'},
    {'name': 'Union Bank of Nigeria Plc', 'code': '032'},
    {'name': 'United Bank for Africa', 'code': '033'},
    {'name': 'Unity Bank Plc', 'code': '215'},
    {'name': 'Wema Bank Plc Bank Limited[3]', 'code': '035'},
    {'name': 'ZENITH BANK PLC', 'code': '057'},
  ];

  dynamic bankName;
  dynamic code;

  final _formKey = GlobalKey<FormState>();
  String userName, mobile, firstName, lastName, accountNumber, bank;
  // accountName;
  final accountName = TextEditingController();

  dynamic _auth = AuthService();
  bool _loader = false;
  Color color = yellowStart;
  bool isValidating = false;
  bool isAccountNumber = false;
  bool enableButton = false;
  bool accountIsNull = false;

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

  dynamic accountname;
  validate() async {
    // setState(() {
    //   isValidating = false;
    // });
    enableButton = false;
    accountName.clear();
    accountIsNull = false;

    if (accountNumber.length < 10 && bank.isEmpty) {
    } else {
      setState(() {
        isValidating = true;
        enableButton = false;
      });
      print(code);

      dynamic result = await AccountValidator()
          .validateAccount(accountNumber, code.toString());
      // print('anything form me${result.toString()}');
      dynamic account = result['message'];
      dynamic name = json.decode(account);
      accountname = await name['data']['data']['accountname'];
      print('this is the $accountname');
      if (accountname == null) {
        setState(() {
          accountIsNull = true;
          isValidating = false;
          enableButton = false;
        });
      } else {
        setState(() {
          accountIsNull = false;
          accountName.text = accountname;
          isValidating = false;
          enableButton = true;
        });
        print(accountName.text);
      }

      setState(() {
        isValidating = false;
      });

      return result;
    }
  }

  void enableSubmitButton() {
    // final enteredName = accountName.text;
    String accountnumber = Validators.accountNumber(accountNumber);
    String accountBank = Validators.bankName(code);
    String firstname = Validators.firstName(firstName);
    String lastname = Validators.lastName(lastName);
    String phoneNumber = Validators.mobile(mobile);
    dynamic name = Validators.accountName(accountname);
    print('am in enable submit button ${accountName.text}');
    if ((accountnumber == null) &&
        (accountBank == null) &&
        (firstname == null) &&
        (lastname == null) &&
        (phoneNumber == null)
        // &&(  !accountIsNull )
        &&
        (name == null)) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Set up'),),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,

              children: [
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Account Setup',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                SizedBox(height: 40),
                Text('You have a step to start your Exchange',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                    )),
                SizedBox(height: 60),
                OutlinedNumberInputField(
                  label: 'fist name',
                  press: (value) {
                    firstName = value;
                    String isValid = Validators.firstName(value);
                    setState(() {
                      enableButton = false;
                    });
                    if (isValid == null) {
                      setState(() {
                        getSnackBar(' valid ', Colors.lightGreen);
                        enableSubmitButton();
                      });
                    } else {
                      getSnackBar(
                        isValid,
                        Colors.red,
                      );
                    }
                  },
                  isNumberType: false,
                ),
                SizedBox(
                  height: 20,
                ),
                OutlinedNumberInputField(
                  label: 'Last name',
                  press: (value) {
                    lastName = value;
                    String isValid = Validators.lastName(value);
                    setState(() {
                      enableButton = false;
                    });
                    if (isValid == null) {
                      setState(() {
                        getSnackBar(' valid ', Colors.lightGreen);
                        enableSubmitButton();
                      });
                    } else {
                      getSnackBar(
                        isValid,
                        Colors.red,
                      );
                    }
                  },
                  isNumberType: false,
                ),
                SizedBox(
                  height: 20,
                ),
                OutlinedNumberInputField(
                  label: 'Mobile',
                  press: (value) {
                    mobile = value;
                    String isValid = Validators.mobile(value);
                    setState(() {
                      enableButton = false;
                    });
                    if (isValid == null) {
                      setState(() {
                        getSnackBar(' valid ', Colors.lightGreen);
                        enableSubmitButton();
                      });
                    } else {
                      getSnackBar(
                        isValid,
                        Colors.red,
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Account Details',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: !accountIsNull ? false : true,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 17),
                    child: Text(
                      ' Could not resolve account, check the account and try again',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Focus(
                  child: OutlinedNumberInputField(
                    text: Container(
                      height: 1,
                      width: 1,
                      padding: EdgeInsets.all(10),
                      child: Visibility(
                          visible: !isValidating ? false : true,
                          child: SizedBox(
                              height: 1,
                              width: 1,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                              ))),
                    ),
                    isNumberType: true,
                    label: 'Enter Account Number',
                    press: (value) {
                      accountNumber = value;
                      String isValid = Validators.accountNumber(value);
                      String isValid1 = Validators.bankName(code);
                      setState(() {
                        enableButton = false;
                      });
                      if (isValid == null && isValid1 == null) {
                        validate();
                        setState(() {
                          getSnackBar('valid', Colors.lightGreen);
                          enableSubmitButton();
                        });
                      } else {
                        getSnackBar(
                          isValid,
                          Colors.red,
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Focus(
                  // getBankName(),
                  child: DropDownInputField(
                    hintText: "Select Bank",
                    options: banks,
                    bankName: bankName.toString(),
                    onChanged: (value) async {
                      print('this is the value $value');
                      bank = value.toLowerCase();
                      banks.forEach((element) {
                        if (value == element['name'].toString()) {
                          code = element['code'].toString();
                          print('this is the code $code');
                        }
                      });

                      String isValid = Validators.bankName(code);
                      String isValid1 = Validators.accountNumber(accountNumber);

                      setState(() {
                        enableButton = false;
                      });
                      if (isValid == null && isValid1 == null) {
                        validate();

                        setState(() {
                          getSnackBar(' valid ', Colors.lightGreen);
                          enableSubmitButton();
                        });
                      } else {
                        getSnackBar(
                          isValid,
                          Colors.red,
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                OutlinedNumberInputField(
                  enabled: false,
                  // press: (value) {
                  //   dynamic isValid;
                  //   setState(() {
                  //     accountname = value.toLowerCase();
                  //     isValid = Validators.accountName(value);
                  //   });
                  //   setState(() {
                  //     enableButton = false;
                  //   });
                  //   if (accountname == null) {
                  //     enableSubmitButton();
                  //     setState(() {
                  //       getSnackBar(' account name must not be empty ',
                  //           Colors.lightGreen);
                  //     });
                  //   } else {
                  //     getSnackBar(
                  //       isValid,
                  //       Colors.red,
                  //     );
                  //   }
                  // },
                  controller: accountName,
                  label: 'Account Name',
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  child: !_loader
                      ? Container(
                          margin: EdgeInsets.all(30),
                          child: RaisedButton(
                            // color: yellowStart,
                            onPressed: !enableButton
                                ? null
                                : () async {
                                    // if (_formKey.currentState.validate()) {
                                    setState(() {
                                      _loader = true;
                                    });
                                    userName = "$firstName $lastName";
                                    Map<String, dynamic> usersDetails = {
                                      'userName': userName,
                                      'mobile': mobile,
                                      'bankAccountNumber': accountNumber,
                                      'bankName': bank.toString(),
                                      'bankAccountName': accountName.text,
                                      'BTC': '0.00',
                                      'ETH': '0.00',
                                      'XRP': '0.00',
                                      'BCH': '0.00',
                                      'LTC': '0.00',
                                      'TRX': '0.00',
                                      'naira': '0.00',
                                    };
                                    Map result =
                                        await _auth.saveDetails(usersDetails);
                                    if (mounted) {
                                      setState(() {
                                        _loader = false;
                                      });
                                    }
                                    if (result['status']) {
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          'tab_screen', (route) => false);
                                      getSnackBar(
                                          'information saved successfully',
                                          Colors.green);
                                    } else {
                                      getSnackBar(
                                        result['message'],
                                        Colors.red,
                                      );
                                    }
                                  },
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            color: color,
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(
                                color: color,
                              ),
                            ),
                            disabledColor: Colors.grey,
                            // },
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
