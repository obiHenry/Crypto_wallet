import 'package:Crypto_wallet/services/auth.dart';
import 'package:Crypto_wallet/services/dialog_service.dart';
import 'package:Crypto_wallet/services/internet_connection.dart';
import 'package:Crypto_wallet/services/validator.dart';
import 'package:Crypto_wallet/shared/rounded_button.dart';
import 'package:Crypto_wallet/shared/rounded_field.dart';
import 'package:Crypto_wallet/shared/rounded_drop_down.dart';
import 'package:Crypto_wallet/shared/rounded_input_field.dart';
import 'package:Crypto_wallet/shared/rounded_password_field.dart';
import 'package:Crypto_wallet/shared/constants.dart';
import 'package:Crypto_wallet/services/aaccount_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class UserProfileBody extends StatefulWidget {
  @override
  _UserProfileBodyState createState() => _UserProfileBodyState();
}

class _UserProfileBodyState extends State<UserProfileBody> {
  Map user;
  dynamic _auth;
  final DialogService dialog = DialogService();
  bool _loader = false;
  bool _passwordLoader = false;
  bool _loading = true;
  bool _isConnected = true;
  bool enableButton = false;
  bool enablePasswordButton = false;
  bool enableBankAccountButton = false;
  String currentPassword = '';
  String newPassword = '';
  String confirmPassword = '';
  String type = 'alnum';
  bool isValidating = false;
  bool isAccountNumber = false;
  bool accountIsNull = false;
  String accountNumber, bank;
  dynamic code, accountname;
  String bankName;
  bool isChanged = false;
  // accountName;
  final accountName = TextEditingController();

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
  // List<String> genders = ['Male', 'Female'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _auth = kIsWeb
      // ? Provider.of<AuthWebService>(context, listen: false)
      // :
      _auth = Provider.of<AuthService>(context, listen: false);

