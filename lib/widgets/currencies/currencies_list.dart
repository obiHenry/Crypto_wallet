import 'dart:io';

import 'package:Crypto_wallet/screens/wallet/wallet_screen.dart';
import 'package:Crypto_wallet/services/auth.dart';
import 'package:Crypto_wallet/services/get_currency.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'currency_item_card.dart';

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

  final imageList = [
    'assets/images/btc.png',
    'assets/images/eth_logo.jpg',
    'assets/images/xrp.png',
    'assets/images/bch.png',
    'assets/images/ltc.png',
    'assets/images/tron.jpg',
    'assets/images/pax.png',
  ];
  bool _loader = false;

  @override
  void didChangeDependencies() {
    getCurrencies = Provider.of<GetCurrencies>(context);

    _checkInternet().then((value) {
      if (value) {
        getCurrencies.refreshCurrencies().then((value) {
          if (mounted) {
            setState(() {
              currencies = value;
              _loading = false;
              _isConnected = true;
            });
            for (int i = 0; i < currencies.length; i++) {
              _loaders[i.toString()] = false;
            }
            print(_loaders.toString());
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

    return RefreshIndicator(
      child: !_loading
          ? ListView.builder(
              itemCount: currencies.length == null ? 0 : currencies.length,
              itemBuilder: (context, index) {
                final image = imageList[index % imageList.length];
                return
                    // !_loaders[index.toString()]?
                    CurrencyItemCard(
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
                        final balanceList = [
                          users['btc'],
                          users['eth'],
                          users['xrp'],
                          users['bch'],
                          users['ltc'],
                          users['trx'],
                          users['pax'],
                        ];
                        // print(users['btc']);

                        final balance = balanceList[index % balanceList.length];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Wallet(
                              currency: currencies[index],
                              image: image,
                              balance: balance,
                              user: users,
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
                    child: LinearProgressIndicator(minHeight: 6,),
                    visible: !_loaders[index.toString()] ? false : true,
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
          List currency = await getCurrencies.refreshCurrencies();
          if (mounted) {
            setState(() {
              currencies = currency;
            });
          }
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
