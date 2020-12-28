import 'dart:io';

import 'package:Crypto_wallet/screens/wallet/coin_wallet/wallet_screen.dart';
import 'package:Crypto_wallet/services/auth.dart';
import 'package:Crypto_wallet/services/get_currency.dart';
import 'package:Crypto_wallet/screens/wallet/naira_wallet/naira_wallet_screen.dart';
import 'package:Crypto_wallet/services/get_naira_rate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'currency_item_card.dart';
import 'naira-wallet_item_card.dart';

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
  GetCurrencies getCurrencies;
  Map<String, bool> _loaders = {};
  bool _loader = false;

  final imageList = [
    'assets/images/btc.png',
    'assets/images/etherium.jpg',
    'assets/images/ripple.png',
    'assets/images/bitcoin_cash.png',
    'assets/images/litcoin.jpg',
    'assets/images/tron.jpg',
    // 'assets/images/pax.png',
  ];

  dynamic  nairaVeloceSellRate, nairaVeloceBuyRate;
  dynamic naira1;
  dynamic transactionList;
  List nairaTransactionList = [];
  List bitcoinTransactionList = [];
  List ethereumTransactionList = [];
  List rippleTransactionList = [];
  List bitcoinCashTransactionList = [];
  List litcoinTransactionList = [];
  List tronTransactionList = [];
  // dynamic createdAt;

  // List nairaList = [];

  @override
  void didChangeDependencies() async {
    getCurrencies = Provider.of<GetCurrencies>(context);

    _checkInternet().then((value) {
      if (value) {
        getCurrencies.refreshCurrencies().then((value) {
          if (mounted) {
            setState(() {
              // currencies = nairaWallet;
              currencies = value;
              _loading = false;
              _isConnected = true;
            });
            for (int i = 0; i < currencies.length; i++) {
              _loaders[i.toString()] = false;
            }
            // print(_loaders.toString());
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

    naira1 = await GetNairaRate().getNairaRate();

    nairaVeloceSellRate = (naira1['sell_rate']).toStringAsFixed(1);
    nairaVeloceBuyRate = (naira1['buy_rate']).toStringAsFixed(1);

    transactionList = await AuthService().getTransactionList();
    
    // print(transactionList);
    Map list = await transactionList['nairaWalletTransactionList'];
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

    Map btcList = await transactionList['BTCWalletTransactionList'];
    Map ethList = await transactionList['ETHWalletTransactionList'];
    Map xrpList = await transactionList['XRPWalletTransactionList'];
    Map bchList = await transactionList['BCHWalletTransactionList'];
    Map ltcList = await transactionList['LTCWalletTransactionList'];
    Map trxList = await transactionList['TRXWalletTransactionList'];
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

    if(ethList != null){
       ethereumTransactionList.clear();
    ethList.forEach((key, value) {
      ethereumTransactionList.add(value);
    });
    ethereumTransactionList.sort((a, b) {
      return -a['createdAt'].compareTo(b['createdAt']);
    });
    }

   if(xrpList != null){
       rippleTransactionList.clear();
    xrpList.forEach((key, value) {
      rippleTransactionList.add(value);
    });
    rippleTransactionList.sort((a, b) {
      return -a['createdAt'].compareTo(b['createdAt']);
    });
   }

if(bchList != null){
  bitcoinCashTransactionList.clear();
    bchList.forEach((key, value) {
      bitcoinCashTransactionList.add(value);
    });
    bitcoinCashTransactionList.sort((a, b) {
      return -a['createdAt'].compareTo(b['createdAt']);
    });
}
  
  if(ltcList != null){
  litcoinTransactionList.clear();
    ltcList.forEach((key, value) {
      litcoinTransactionList.add(value);
    });
    litcoinTransactionList.sort((a, b) {
      return -a['createdAt'].compareTo(b['createdAt']);
    });
  }

  if(trxList != null){
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

                if (user != null) {
                  if (!users.containsKey('userName')) {
                    Navigator.pushNamed(context, 'set_up');
                    setState(() {
                      _loader = false;
                    });
                  } else {
                    dynamic nairaBalance = users['naira'];

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NairaWalletScreen(
                          nairaBalance: nairaBalance,
                          user: users,
                          nairaRate: nairaVeloceBuyRate,
                          nairatransactionList: nairaTransactionList,

                          // currency: currencies[index],
                          // image: image,
                          // balance: balance,
                          // user: users,
                        ),
                      ),
                    );
                    setState(() {
                      _loader = false;
                    });
                  }
                } else {
                  Navigator.pushNamed(context, 'sign_up');
                  setState(() {
                    _loader = false;
                  });
                  print('anything');
                }
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
            height: MediaQuery.of(context).size.height *0.31,
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

                          if (user != null) {
                            if (!users.containsKey('userName')) {
                              Navigator.pushNamed(context, 'set_up');
                              setState(() {
                                _loaders[index.toString()] = false;
                              });
                            } else {
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
                            }
                          } else {
                            Navigator.pushNamed(context, 'sign_up');
                            setState(() {
                              _loaders[index.toString()] = false;
                            });

                            print('anything');
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
                      height: MediaQuery.of(context).size.height *  0.31,
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

          getCurrencies.refreshCurrencies().then((value) {
            if (mounted) {
              setState(() {
                // currencies = nairaWallet;
                currencies = value;
                _loading = false;
                _isConnected = true;
              });
              for (int i = 0; i < currencies.length; i++) {
                _loaders[i.toString()] = false;
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
