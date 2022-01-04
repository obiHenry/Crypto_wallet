import 'dart:io';
import 'package:Crypto_wallet/services/auth.dart';
import 'package:Crypto_wallet/services/api_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'currencies_in_naira_card_item.dart';
import 'naira_deposit_wallet.dart';
import 'dart:math';
import 'dart:convert';

class CurrenciesListInNaira extends StatefulWidget {
  final String text;
  final Function press;
  CurrenciesListInNaira({this.text, this.press});
  @override
  _CurrenciesListInNairaState createState() => _CurrenciesListInNairaState();
}

class _CurrenciesListInNairaState extends State<CurrenciesListInNaira> {
  final auth = AuthService();
  var user = FirebaseAuth.instance.currentUser;
  List currencies = [];
  bool _loading = true;
  bool _isConnected = true;
  ApiServices getCurrencies;
  Map<String, bool> loaders = {};
  dynamic naira1, nairaRate;
  dynamic btcBalance;
  dynamic ethBalance;
  dynamic xrpBalance;
  dynamic bchBalance;
  dynamic ltcBalance;
  dynamic trxBalance;
  dynamic btcBal;
  dynamic ethBal;
  dynamic xrpBal;
  dynamic bchBal;
  dynamic ltcBal;
  dynamic trxBal;

  final imageList = [
    'assets/images/btc.png',
    'assets/images/etherium.jpg',
    'assets/images/ripple.png',
    'assets/images/litcoin.jpg',
    'assets/images/bitcoin_cash.png',
    'assets/images/tron.jpg',
  ];

