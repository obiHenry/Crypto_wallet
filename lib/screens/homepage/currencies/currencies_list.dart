import 'dart:io';
import 'package:Crypto_wallet/screens/wallet/coin_wallet/wallet_screen.dart';
import 'package:Crypto_wallet/services/auth.dart';
import 'package:Crypto_wallet/services/api_services.dart';
import 'package:Crypto_wallet/screens/wallet/naira_wallet/naira_wallet_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'currency_item_card.dart';
import 'naira-wallet_item_card.dart';
import 'package:Crypto_wallet/screens/logins_and_signUp/set_up/set_up_screen.dart';

import 'dart:math';
import 'dart:convert';

class CurrenciesList extends StatefulWidget {
  @override
  _CurrenciesListState createState() => _CurrenciesListState();
}

class _CurrenciesListState extends State<CurrenciesList> {
  final auth = AuthService();
  var user = FirebaseAuth.instance.currentUser;
  List currencies = [];
  bool _loading = true;
  bool _isConnected = true;
  ApiServices getCurrencies;
  Map<String, bool> _loaders = {};
  bool _loader = false;

  final imageList = [
    'assets/images/btc.png',
    'assets/images/etherium.jpg',
    'assets/images/ripple.png',
    'assets/images/litcoin.jpg',
    'assets/images/bitcoin_cash.png',
    'assets/images/tron.jpg',
    // 'assets/images/pax.png',
  ];

  dynamic nairaVeloceSellRate, nairaVeloceBuyRate;
  dynamic naira1;
  dynamic transactionList;
  List nairaTransactionList = [];
  List bitcoinTransactionList = [];
  List ethereumTransactionList = [];
  List rippleTransactionList = [];
  List bitcoinCashTransactionList = [];
  List litcoinTransactionList = [];
  List tronTransactionList = [];
  Map list, btcList, ethList, xrpList, bchList, ltcList, trxList;
  // dynamic createdAt;

