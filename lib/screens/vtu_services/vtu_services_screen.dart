import 'dart:convert';

import 'package:Crypto_wallet/screens/vtu_services/utilty_bills/utility_bills_screen.dart';
import 'package:Crypto_wallet/services/auth.dart';
import 'package:Crypto_wallet/services/get_currency.dart';
import 'package:Crypto_wallet/services/get_naira_rate.dart';
import 'package:Crypto_wallet/shared/app_colors.dart';
import 'package:Crypto_wallet/theme/light_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bet_sub/bet_sub_screen.dart';
import 'cable_tv/cable_tv_sreen.dart';
import 'internet_services/internet_service_screen.dart';
import 'mobile_top_up_screen/mobile_top_up_screen.dart';

class VtuServicesScreen extends StatefulWidget {
  @override
  _VtuServicesScreenState createState() => _VtuServicesScreenState();
}

class _VtuServicesScreenState extends State<VtuServicesScreen> {
  dynamic nairaBalance;
  dynamic btcBalance;
  dynamic ethBalance;
  dynamic xrpBalance;
  dynamic bchBalance;
  dynamic ltcBalance;
  dynamic trxBalance;
  double nairaUsdEquivalance;
  dynamic cbnNairaRate;
  GetCurrencies getCurrencies;
  List currencies = [];
  List price = [];
  double btcUsdPrice, btcNairaPrice;
  double ethUsdPrice, ethNairaPrice;
  double xrpUsdPrice, xrpNairaPrice;
  double ltcUsdPrice, ltcNairaPrice;
  double bchUsdPrice, bchNairaPrice;
  double trxUsdPrice, trxNairaPrice;
  dynamic nairaRate;
  List walletList;
  bool listIsEmpty = true;
  bool _loader1 = false;
  bool _loader2 = false;
  bool _loader3 = false;
  bool _loader4 = false;
  dynamic users;
  var currentUser = FirebaseAuth.instance.currentUser;