      if (_auth.userData == null) {
        checkInternet().then((value) {
          if (value) {
            _auth.getUserDataById().then((value) {
              if (mounted) {
                setState(() {
                  user = value;
                  _loading = false;
                  accountName.text = user['bankAccountName'] != null
                      ? user['bankAccountName']
                      : '';
                });
                enableSubmitButton();
              }
            });
          } else {
            if (mounted) {
              setState(() {
                _isConnected = false;
              });
            }
          }
        });
      } else {
        if (mounted) {
          setState(() {
            user = _auth.userData;
            _loading = false;
          });
          enableSubmitButton();
        }
      }
    });
  }

  void enableSubmitButton({String from = 'contact'}) {
    if (from == 'contact') {
      String name = Validators.alnum(
          user['userName'] != null ? user['userName'] : '', 'Name');
      String phone =
          Validators.phone(user['mobile'] != null ? user['mobile'] : '');
      if ((name == null) && (phone == null)) {
        setState(() {
          enableButton = true;
        });
      } else {
        setState(() {
          enableButton = false;
        });
      }
    } else if (from == 'password') {
      String currPwd = Validators.password(currentPassword);
      String newPwd = Validators.password(newPassword);
      String cfmPwd = Validators.password(confirmPassword);

      if ((currPwd == null) && (newPwd == null) && (cfmPwd == null)) {
        setState(() {
          enablePasswordButton = true;
        });
      } else {
        setState(() {
          enablePasswordButton = false;
        });
      }
    } else if (from == 'bank account') {
      String accountnumber =
          Validators.accountNumber(user['bankAccountNumber']);
      String accountBank = Validators.bankName(code);
      if ((accountnumber == null) && (accountBank == null)) {
        setState(() {
          enableBankAccountButton = true;
        });
      } else {
        setState(() {
          enableBankAccountButton = false;
        });
      }
    }
  }

  validate() async {
    // setState(() {
    //   isValidating = false;
    // });
    enableBankAccountButton = false;
    accountName.clear();
    accountIsNull = false;

    if (user['bankAccountNumber'].length == 10 && user['bankName'] != null) {
      // } else {
      setState(() {
        isValidating = true;
        enableBankAccountButton = false;
      });
      print(code);

      dynamic result = await AccountValidator()
          .validateAccount(user['bankAccountNumber'], code.toString());
      // print('anything form me${result.toString()}');
      dynamic account = result['message'];
      dynamic name = json.decode(account);
      print(name.toString());
      accountname = await name['data']['data']['accountname'];
      print('this is the $accountname');
      if (accountname == null) {
        setState(() {
          accountIsNull = true;
          isValidating = false;
          enableBankAccountButton = false;
        });
      } else {
        setState(() {
          accountIsNull = false;
          accountName.text = accountname;
          isValidating = false;
          enableBankAccountButton = true;
        });
        print(accountName.text);
      }

      setState(() {
        isValidating = false;
      });

      return result;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return !_loading
        ? SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  contactSettings(),
                  Divider(
                    color: kPrimaryColor,
                    indent: size.width * 0.3 - 80,
                    endIndent: size.width * 0.3 - 80,
                  ),
                  SizedBox(height: 20),
                  passwordSettings(),
                  Divider(
                    color: kPrimaryColor,
                    indent: size.width * 0.3 - 80,
                    endIndent: size.width * 0.3 - 80,
                  ),
                  SizedBox(height: 20),
                  bankAccountSettings(),
                ],
              ),
            ),
          )
        : RefreshIndicator(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height * .875,
                child: showLoader(_isConnected),
              ),
            ),
            onRefresh: () async {
              if (await checkInternet()) {
                Map user = await _auth.getUserDataById();
                if (mounted) {
                  setState(() {
                    user = user;
                    _loading = false;
                  });
                }
              } else if (mounted) {
                setState(() {
                  _isConnected = false;
                });
              }
            });
  }

  Widget contactSettings() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 20),
        Text(
          "Edit your details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        RoundedInputField(
          validator: (value) {
            String isValid;
            switch (type = 'alnum') {
              case 'alnum':
                isValid = Validators.alnum(value, "Contact name");
                break;
              default:
                isValid = value.isNotEmpty ? null : "Contact name is required";
            }

            return isValid;
          },
          hintText: "Contact name",
          initialValue: user['userName'] != null ? user['userName'] : '',
          onChanged: (value) {
            user['userName'] = value;
            String isValid = Validators.alnum(value, 'Name');
            setState(() {
              enableButton = false;
            });
            if (isValid == null) {
              enableSubmitButton();
            } else {
              dialog.getSnackBar(context, isValid, Colors.red);
            }
          },
        ),
        RoundedInputField(
          validator: (value) {
            String isValid;
            switch (type = 'phone') {
              case 'phone':
                isValid = Validators.phone(value);
                break;
              default:
                isValid = value.isNotEmpty ? null : "Phone number is required";
            }
            return isValid;
          },
          hintText: "Phone number",
          initialValue: user['mobile'] != null ? user['mobile'] : '',
          icon: Icons.phone,
          onChanged: (value) {
            user['mobile'] = value;
            String isValid = Validators.phone(value);
            setState(() {
              enableButton = false;
            });
            if (isValid == null) {
              enableSubmitButton();
            } else {
              dialog.getSnackBar(context, isValid, Colors.red);
            }
          },
        ),
        // RoundedSelectField(
        //   hintText: user['gender'] != null ? user['gender'] : 'Gender',
        //   options: genders,
        //   disabledHint: user['gender'] != null ? user['gender'] : 'disabled',
        //   onChanged: user.containsKey('shoulder')
        //       ? null
        //       : (value) {
        //           user['gender'] = value.toLowerCase();
        //           String isValid = Validators.alnum(value, 'Gender');
        //           setState(() {
        //             enableButton = false;
        //           });
        //           if (isValid == null) {
        //             enableSubmitButton();
        //           }
        //         },
        // ),
        // SizedBox(height: 20),
        // Text(
        //   'Billing Address',
        //   textAlign: TextAlign.left,
        // ),
        // // RoundedInputField(
        // //   validator: ,
        // //   hintText: "Street Address",
        // //   initialValue: user['street'] != null ? user['street'] : '',
        // //   icon: Icons.gps_fixed,
        // //   onChanged: (value) {
        // //     user['street'] = value;
        // //     String isValid = Validators.alnum(value, 'Street address');
        // //     setState(() {
        // //       enableButton = false;
        // //     });
        // //     if (isValid == null) {
        // //       enableSubmitButton();
        // //     } else {
        // //       dialog.getSnackBar(context, isValid, Colors.red);
        // //     }
        // //   },
        // // ),
        // // RoundedInputField(
        // //   hintText: "City",
        // //   initialValue: user['city'] != null ? user['city'] : '',
        // //   icon: Icons.gps_fixed,
        // //   onChanged: (value) {
        // //     user['city'] = value;
        // //     String isValid = Validators.alnum(value, 'City');
        // //     setState(() {
        // //       enableButton = false;
        // //     });
        // //     if (isValid == null) {
        // //       enableSubmitButton();
        // //     } else {
        // //       dialog.getSnackBar(context, isValid, Colors.red);
        // //     }
        // //   },
        // // ),
        // // RoundedSelectField(
        // //   hintText: "State",
        // //   valueText: user['state'] != null ? user['state'] : null,
        // //   options: states,
        // //   icon: Icons.gps_fixed,
        // //   onChanged: (value) {
        // //     user['state'] = value.toLowerCase();
        // //     String isValid = Validators.alnum(value, 'State');
        // //     setState(() {
        // //       enableButton = false;
        // //     });
        // //     if (isValid == null) {
        // //       enableSubmitButton();
        // //     } else {
        // //       dialog.getSnackBar(context, isValid, Colors.red);
        // //     }
        // //   },
        // // ),
        !_loader
            ? RoundedButton(
                text: "UPDATE",
                press: !enableButton
                    ? null
                    : () async {
                        setState(() {
                          _loader = true;
                        });
                        dynamic result = await _auth.saveDetails(user);
                        setState(() {
                          _loader = false;
                        });
                        if (result['status']) {
                          dialog.getSnackBar(
                              context, 'User data updated', Colors.green);
                        } else {
                          dialog.getSnackBar(
                              context, result['message'], Colors.red);
                        }
                      },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget passwordSettings() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 20),
        Text(
          "Change your password",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        RoundedPasswordField(
          hintText: "Current Password",
          onChanged: (value) {
            currentPassword = value;
            String isValid = Validators.password(value);
            setState(() {
              enablePasswordButton = false;
            });
            if (isValid == null) {
              enableSubmitButton(from: 'password');
              dialog.getSnackBar(
                  context, 'This is a valid password', Colors.green);
            } else {
              dialog.getSnackBar(context, isValid, Colors.red);
            }
          },
        ),
        RoundedPasswordField(
          hintText: "New Password",
          onChanged: (value) {
            newPassword = value;
            String isValid = Validators.password(value);
            setState(() {
              enablePasswordButton = false;
            });
            if (isValid == null) {
              if (newPassword == confirmPassword) {
                enableSubmitButton(from: 'password');
                dialog.getSnackBar(context, 'Passwords okay', Colors.green);
              } else {
                if (confirmPassword.isNotEmpty) {
                  dialog.getSnackBar(
                      context, 'Passwords do not match', Colors.red);
                } else {
                  dialog.getSnackBar(
                      context, 'This is a valid password', Colors.green);
                }
              }
            } else {
              dialog.getSnackBar(context, isValid, Colors.red);
            }
          },
        ),
        RoundedPasswordField(
          hintText: "Confirm Password",
          onChanged: (value) {
            confirmPassword = value;
            String isValid = Validators.password(value);
            setState(() {
              enablePasswordButton = false;
            });
            if (isValid == null) {
              if (newPassword == confirmPassword) {
                enableSubmitButton(from: 'password');
                dialog.getSnackBar(context, 'Passwords okay', Colors.green);
              } else {
                if (newPassword.isNotEmpty) {
                  dialog.getSnackBar(
                      context, 'Passwords do not match', Colors.red);
                } else {
                  dialog.getSnackBar(
                      context, 'This is a valid password', Colors.green);
                }
              }
            } else {
              dialog.getSnackBar(context, isValid, Colors.red);
            }
          },
        ),
        !_passwordLoader
            ? RoundedButton(
                text: "CHANGE PASSWORD",
                press: !enablePasswordButton
                    ? null
                    : () async {
                        setState(() {
                          _passwordLoader = true;
                        });
                        dynamic result = await _auth.changePassword(
                            user['email'],
                            currentPassword,
                            newPassword,
                            confirmPassword);
                        setState(() {
                          _passwordLoader = false;
                        });
                        if (result['status']) {
                          dialog.getSnackBar(
                              context, result['message'], Colors.green);
                        } else {
                          dialog.getSnackBar(
                              context, result['message'], Colors.red);
                        }
                      },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget bankAccountSettings() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 20),
        Text(
          "Account Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
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
          child: RoundedField(
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
            hintText: 'Account Number',
            initialValue: user['bankAccountNumber'] != null
                ? user['bankAccountNumber']
                : '',
            press: (value) {
              user['bankAccountNumber'] = value;
              String isValid = Validators.accountNumber(value);
              String isValid1 = Validators.bankName(code);
              setState(() {
                enableBankAccountButton = false;
              });
              if (isValid == null && isValid1 == null) {
                validate();
                setState(() {
                  dialog.getSnackBar(context, 'valid', Colors.lightGreen);
                  enableSubmitButton(from: 'bank account');
                });
              } else {
                dialog.getSnackBar(
                  context,
                  isValid,
                  Colors.red,
                );
              }
            },
          ),
        ),
        Focus(
          // getBankName(),
          child: RoundedDropDown(
            hintText: user['bankName'] != null ? user['bankName'] : '',
            options: banks,
            valueText1: isChanged ? bankName : user['bankName'],

            // valueText: user['bankName'] != null
            // ? user['bankName']
            // : '',
            // bankName: bankName.toString(),
            onChanged: (value) async {
              setState(() {
                isChanged = true;
              });
              print('this is the value $value');
              user['bankName'] = value.toLowerCase();
              banks.forEach((element) {
                bankName = element['name'].toString();
                if (value == element['name'].toString()) {
                  code = element['code'].toString();
                  print('this is the code $code');
                }
              });

              String isValid = Validators.bankName(code);
              String isValid1 =
                  Validators.accountNumber(user['bankAccountNumber']);

              setState(() {
                enableBankAccountButton = false;
              });
              if (isValid == null && isValid1 == null) {
                validate();

                setState(() {
                  dialog.getSnackBar(context, ' valid ', Colors.lightGreen);
                  enableSubmitButton(from: 'bank account');
                });
              } else {
                dialog.getSnackBar(
                  context,
                  isValid,
                  Colors.red,
                );
              }
            },
          ),
        ),
        RoundedField(
          // initialValue:  user['bankAccountName'] != null
          //       ? user['bankAccountName']
          //       : '',
          press: (value) {
            user['bankAccountName'] = value;
          },
          hintText: 'Account Name',
          enabled: false,
          controller: accountName,
          // label: 'Account Name',
        ),
        SizedBox(
          height: 10,
        ),
       !_loader
            ?  RoundedButton(
          press: !enableBankAccountButton
              ? null
              : () async {
                  setState(() {
                    _loader = true;
                  });
                  dynamic result = await _auth.saveDetails(user);
                  setState(() {
                    _loader = false;
                  });
                  if (result['status']) {
                    dialog.getSnackBar(
                        context, 'User data updated', Colors.green);
                  } else {
                    dialog.getSnackBar(context, result['message'], Colors.red);
                  }
                },
          text: 'UPDATE ACCOUNT DETAILS',
        ): Center(
          child:  CircularProgressIndicator(),
        ),
      ],
    );
  }
}