  // List nairaList = [];

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
  void didChangeDependencies() async {
    getCurrencies = Provider.of<ApiServices>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (getCurrencies.currencies.length < 1) {
        _checkInternet().then((value)async {
          if (value) {

            List currency = await getCurrencies.refreshCurrencies();
            // getCurrencies.refreshCurrencies().then((value) {
              if (mounted) {
                setState(() {
                  
                  currencies = currency;
                  print('this is the currencies ${currencies.toString()}');
                  _loading = false;
                  _isConnected = true;
                });
                for (int i = 0; i < currencies.length; i++) {
                  _loaders[i.toString()] = false;
                }
                // print(_loaders.toString());
              }
            // });
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
            currencies =  getCurrencies.currencies;
            _loading = false;
          });
          for (int i = 0; i < currencies.length; i++) {
            _loaders[i.toString()] = false;
          }
        }
      }
    });
    if (auth.naira == null) {
      naira1 = await AuthService().getNairaRate();
    } else {
      naira1 = auth.naira;
    }
    dynamic sellRate = double.parse(naira1['sellRate']);
    dynamic buyRate = double.parse(naira1['buyRate']);

    nairaVeloceSellRate = (sellRate).toStringAsFixed(1);
    nairaVeloceBuyRate = (buyRate).toStringAsFixed(1);

    transactionList = await AuthService().getTransactionList();
    if (transactionList != null) {
      list = await transactionList['nairaWalletTransactionList'];
      btcList = await transactionList['BTCWalletTransactionList'];
      ethList = await transactionList['ETHWalletTransactionList'];
      xrpList = await transactionList['XRPWalletTransactionList'];
      bchList = await transactionList['BCHWalletTransactionList'];
      ltcList = await transactionList['LTCWalletTransactionList'];
      trxList = await transactionList['TRXWalletTransactionList'];
    }

    // print(transactionList);

    // print(list);

    if (list != null) {
      nairaTransactionList.clear();
      list.forEach((key, value) {
        nairaTransactionList.add(value);
      });
      nairaTransactionList.sort((a, b) {
        return -a['createdAt'].compareTo(b['createdAt']);
      });
    }

    if (btcList != null) {
      bitcoinTransactionList.clear();
      btcList.forEach((key, value) {
        // createdAt = value['createdAt'];
        bitcoinTransactionList.add(value);
      });
      bitcoinTransactionList.sort((a, b) {
        return -a['createdAt'].compareTo(b['createdAt']);
      });
      print(bitcoinTransactionList);
    }

    if (ethList != null) {
      ethereumTransactionList.clear();
      ethList.forEach((key, value) {
        ethereumTransactionList.add(value);
      });
      ethereumTransactionList.sort((a, b) {
        return -a['createdAt'].compareTo(b['createdAt']);
      });
    }

    if (xrpList != null) {
      rippleTransactionList.clear();
      xrpList.forEach((key, value) {
        rippleTransactionList.add(value);
      });
      rippleTransactionList.sort((a, b) {
        return -a['createdAt'].compareTo(b['createdAt']);
      });
    }

    if (bchList != null) {
      bitcoinCashTransactionList.clear();
      bchList.forEach((key, value) {
        bitcoinCashTransactionList.add(value);
      });
      bitcoinCashTransactionList.sort((a, b) {
        return -a['createdAt'].compareTo(b['createdAt']);
      });
    }

    if (ltcList != null) {
      litcoinTransactionList.clear();
      ltcList.forEach((key, value) {
        litcoinTransactionList.add(value);
      });
      litcoinTransactionList.sort((a, b) {
        return -a['createdAt'].compareTo(b['createdAt']);
      });
    }

    if (trxList != null) {
      tronTransactionList.clear();
      trxList.forEach((key, value) {
        tronTransactionList.add(value);
      });
      tronTransactionList.sort((a, b) {
        return -a['createdAt'].compareTo(b['createdAt']);
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // currencies = Provider.of<GetCurrencies>(context).currencies;

    // print('heeee$currencies');

    return RefreshIndicator(
      // child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.11,
            child: NairaWalletCard(
              nairaRate: nairaVeloceBuyRate,
              press: () async {
                setState(() {
                  _loader = true;
                });
                dynamic users = await auth.getUserDataById();

                // if (user != null) {
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
                      dynamic result2 = json.decode(result1['message']);

                      if (result2['status'] == '1') {
                        print(
                            'this is the email result ${result1['message'].toString()}');

                        Navigator.of(context)
                            .pushNamed('verification_screen', arguments: {
                          'email': users['email'],
                          'token': token.toString(),
                          'fromExternal': false,
                        });
                        setState(() {
                          _loader = false;
                        });
                      } else {
                        getSnackBar(result2['response'].toString(), Colors.red);
                        setState(() {
                          _loader = false;
                        });
                      }
                    } else {
                      getSnackBar(result1['message'], Colors.red);
                      setState(() {
                        _loader = false;
                      });
                    }
                  } else {
                    if (users.containsKey('userName')) {
                      dynamic nairaBalance = users['naira'];

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NairaWalletScreen(
                            nairaBalance: nairaBalance,
                            user: users,
                            nairaRate: nairaVeloceBuyRate,
                            nairatransactionList: nairaTransactionList,
                          ),
                        ),
                      );
                      setState(() {
                        _loader = false;
                      });
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SetUpScreen()));
                      // Navigator.pushNamed(context, 'set_up');
                      setState(() {
                        _loader = false;
                      });
                    }
                  }
                }
                // } else {
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => SignUpScreen()));
                //   // Navigator.pushNamed(context, 'sign_up');
                //   setState(() {
                //     _loader = false;
                //   });
                //   print('anything');
                // }
              },
              widget: Visibility(
                child: LinearProgressIndicator(
                  minHeight: 6,
                ),
                visible: !_loader ? false : true,
              ),
            ),
          ),
          SizedBox(
            height: 0,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.31,
            child: !_loading
                ? ListView.builder(
                    itemCount:
                        currencies.length == null ? 0 : currencies.length,
                    itemBuilder: (context, index) {
                      final image = imageList[index % imageList.length];
                      // final walletname = walletName[index % walletName.length];
                      return CurrencyItemCard(
                        currency: currencies[index],
                        color: image,
                        press: () async {
                          setState(() {
                            _loaders[index.toString()] = true;
                          });
                          dynamic users = await auth.getUserDataById();

                          // if (user != null) {
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
                                    _loaders[index.toString()] = false;
                                  });
                                } else {
                                  print(result2['response'].toString());
                                  getSnackBar(result2['response'].toString(),
                                      Colors.red);
                                  setState(() {
                                    _loaders[index.toString()] = false;
                                  });
                                }
                              } else {
                                print(result1['message'].toString());
                                getSnackBar(result1['message'], Colors.red);
                                setState(() {
                                  _loaders[index.toString()] = false;
                                });
                              }
                            } else {
                              if (users.containsKey('userName')) {
                                dynamic balanceList = [
                                  users['BTC'].toString(),
                                  users['ETH'].toString(),
                                  users['XRP'].toString(),
                                  users['BCH'].toString(),
                                  users['LTC'].toString(),
                                  users['TRX'].toString(),
                                ];

                                dynamic currencyTransactionList = [
                                  bitcoinTransactionList,
                                  ethereumTransactionList,
                                  rippleTransactionList,
                                  bitcoinCashTransactionList,
                                  litcoinTransactionList,
                                  tronTransactionList,
                                ];
                                final transactions = currencyTransactionList[
                                    index % currencyTransactionList.length];

                                final balance =
                                    balanceList[index % balanceList.length];
                                print(transactions);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Wallet(
                                      currency: currencies[index],
                                      image: image,
                                      balance: balance,
                                      user: users,
                                      transactions: transactions,
                                      nairaVeloceBuyRate: nairaVeloceBuyRate,
                                      nairaVeloceSellRate: nairaVeloceSellRate,
                                    ),
                                  ),
                                );
                                setState(() {
                                  _loaders[index.toString()] = false;
                                });
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SetUpScreen()));
                                // Navigator.pushNamed(context, 'set_up');
                                setState(() {
                                  _loaders[index.toString()] = false;
                                });
                              }
                            }
                          }
                        },
                        widget: Visibility(
                          child: LinearProgressIndicator(
                            minHeight: 6,
                          ),
                          visible: !_loaders[index.toString()] ? false : true,
                        ),
                      );
                      // : Center(child: LinearProgressIndicator()
                      // );
                    })
                : SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.31,
                      child: _showLoader(),
                    ),
                  ),
          ),
        ],
      ),
      // ),
      onRefresh: () async {
        if (await _checkInternet()) {
          // dynamic currency = await getCurrencies.refreshCurrencies();
          // if (mounted) {
          List currency = await getCurrencies.refreshCurrencies();
          if (mounted) {
            setState(() {
              currencies = currency;
              _loading = false;
              _isConnected = true;
            });
            for (int i = 0; i < currencies.length; i++) {
              _loaders[i.toString()] = false;
            }
          }

          // getCurrencies.refreshCurrencies().then((value) {
          //   if (mounted) {
          //     setState(() {
          //       // currencies = nairaWallet;
          //       currencies = value;
          //       _loading = false;
          //       _isConnected = true;
          //     });
          //     for (int i = 0; i < currencies.length; i++) {
          //       _loaders[i.toString()] = false;
          //     }
          //     // print(_loaders.toString());
          //   }
          // });
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
      return Center(
        child: SizedBox(
          child: CircularProgressIndicator(),
          height: 100,
          width: 100,
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Image.asset('assets/images/no_internet.png')),
          SizedBox(
            height: 34,
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