  bool _loader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlueStart,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: yellowEndWallet,
                gradient: LinearGradient(
                  // yellowStartWallet, yellowEndWallet
                  colors: [
                    LightColor.navyBlue2,
                    Colors.green,
                    LightColor.navyBlue2,
                    Colors.lightGreen,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment(0.6, 0.3),
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(height: 55),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            // GestureDetector(
                            //   onTap: () {
                            //     Navigator.pop(context);
                            //   },
                            //   child: SvgPicture.asset('assets/images/back.svg'),
                            // ),
                            Text(
                              'Airtime and Bills Payments',
                              // widget.currency['name'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            // SvgPicture.asset('assets/images/back.svg',
                            //     color: Colors.transparent),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * .12,
                    left: -5,
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(45 / 360),
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * .16,
                    left: MediaQuery.of(context).size.width * 0.05,
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(45 / 360),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * .05,
                    right: 30,
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(45 / 360),
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * .09,
                    right: -15,
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(45 / 360),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Text(
            //   'Method of Transfer',
            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            // ),
            // SizedBox(
            //   height: 22,
            // ),
            InkWell(
              onTap: () async {
                setState(() {
                  _loader = true;
                });
                dynamic user = await AuthService().getUserDataById();

                if (currentUser != null) {
                  if (!user.containsKey('userName')) {
                    Navigator.pushNamed(context, 'set_up');
                    setState(() {
                      _loader = false;
                    });
                  } else {
                    users = await AuthService().getUserDataById();
                    dynamic naira1 = await GetNairaRate().getNairaRate();
                    nairaRate = (naira1['buy_rate']).toStringAsFixed(1);

                    cbnNairaRate = (naira1['cbn_rate']).toStringAsFixed(1);

                    nairaBalance = users['naira'].toString();
                    btcBalance = users['BTC'].toString();
                    ethBalance = users['ETH'].toString();
                    xrpBalance = users['XRP'].toString();
                    bchBalance = users['BCH'].toString();
                    ltcBalance = users['LTC'].toString();
                    trxBalance = users['TRX'].toString();

                    getCurrencies =
                        Provider.of<GetCurrencies>(context, listen: false);
                    getCurrencies.refreshCurrencies().then((value) {
                      currencies = value;
                      price.clear();
                      currencies.forEach((element) {
                        dynamic pri = json.decode(element['price']);
                        price.add(pri);
                      });

                      btcUsdPrice = price[0];
                      ethUsdPrice = price[1];
                      xrpUsdPrice = price[2];
                      ltcUsdPrice = price[3];
                      bchUsdPrice = price[4];
                      trxUsdPrice = price[5];

                      nairaUsdEquivalance =
                          double.parse(nairaBalance) / double.parse(nairaRate);

                      btcNairaPrice = (double.parse(btcBalance) * btcUsdPrice) *
                          double.parse(nairaRate);

                      ethNairaPrice = (double.parse(ethBalance) * ethUsdPrice) *
                          double.parse(nairaRate);
                      xrpNairaPrice = (double.parse(xrpBalance) * xrpUsdPrice) *
                          double.parse(nairaRate);
                      ltcNairaPrice = (double.parse(ltcBalance) * ltcUsdPrice) *
                          double.parse(nairaRate);
                      bchNairaPrice = (double.parse(bchBalance) * bchUsdPrice) *
                          double.parse(nairaRate);
                      trxNairaPrice = (double.parse(trxBalance) * trxUsdPrice) *
                          double.parse(nairaRate);

                      print('mine$btcNairaPrice');
                      print(nairaUsdEquivalance);
                      setState(() {
                        listIsEmpty = false;
                      });
                      dynamic naira = double.parse(nairaBalance);

                      walletList = [
                        {
                          'walletName': 'Naira Wallet',
                          'logo': 'assets/images/index.png',
                          'balance': naira.toStringAsFixed(2),
                          'otherCurrency':
                              nairaUsdEquivalance.toStringAsFixed(2),
                          'symbol': 'USD',
                          'price': nairaRate,
                          'nairaRate': nairaRate,
                        },
                        {
                          'walletName': 'BTC Wallet',
                          'logo': 'assets/images/btc.png',
                          'balance': btcBalance.toString(),
                          'otherCurrency': btcNairaPrice.toStringAsFixed(2),
                          'symbol': 'BTC',
                          'price': btcUsdPrice,
                          'nairaRate': nairaRate,
                        },
                        {
                          'walletName': 'ETH Wallet',
                          'logo': 'assets/images/etherium.jpg',
                          'balance': ethBalance.toString(),
                          'otherCurrency': ethNairaPrice.toStringAsFixed(2),
                          'symbol': 'ETH',
                          'price': ethUsdPrice,
                          'nairaRate': nairaRate,
                        },
                        {
                          'walletName': 'XRP Wallet',
                          'logo': 'assets/images/ripple.png',
                          'balance': xrpBalance.toString(),
                          'otherCurrency': xrpNairaPrice.toStringAsFixed(2),
                          'symbol': 'XRP',
                          'price': xrpUsdPrice,
                          'nairaRate': nairaRate,
                        },
                        {
                          'walletName': 'BCH Wallet',
                          'logo': 'assets/images/bitcoin_cash.png',
                          'balance': bchBalance.toString(),
                          'otherCurrency': bchNairaPrice.toStringAsFixed(2),
                          'symbol': 'BCH',
                          'price': bchUsdPrice,
                          'nairaRate': nairaRate,
                        },
                        {
                          'walletName': 'LTC Wallet',
                          'logo': 'assets/images/litcoin.jpg',
                          'balance': ltcBalance.toString(),
                          'otherCurrency': ltcNairaPrice.toStringAsFixed(2),
                          'symbol': 'LTC',
                          'price': ltcUsdPrice,
                          'nairaRate': nairaRate,
                        },
                        {
                          'walletName': 'TRX Wallet',
                          'logo': 'assets/images/tron.jpg',
                          'balance': trxBalance.toString(),
                          'otherCurrency': trxNairaPrice.toStringAsFixed(2),
                          'symbol': 'TRX',
                          'price': trxUsdPrice,
                          'nairaRate': nairaRate,
                        },
                      ];

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MobileTopUpScreen(
                            walletList: walletList,
                          ),
                        ),
                      );
                      setState(() {
                        _loader = false;
                      });
                    });
                  }
                } else {
                  Navigator.pushNamed(context, 'sign_up');
                  setState(() {
                    _loader = false;
                  });
                }
              },
              child: Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 15),
                 color: lightgreen,
                              // child: Container(
                  // // decoration: ,
                  // margin: EdgeInsets.symmetric(horizontal: 15),
                  // // height: 90,
                  // color: lightgreen,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ListTile(
                            leading: Image.asset(
                              'assets/images/air-min.png',
                              height: 30,
                              width: 30,
                            ),
                            title: Text('Mobile Topup'),
                             subtitle: Text('Top up your airtime'),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Visibility(
                          child: LinearProgressIndicator(
                            minHeight: 6,
                          ),
                          visible: _loader ? true : false,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            // ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () async {
                setState(() {
                  _loader1 = true;
                });
                dynamic user = await AuthService().getUserDataById();

                if (currentUser != null) {
                  if (!user.containsKey('userName')) {
                    Navigator.pushNamed(context, 'set_up');
                    setState(() {
                      _loader1 = false;
                    });
                  } else {
                    users = await AuthService().getUserDataById();
                    dynamic naira1 = await GetNairaRate().getNairaRate();
                    nairaRate = (naira1['buy_rate']).toStringAsFixed(1);

                    cbnNairaRate = (naira1['cbn_rate']).toStringAsFixed(1);

                    nairaBalance = users['naira'].toString();
                    btcBalance = users['BTC'].toString();
                    ethBalance = users['ETH'].toString();
                    xrpBalance = users['XRP'].toString();
                    bchBalance = users['BCH'].toString();
                    ltcBalance = users['LTC'].toString();
                    trxBalance = users['TRX'].toString();

                    getCurrencies =
                        Provider.of<GetCurrencies>(context, listen: false);
                    getCurrencies.refreshCurrencies().then((value) {
                      currencies = value;
                      price.clear();
                      currencies.forEach((element) {
                        dynamic pri = json.decode(element['price']);
                        price.add(pri);
                      });

                      btcUsdPrice = price[0];
                      ethUsdPrice = price[1];
                      xrpUsdPrice = price[2];
                      ltcUsdPrice = price[3];
                      bchUsdPrice = price[4];
                      trxUsdPrice = price[5];

                      nairaUsdEquivalance =
                          double.parse(nairaBalance) / double.parse(nairaRate);

                      btcNairaPrice = (double.parse(btcBalance) * btcUsdPrice) *
                          double.parse(nairaRate);

                      ethNairaPrice = (double.parse(ethBalance) * ethUsdPrice) *
                          double.parse(nairaRate);
                      xrpNairaPrice = (double.parse(xrpBalance) * xrpUsdPrice) *
                          double.parse(nairaRate);
                      ltcNairaPrice = (double.parse(ltcBalance) * ltcUsdPrice) *
                          double.parse(nairaRate);
                      bchNairaPrice = (double.parse(bchBalance) * bchUsdPrice) *
                          double.parse(nairaRate);
                      trxNairaPrice = (double.parse(trxBalance) * trxUsdPrice) *
                          double.parse(nairaRate);

                      print('mine$btcNairaPrice');
                      print(nairaUsdEquivalance);
                      setState(() {
                        listIsEmpty = false;
                      });
                      dynamic naira = double.parse(nairaBalance);

                      walletList = [
                        {
                          'walletName': 'Naira Wallet',
                          'logo': 'assets/images/index.png',
                          'balance': naira.toStringAsFixed(2),
                          'otherCurrency':
                              nairaUsdEquivalance.toStringAsFixed(2),
                          'symbol': 'USD',
                          'price': nairaRate,
                          'nairaRate': nairaRate,
                        },
                        {
                          'walletName': 'BTC Wallet',
                          'logo': 'assets/images/btc.png',
                          'balance': btcBalance.toString(),
                          'otherCurrency': btcNairaPrice.toStringAsFixed(2),
                          'symbol': 'BTC',
                          'price': btcUsdPrice,
                          'nairaRate': nairaRate,
                        },
                        {
                          'walletName': 'ETH Wallet',
                          'logo': 'assets/images/etherium.jpg',
                          'balance': ethBalance.toString(),
                          'otherCurrency': ethNairaPrice.toStringAsFixed(2),
                          'symbol': 'ETH',
                          'price': ethUsdPrice,
                          'nairaRate': nairaRate,
                        },
                        {
                          'walletName': 'XRP Wallet',
                          'logo': 'assets/images/ripple.png',
                          'balance': xrpBalance.toString(),
                          'otherCurrency': xrpNairaPrice.toStringAsFixed(2),
                          'symbol': 'XRP',
                          'price': xrpUsdPrice,
                          'nairaRate': nairaRate,
                        },
                        {
                          'walletName': 'BCH Wallet',
                          'logo': 'assets/images/bitcoin_cash.png',
                          'balance': bchBalance.toString(),
                          'otherCurrency': bchNairaPrice.toStringAsFixed(2),
                          'symbol': 'BCH',
                          'price': bchUsdPrice,
                          'nairaRate': nairaRate,
                        },
                        {
                          'walletName': 'LTC Wallet',
                          'logo': 'assets/images/litcoin.jpg',
                          'balance': ltcBalance.toString(),
                          'otherCurrency': ltcNairaPrice.toStringAsFixed(2),
                          'symbol': 'LTC',
                          'price': ltcUsdPrice,
                          'nairaRate': nairaRate,
                        },
                        {
                          'walletName': 'TRX Wallet',
                          'logo': 'assets/images/tron.jpg',
                          'balance': trxBalance.toString(),
                          'otherCurrency': trxNairaPrice.toStringAsFixed(2),
                          'symbol': 'TRX',
                          'price': trxUsdPrice,
                          'nairaRate': nairaRate,
                        },
                      ];

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InternetServiceScreen(
                            walletList: walletList,
                          ),
                        ),
                      );
                      setState(() {
                        _loader1 = false;
                      });
                    });
                  }
                } else {
                  Navigator.pushNamed(context, 'sign_up');
                  setState(() {
                    _loader1 = false;
                  });
                }
              },
               child: Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 15),
                 color: lightgreen,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ListTile(
                          leading: Image.asset(
                            'assets/images/data.png',
                            height: 30,
                            width: 30,
                            fit: BoxFit.cover,
                          ),
                          title: Text('Internet Services'),
                           subtitle: Text('Buy your data bundles '),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Visibility(
                        child: LinearProgressIndicator(
                          minHeight: 6,
                        ),
                        visible: _loader1 ? true : false,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            InkWell(
              onTap: () async {
                setState(() {
                  _loader2 = true;
                });
                dynamic user = await AuthService().getUserDataById();

                if (currentUser != null) {
                  if (!user.containsKey('userName')) {
                    Navigator.pushNamed(context, 'set_up');
                    setState(() {
                      _loader2 = false;
                    });
                  } else {
                    users = await AuthService().getUserDataById();
                    dynamic naira1 = await GetNairaRate().getNairaRate();
                    nairaRate = (naira1['buy_rate']).toStringAsFixed(1);

                    cbnNairaRate = (naira1['cbn_rate']).toStringAsFixed(1);

                    nairaBalance = users['naira'].toString();
                    btcBalance = users['BTC'].toString();
                    ethBalance = users['ETH'].toString();
                    xrpBalance = users['XRP'].toString();
                    bchBalance = users['BCH'].toString();
                    ltcBalance = users['LTC'].toString();
                    trxBalance = users['TRX'].toString();

                    getCurrencies =
                        Provider.of<GetCurrencies>(context, listen: false);
                    getCurrencies.refreshCurrencies().then((value) {
                      currencies = value;
                      price.clear();
                      currencies.forEach((element) {
                        dynamic pri = json.decode(element['price']);
                        price.add(pri);
                      });

                      btcUsdPrice = price[0];
                      ethUsdPrice = price[1];
                      xrpUsdPrice = price[2];
                      ltcUsdPrice = price[3];
                      bchUsdPrice = price[4];
                      trxUsdPrice = price[5];

                      nairaUsdEquivalance =
                          double.parse(nairaBalance) / double.parse(nairaRate);

                      btcNairaPrice = (double.parse(btcBalance) * btcUsdPrice) *
                          double.parse(nairaRate);

                      ethNairaPrice = (double.parse(ethBalance) * ethUsdPrice) *
                          double.parse(nairaRate);
                      xrpNairaPrice = (double.parse(xrpBalance) * xrpUsdPrice) *
                          double.parse(nairaRate);
                      ltcNairaPrice = (double.parse(ltcBalance) * ltcUsdPrice) *
                          double.parse(nairaRate);
                      bchNairaPrice = (double.parse(bchBalance) * bchUsdPrice) *
                          double.parse(nairaRate);
                      trxNairaPrice = (double.parse(trxBalance) * trxUsdPrice) *
                          double.parse(nairaRate);

                      print('mine$btcNairaPrice');
                      print(nairaUsdEquivalance);
                      setState(() {
                        listIsEmpty = false;
                      });
                      dynamic naira = double.parse(nairaBalance);

                      walletList = [
                        {
                          'walletName': 'Naira Wallet',
                          'logo': 'assets/images/index.png',
                          'balance': naira.toStringAsFixed(2),
                          'otherCurrency':
                              nairaUsdEquivalance.toStringAsFixed(2),
                          'symbol': 'USD',
                          'price': nairaRate,
                          'nairaRate': nairaRate,
                        },
                        {
                          'walletName': 'BTC Wallet',
                          'logo': 'assets/images/btc.png',
                          'balance': btcBalance.toString(),
                          'otherCurrency': btcNairaPrice.toStringAsFixed(2),
                          'symbol': 'BTC',
                          'price': btcUsdPrice,
                          'nairaRate': nairaRate,
                        },
                        {
                          'walletName': 'ETH Wallet',
                          'logo': 'assets/images/etherium.jpg',
                          'balance': ethBalance.toString(),
                          'otherCurrency': ethNairaPrice.toStringAsFixed(2),
                          'symbol': 'ETH',
                          'price': ethUsdPrice,
                          'nairaRate': nairaRate,
                        },
                        {
                          'walletName': 'XRP Wallet',
                          'logo': 'assets/images/ripple.png',
                          'balance': xrpBalance.toString(),
                          'otherCurrency': xrpNairaPrice.toStringAsFixed(2),
                          'symbol': 'XRP',
                          'price': xrpUsdPrice,
                          'nairaRate': nairaRate,
                        },
                        {
                          'walletName': 'BCH Wallet',
                          'logo': 'assets/images/bitcoin_cash.png',
                          'balance': bchBalance.toString(),
                          'otherCurrency': bchNairaPrice.toStringAsFixed(2),
                          'symbol': 'BCH',
                          'price': bchUsdPrice,
                          'nairaRate': nairaRate,
                        },
                        {
                          'walletName': 'LTC Wallet',
                          'logo': 'assets/images/litcoin.jpg',
                          'balance': ltcBalance.toString(),
                          'otherCurrency': ltcNairaPrice.toStringAsFixed(2),
                          'symbol': 'LTC',
                          'price': ltcUsdPrice,
                          'nairaRate': nairaRate,
                        },
                        {
                          'walletName': 'TRX Wallet',
                          'logo': 'assets/images/tron.jpg',
                          'balance': trxBalance.toString(),
                          'otherCurrency': trxNairaPrice.toStringAsFixed(2),
                          'symbol': 'TRX',
                          'price': trxUsdPrice,
                          'nairaRate': nairaRate,
                        },
                      ];

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CableTvScreen(
                            walletList: walletList,
                          ),
                        ),
                      );
                      setState(() {
                        _loader2 = false;
                      });
                    });
                  }
                } else {
                  Navigator.pushNamed(context, 'sign_up');
                  setState(() {
                    _loader2 = false;
                  });
                }
              },
              child: Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 15),
                 color: lightgreen,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ListTile(
                          leading: Image.asset(
                            'assets/images/cable_tv.png',
                            height: 30,
                            width: 30,
                          ),
                          title: Text('Cable Tv'),
                           subtitle: Text('Subscribe your cable tv '),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Visibility(
                        child: LinearProgressIndicator(
                          minHeight: 6,
                        ),
                        visible: _loader2 ? true : false,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),

            InkWell(
              onTap: () async {
                setState(() {
                  _loader3 = true;
                });
                dynamic user = await AuthService().getUserDataById();

                if (currentUser != null) {
                  if (!user.containsKey('userName')) {
                    Navigator.pushNamed(context, 'set_up');
                    setState(() {
                      _loader3 = false;
                    });
                  } else {
                    users = await AuthService().getUserDataById();
                    dynamic naira1 = await GetNairaRate().getNairaRate();
                    nairaRate = (naira1['buy_rate']).toStringAsFixed(1);

                    cbnNairaRate = (naira1['cbn_rate']).toStringAsFixed(1);

                    nairaBalance = users['naira'].toString();
                    btcBalance = users['BTC'].toString();
                    ethBalance = users['ETH'].toString();
                    xrpBalance = users['XRP'].toString();
                    bchBalance = users['BCH'].toString();
                    ltcBalance = users['LTC'].toString();
                    trxBalance = users['TRX'].toString();

                    getCurrencies =
                        Provider.of<GetCurrencies>(context, listen: false);
                    getCurrencies.refreshCurrencies().then((value) {
                      currencies = value;
                      price.clear();
                      currencies.forEach((element) {
                        dynamic pri = json.decode(element['price']);
                        price.add(pri);
                      });

                      btcUsdPrice = price[0];
                      ethUsdPrice = price[1];
                      xrpUsdPrice = price[2];
                      ltcUsdPrice = price[3];
                      bchUsdPrice = price[4];
                      trxUsdPrice = price[5];

                      nairaUsdEquivalance =
                          double.parse(nairaBalance) / double.parse(nairaRate);

                      btcNairaPrice = (double.parse(btcBalance) * btcUsdPrice) *
                          double.parse(nairaRate);

                      ethNairaPrice = (double.parse(ethBalance) * ethUsdPrice) *
                          double.parse(nairaRate);
                      xrpNairaPrice = (double.parse(xrpBalance) * xrpUsdPrice) *
                          double.parse(nairaRate);
                      ltcNairaPrice = (double.parse(ltcBalance) * ltcUsdPrice) *
                          double.parse(nairaRate);
                      bchNairaPrice = (double.parse(bchBalance) * bchUsdPrice) *
                          double.parse(nairaRate);
                      trxNairaPrice = (double.parse(trxBalance) * trxUsdPrice) *
                          double.parse(nairaRate);

                      print('mine$btcNairaPrice');
                      print(nairaUsdEquivalance);
                      setState(() {
                        listIsEmpty = false;
                      });
                      dynamic naira = double.parse(nairaBalance);

                      walletList = [
                        {
                          'walletName': 'Naira Wallet',
                          'logo': 'assets/images/index.png',
                          'balance': naira.toStringAsFixed(2),
                          'otherCurrency':
                              nairaUsdEquivalance.toStringAsFixed(2),
                          'symbol': 'USD',
                          'price': nairaRate,
                          'nairaRate': nairaRate,
                        },
                        {
                          'walletName': 'BTC Wallet',
                          'logo': 'assets/images/btc.png',
                          'balance': btcBalance.toString(),
                          'otherCurrency': btcNairaPrice.toStringAsFixed(2),
                          'symbol': 'BTC',
                          'price': btcUsdPrice,
                          'nairaRate': nairaRate,
                        },
                        {
                          'walletName': 'ETH Wallet',
                          'logo': 'assets/images/etherium.jpg',
                          'balance': ethBalance.toString(),
                          'otherCurrency': ethNairaPrice.toStringAsFixed(2),
                          'symbol': 'ETH',
                          'price': ethUsdPrice,
                          'nairaRate': nairaRate,
                        },
                        {
                          'walletName': 'XRP Wallet',
                          'logo': 'assets/images/ripple.png',
                          'balance': xrpBalance.toString(),
                          'otherCurrency': xrpNairaPrice.toStringAsFixed(2),
                          'symbol': 'XRP',
                          'price': xrpUsdPrice,
                          'nairaRate': nairaRate,
                        },
                        {
                          'walletName': 'BCH Wallet',
                          'logo': 'assets/images/bitcoin_cash.png',
                          'balance': bchBalance.toString(),
                          'otherCurrency': bchNairaPrice.toStringAsFixed(2),
                          'symbol': 'BCH',
                          'price': bchUsdPrice,
                          'nairaRate': nairaRate,
                        },
                        {
                          'walletName': 'LTC Wallet',
                          'logo': 'assets/images/litcoin.jpg',
                          'balance': ltcBalance.toString(),
                          'otherCurrency': ltcNairaPrice.toStringAsFixed(2),
                          'symbol': 'LTC',
                          'price': ltcUsdPrice,
                          'nairaRate': nairaRate,
                        },
                        {
                          'walletName': 'TRX Wallet',
                          'logo': 'assets/images/tron.jpg',
                          'balance': trxBalance.toString(),
                          'otherCurrency': trxNairaPrice.toStringAsFixed(2),
                          'symbol': 'TRX',
                          'price': trxUsdPrice,
                          'nairaRate': nairaRate,
                        },
                      ];

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UtilityBillsScreen(
                            walletList: walletList,
                          ),
                        ),
                      );
                      setState(() {
                        _loader3 = false;
                      });
                    });
                  }
                } else {
                  Navigator.pushNamed(context, 'sign_up');
                  setState(() {
                    _loader3 = false;
                  });
                }
              },
             child: Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 15),
                 color: lightgreen,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ListTile(
                          leading: Image.asset(
                            'assets/images/utility-min.png',
                            height: 30,
                            width: 30,
                          ),
                          title: Text('Utility Bill'),
                           subtitle: Text('Pay for your electricity bills'),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Visibility(
                        child: LinearProgressIndicator(
                          minHeight: 6,
                        ),
                        visible: _loader3 ? true : false,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),

            InkWell(
              onTap: () async {
                setState(() {
                  _loader4 = true;
                });
                dynamic user = await AuthService().getUserDataById();

                if (currentUser != null) {
                  if (!user.containsKey('userName')) {
                    Navigator.pushNamed(context, 'set_up');
                    setState(() {
                      _loader4 = false;
                    });
                  } else {
                    users = await AuthService().getUserDataById();
                    dynamic naira1 = await GetNairaRate().getNairaRate();
                    nairaRate = (naira1['buy_rate']).toStringAsFixed(1);

                    cbnNairaRate = (naira1['cbn_rate']).toStringAsFixed(1);

                    nairaBalance = users['naira'].toString();
                    btcBalance = users['BTC'].toString();
                    ethBalance = users['ETH'].toString();
                    xrpBalance = users['XRP'].toString();
                    bchBalance = users['BCH'].toString();
                    ltcBalance = users['LTC'].toString();
                    trxBalance = users['TRX'].toString();

                    getCurrencies =
                        Provider.of<GetCurrencies>(context, listen: false);
                    getCurrencies.refreshCurrencies().then((value) {
                      currencies = value;
                      price.clear();
                      currencies.forEach((element) {
                        dynamic pri = json.decode(element['price']);
                        price.add(pri);
                      });

                      btcUsdPrice = price[0];
                      ethUsdPrice = price[1];
                      xrpUsdPrice = price[2];
                      ltcUsdPrice = price[3];
                      bchUsdPrice = price[4];
                      trxUsdPrice = price[5];

                      nairaUsdEquivalance =
                          double.parse(nairaBalance) / double.parse(nairaRate);

                      btcNairaPrice = (double.parse(btcBalance) * btcUsdPrice) *
                          double.parse(nairaRate);

                      ethNairaPrice = (double.parse(ethBalance) * ethUsdPrice) *
                          double.parse(nairaRate);
                      xrpNairaPrice = (double.parse(xrpBalance) * xrpUsdPrice) *
                          double.parse(nairaRate);
                      ltcNairaPrice = (double.parse(ltcBalance) * ltcUsdPrice) *
                          double.parse(nairaRate);
                      bchNairaPrice = (double.parse(bchBalance) * bchUsdPrice) *
                          double.parse(nairaRate);
                      trxNairaPrice = (double.parse(trxBalance) * trxUsdPrice) *
                          double.parse(nairaRate);

                      print('mine$btcNairaPrice');
                      print(nairaUsdEquivalance);
                      setState(() {
                        listIsEmpty = false;
                      });
                      dynamic naira = double.parse(nairaBalance);

                      walletList = [
                        {
                          'walletName': 'Naira Wallet',
                          'logo': 'assets/images/index.png',
                          'balance': naira.toStringAsFixed(2),
                          'otherCurrency':
                              nairaUsdEquivalance.toStringAsFixed(2),
                          'symbol': 'USD',
                          'price': nairaRate,
                          'nairaRate': nairaRate,
                        },
                        {
                          'walletName': 'BTC Wallet',
                          'logo': 'assets/images/btc.png',
                          'balance': btcBalance.toString(),
                          'otherCurrency': btcNairaPrice.toStringAsFixed(2),
                          'symbol': 'BTC',
                          'price': btcUsdPrice,
                          'nairaRate': nairaRate,
                        },
                        {
                          'walletName': 'ETH Wallet',
                          'logo': 'assets/images/etherium.jpg',
                          'balance': ethBalance.toString(),
                          'otherCurrency': ethNairaPrice.toStringAsFixed(2),
                          'symbol': 'ETH',
                          'price': ethUsdPrice,
                          'nairaRate': nairaRate,
                        },
                        {
                          'walletName': 'XRP Wallet',
                          'logo': 'assets/images/ripple.png',
                          'balance': xrpBalance.toString(),
                          'otherCurrency': xrpNairaPrice.toStringAsFixed(2),
                          'symbol': 'XRP',
                          'price': xrpUsdPrice,
                          'nairaRate': nairaRate,
                        },
                        {
                          'walletName': 'BCH Wallet',
                          'logo': 'assets/images/bitcoin_cash.png',
                          'balance': bchBalance.toString(),
                          'otherCurrency': bchNairaPrice.toStringAsFixed(2),
                          'symbol': 'BCH',
                          'price': bchUsdPrice,
                          'nairaRate': nairaRate,
                        },
                        {
                          'walletName': 'LTC Wallet',
                          'logo': 'assets/images/litcoin.jpg',
                          'balance': ltcBalance.toString(),
                          'otherCurrency': ltcNairaPrice.toStringAsFixed(2),
                          'symbol': 'LTC',
                          'price': ltcUsdPrice,
                          'nairaRate': nairaRate,
                        },
                        {
                          'walletName': 'TRX Wallet',
                          'logo': 'assets/images/tron.jpg',
                          'balance': trxBalance.toString(),
                          'otherCurrency': trxNairaPrice.toStringAsFixed(2),
                          'symbol': 'TRX',
                          'price': trxUsdPrice,
                          'nairaRate': nairaRate,
                        },
                      ];

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BetSubScreen(
                            walletList: walletList,
                          ),
                        ),
                      );
                      setState(() {
                        _loader4 = false;
                      });
                    });
                  }
                } else {
                  Navigator.pushNamed(context, 'sign_up');
                  setState(() {
                    _loader4 = false;
                  });
                }
              },
            child: Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 15),
                 color: lightgreen,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ListTile(
                          leading: Image.asset(
                            'assets/images/34.png',
                            height: 30,
                            width: 30,
                          ),
                          title: Text('Bet subscription'),
                          subtitle: Text('Fund Your bet account here'),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Visibility(
                        child: LinearProgressIndicator(
                          minHeight: 6,
                        ),
                        visible: _loader4 ? true : false,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
