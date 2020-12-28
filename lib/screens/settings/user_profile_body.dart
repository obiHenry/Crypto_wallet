import 'package:Crypto_wallet/services/auth.dart';
import 'package:Crypto_wallet/services/dialog_service.dart';
import 'package:Crypto_wallet/services/internet_connection.dart';
import 'package:Crypto_wallet/services/validator.dart';
import 'package:Crypto_wallet/shared/rounded_button.dart';
import 'package:Crypto_wallet/shared/rounded_input_field.dart';
import 'package:Crypto_wallet/shared/rounded_password_field.dart';
import 'package:Crypto_wallet/widgets/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  String currentPassword = '';
  String newPassword = '';
  String confirmPassword = '';
  String type = 'alnum';
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
                  measurementSettings(),
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
            isValid = Validators.alnum(value, "Contact name");
            if (value.isNotEmpty) {
              isValid = "Contact name is required";
            } else {
              isValid = null;
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

  Widget measurementSettings() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 20),
        Text(
          "Account Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        RoundedButton(
          press: () async {
            if (user.containsKey('gender') && user['gender'] != null) {
              final result = await Navigator.pushNamed(context, '/measurement',
                  arguments: {
                    'user': user,
                    'inCheckout': false,
                  });
              if (result != null && result is String) {
                setState(() {
                  user['shoulder'] = result;
                });
                dialog.getSnackBar(
                    context, 'Measurements updated successfully', Colors.green);
              }
            } else {
              dialog.getSnackBar(context,
                  'You have to fill in your details first', kPrimaryColor);
            }
          },
          text: 'EDIT MEASUREMENT',
        ),
      ],
    );
  }
}
