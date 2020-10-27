import 'package:Crypto_wallet/services/auth.dart';
import 'package:Crypto_wallet/widgets/outlined_number_input_field.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  String userName, mobile;

  dynamic _auth = AuthService();
  bool _loader = false;
  Color color = Colors.blue;

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
                SizedBox(height: 60),
                Text('You have a step to start your Exchange',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    )),
                SizedBox(height: 60),
                OutlinedNumberInputField(
                  label: 'User name',
                  press: (value) {
                    userName = value;
                    
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
                  },
                  isNumberType: true,
                ),
                SizedBox(
                  height: 20,
                ),
                OutlinedNumberInputField(
                  label: 'User name',
                  press: (value) {},
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  child: !_loader
                      ? RaisedButton(
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
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                _loader = true;
                              });
                              Map<String, dynamic> usersDetails = {
                                'userName': userName,
                                'mobile': mobile,
                                'btc': '0',
                                'eth': '0',
                                'xrp': '0',
                                'bch': '0',
                                'ltc': '0',
                                'trx': '0',
                                'pax': '0',
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
                                getSnackBar('information saved successfully',
                                    Colors.green);
                              } else {
                                getSnackBar(
                                  result['message'],
                                  Colors.red,
                                );
                              }
                            }
                          },
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
