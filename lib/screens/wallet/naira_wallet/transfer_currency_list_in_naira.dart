import 'dart:io';

import 'package:Crypto_wallet/screens/wallet/naira_wallet/naira-transfer_wallet.dart';
import 'package:Crypto_wallet/services/auth.dart';
import 'package:Crypto_wallet/services/get_currency_in_naira.dart';
import 'package:Crypto_wallet/screens/wallet/naira_wallet/currencies_in_naira_card_item.dart';
import 'package:Crypto_wallet/services/get_naira_rate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransferCurrencyListinNaira extends StatefulWidget {
  final String text;
  TransferCurrencyListinNaira({
    this.text,
  });
  @override
  _TransferCurrencyListinNairaState createState() =>
      _TransferCurrencyListinNairaState();
}

class _TransferCurrencyListinNairaState
    extends State<TransferCurrencyListinNaira> {
  final auth = AuthService();
  var user = FirebaseAuth.instance.currentUser;
  List currencies = [];
  bool _loading = true;
  bool _isConnected = true;
  GetCurrenciesInNaira getCurrencies;
  Map<String, bool> loaders = {};

  final imageList = [
    'assets/images/btc.png',
    'assets/images/etherium.jpg',
    'assets/images/ripple.png',
    'assets/images/bitcoin_cash.png',
    'assets/images/litcoin.jpg',
    'assets/images/tron.jpg',
  ];

  // final walletName = ['NairaWallet'];
  dynamic nairaRate;
  dynamic naira1;

  @override
  void didChangeDependencies() async {
    getCurrencies = Provider.of<GetCurrenciesInNaira>(context);

    _checkInternet().then((value) {
      if (value) {
        getCurrencies.refreshCurrencies().then((value) async {
          if (mounted) {
            naira1 = await GetNairaRate().getNairaRate();

            nairaRate = (naira1['buy_rate']).toStringAsFixed(1);
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
                            if (!users.containsKey('userName')) {
                              Navigator.pushNamed(context, 'set_up');
                              setState(() {
                                loaders[index.toString()] = false;
                              });
                            } else {
                              dynamic btc = double.parse(users['BTC']);
                              dynamic eth = double.parse(users['ETH']);
                              dynamic xrp = double.parse(users['XRP']);
                              dynamic bch = double.parse(users['BCH']);
                              dynamic ltc = double.parse(users['LTC']);
                              dynamic trx = double.parse(users['TRX']);
                              dynamic balanceList = [
                                btc.toString(),
                                eth.toString(),
                                xrp.toString(),
                                bch.toString(),
                                ltc.toString(),
                                trx.toString(),
                                //    users['BTC'].toString(),
                                // users['ETH'].toString(),
                                // users['XRP'].toString(),
                                // users['BCH'].toString(),
                                // users['LTC'].toString(),
                                // users['TRX'].toString(),
                              ];
                              // print(users['btc']);
                              dynamic nairaBalance = users['naira'].toString();
                              final coinbBlance =
                                  balanceList[index % balanceList.length];
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NairaTransferWallet(
                                    currency: currencies[index],
                                    coinBalance: coinbBlance,
                                    nairaBalance: nairaBalance,
                                    user: users,
                                    nairaRate: nairaRate,
                                  ),
                                ),
                              );
                              setState(() {
                                loaders[index.toString()] = false;
                              });
                            }
                          } else {
                            Navigator.pushNamed(context, 'sign_up');
                            setState(() {
                              loaders[index.toString()] = false;
                            });

                            print('anything');
                          }
                        },
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