  // final walletName = ['NairaWallet'];
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
  void didChangeDependencies() {
    getCurrencies = Provider.of<ApiServices>(context);
    
    _checkInternet().then((value) {
      if (value) {
        getCurrencies.refreshCurrencies().then((value) async {
          if (mounted) {
            naira1 = await AuthService().getNairaRate();
            dynamic rate = double.parse(naira1['buyRate']);

            nairaRate = (rate).toStringAsFixed(1);
            print(nairaRate);
            setState(() {
              // currencies = nairaWallet;
              currencies = value;
              _loading = false;
              _isConnected = true;
            });
            for (int i = 0; i < currencies.length; i++) {
              loaders[i.toString()] = false;
            }
            print(loaders.toString());
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

    // print('heee $currencies');

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // currencies = Provider.of<GetCurrencies>(context).currencies;

    // print('heeee$currencies');

    return SingleChildScrollView(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          child: Text('Wallets',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: Text(
            widget.text,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: RefreshIndicator(
            child: !_loading
                ? ListView.builder(
                    itemCount:
                        currencies.length == null ? 0 : currencies.length,
                    itemBuilder: (context, index) {
                      final image = imageList[index % imageList.length];
                      // final walletname = walletName[index % walletName.length];
                      return CurrencyInNaraCard(
                        nairaRate: nairaRate,
                        currency: currencies[index],
                        color: image,
                        press: () async {
                          setState(() {
                            loaders[index.toString()] = true;
                          });
                          dynamic users = await auth.getUserDataById();
                          if (user != null) {
                            if (users.containsKey('verified')) {
                              bool verified = users['verified'];
                              if (!verified) {
                                var rnd = new Random();
                                var next = rnd.nextDouble() * 1000000;
                                while (next < 100000) {
                                  next *= 10;
                                }
                                print('rndomnumber ${next.toInt()}');
                                dynamic token = next.toInt();
                                // dynamic userName = users['userName'].toString();
                                String email = users['email'].toString();
                                var userName = email.split('@').take(1);
                                print(userName.toString());
                                dynamic result1 = await ApiServices()
                                    .sendEmailVerificationToken(
                                        userEmail: users['email'],
                                        subject: 'Email address verification',
                                        content:
                                            'Verify your email for Veloce,    Use the code below to verify  your email.   $token ',
                                        userName: userName);
                                if (result1['status']) {
                                  dynamic result2 =
                                      json.decode(result1['message']);

                                  if (result2['status'] == '1') {
                                    print(
                                        'this is the email result ${result1['message'].toString()}');

                                    Navigator.of(context).pushNamed(
                                        'verification_screen',
                                        arguments: {
                                          'email': users['email'],
                                          'token': token.toString(),
                                          'fromExternal': false,
                                        });
                                    setState(() {
                                      loaders[index.toString()] = false;
                                    });
                                  } else {
                                    getSnackBar(result2['response'].toString(),
                                        Colors.red);
                                  }
                                } else {
                                  getSnackBar(result1['message'], Colors.red);
                                }
                              } else {
                                if (users.containsKey('userName')) {
                                  btcBalance = double.parse(users['BTC']);
                                  ethBalance = double.parse(users['ETH']);
                                  xrpBalance = double.parse(users['XRP']);
                                  bchBalance = double.parse(users['BCH']);
                                  ltcBalance = double.parse(users['LTC']);
                                  trxBalance = double.parse(users['TRX']);
                                  btcBal = btcBalance.toStringAsFixed(7);
                                  ethBal = ethBalance.toStringAsFixed(7);
                                  xrpBal = xrpBalance.toStringAsFixed(7);
                                  bchBal = bchBalance.toStringAsFixed(7);
                                  ltcBal = ltcBalance.toStringAsFixed(7);
                                  trxBal = trxBalance.toStringAsFixed(7);

                                  dynamic balanceList = [
                                    btcBal ,
                                    ethBal ,
                                    xrpBal ,
                                    bchBal ,
                                    ltcBal ,
                                    trxBal ,
                                    // users['BTC'].toString(),
                                    // users['ETH'].toString(),
                                    // users['XRP'].toString(),
                                    // users['BCH'].toString(),
                                    // users['LTC'].toString(),
                                    // users['TRX'].toString(),
                                  ];

                                  final balance =
                                      balanceList[index % balanceList.length];

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CoinDepositWallet(
                                        currency: currencies[index],
                                        image: image,
                                        coinBalance: balance,
                                        user: users,
                                        nairaRate: nairaRate,
                                      ),
                                    ),
                                  );
                                  setState(() {
                                    loaders[index.toString()] = false;
                                  });
                                } else {
                                  Navigator.pushNamed(context, 'set_up');
                                  setState(() {
                                    loaders[index.toString()] = false;
                                  });
                                }
                              }
                            }
                          } else {
                            Navigator.pushNamed(context, 'sign_up');
                            setState(() {
                              loaders[index.toString()] = false;
                            });

                            print('anything');
                          }
                        },

                        //   if (user != null) {
                        //     if (!users.containsKey('userName')) {
                        //       Navigator.pushNamed(context, 'set_up');
                        //       setState(() {
                        //         loaders[index.toString()] = false;
                        //       });
                        //     } else {
                        //       dynamic btc = double.parse(users['BTC']);
                        //       dynamic eth = double.parse(users['ETH']);
                        //       dynamic xrp = double.parse(users['XRP']);
                        //       dynamic bch = double.parse(users['BCH']);
                        //       dynamic ltc = double.parse(users['LTC']);
                        //       dynamic trx = double.parse(users['TRX']);
                        //       dynamic balanceList = [
                        //         btc.toString(),
                        //         eth.toString(),
                        //         xrp.toString(),
                        //         bch.toString(),
                        //         ltc.toString(),
                        //         trx.toString(),
                        //         //    users['BTC'].toString(),
                        //         // users['ETH'].toString(),
                        //         // users['XRP'].toString(),
                        //         // users['BCH'].toString(),
                        //         // users['LTC'].toString(),
                        //         // users['TRX'].toString(),
                        //       ];
                        //       // print(users['btc']);

                        //       final balance =
                        //           balanceList[index % balanceList.length];
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => CoinDepositWallet(
                        //             currency: currencies[index],
                        //             image: image,
                        //             coinBalance: balance,
                        //             user: users,
                        //             nairaRate: nairaRate,
                        //           ),
                        //         ),
                        //       );
                        //       setState(() {
                        //         loaders[index.toString()] = false;
                        //       });
                        //     }
                        //   } else {
                        //     Navigator.pushNamed(context, 'sign_up');
                        //     setState(() {
                        //       loaders[index.toString()] = false;
                        //     });

                        //     print('anything');
                        //   }
                        // },
                        widget: Visibility(
                          child: LinearProgressIndicator(
                            minHeight: 6,
                          ),
                          visible: !loaders[index.toString()] ? false : true,
                        ),
                      );
                      // : Center(child: LinearProgressIndicator()
                      // );
                    })
                : SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Container(
                      height: MediaQuery.of(context).size.height * .875,
                      child: _showLoader(),
                    ),
                  ),
            onRefresh: () async {
              if (await _checkInternet()) {
                // dynamic currency = await getCurrencies.refreshCurrencies();
                // if (mounted) {

                getCurrencies.refreshCurrencies().then((value) {
                  if (mounted) {
                    setState(() {
                      // currencies = nairaWallet;
                      currencies = value;
                      _loading = false;
                      _isConnected = true;
                    });
                    for (int i = 0; i < currencies.length; i++) {
                      loaders[i.toString()] = false;
                    }
                    // print(_loaders.toString());
                  }
                });
                // setState(() {
                //   currencies = currency;
                //   _loading = false;
                // });
                // }
              } else {
                if (mounted) {
                  setState(() {
                    _isConnected = false;
                  });
                }
              }
            },
          ),
        ),
      ]),
    );
  }

  Future<bool> _checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
          ? true
          : false;
    } on SocketException catch (_) {
      return false;
    }
  }

  Widget _showLoader() {
    if (_isConnected) {
      return SizedBox(child: Center(child: CircularProgressIndicator()));
      // height: 100,
      // width: 100,

    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/no_internet.png'),
          SizedBox(
            height: 35,
          ),
          Text(
            'Pull down to refresh..',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }
  }
}
