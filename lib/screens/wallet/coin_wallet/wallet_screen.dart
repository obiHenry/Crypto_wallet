import 'dart:io';

import 'package:Crypto_wallet/screens/wallet/coin_wallet/recieve_coin/buy_coin_screen.dart';
import 'package:Crypto_wallet/screens/wallet/coin_wallet/recieve_coin/recieve_coin_screen.dart';
import 'package:Crypto_wallet/screens/wallet/coin_wallet/send_coin/sell_coin_screen.dart';
import 'package:Crypto_wallet/screens/wallet/coin_wallet/send_coin/send_coin_screen.dart';
import 'package:Crypto_wallet/services/auth.dart';
import 'package:Crypto_wallet/services/dialog_service.dart';
import 'package:Crypto_wallet/services/price_formatter.dart';
import 'package:Crypto_wallet/services/recieve_coin.dart';
import 'package:Crypto_wallet/screens/homepage/home_page_screen.dart';
import 'package:Crypto_wallet/screens/settings/users_settings_screen.dart';
import 'package:Crypto_wallet/screens/transactions/transaction_list_screen.dart';
import 'package:Crypto_wallet/screens/vtu_services/vtu_services_screen.dart';
import 'package:Crypto_wallet/widgets/alert_sheet.dart';
import 'package:Crypto_wallet/widgets/bottom_navigation_view.dart';
import 'package:Crypto_wallet/widgets/transaction_item_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../shared/shared.dart';

class Wallet extends StatefulWidget {
  final currency;
  final image;
  final balance;
  final user;
  final transactions;
  final nairaVeloceSellRate;
  final nairaVeloceBuyRate;

  Wallet(
      {this.currency,
      this.image,
      this.balance,
      this.user,
      this.transactions,
      this.nairaVeloceSellRate,
      this.nairaVeloceBuyRate});
  static const routeName = '/wallet';
  _WalletState createState() => _WalletState();
}

bool _isConnected = true;
bool listIsEmpty = false;

class _WalletState extends State<Wallet> {
  bool _loader = false;
  bool _loader1 = false;
  bool _loading = true;

  final List<Map<String, Object>> _pages = [
    {
      'page': HomePageScreen(),
      'title': 'HomePage',
    },
    {
      'page': VtuServicesScreen(),
      'title': 'wallets',
    },
    {
      'page': TransactionListScreen(),
      'title': 'News',
    },
    {
      'page': UsersSettingsScreen(),
      'title': 'Profile',
    },
  ];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _showBottomSheet(Widget widget) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        )),
        isScrollControlled: true,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: widget,
            // behavior: HitTestBehavior.opaque,
          );
        });
  }

  List transactionList = [];

  @override
  void didChangeDependencies() async {
    _checkInternet().then((value) {
      //that is there is internet connection
      if (value) {
        if (mounted) {
          setState(() {
            // transactionList.clear();
            transactionList = widget.transactions;
            _isConnected = true;
            _loading = false;
            print('anything$transactionList');
            if (transactionList.length < 1) {
              listIsEmpty = true;
              _loading = true;
            } else {
              listIsEmpty = false;
              _loading = false;
            }
          });

          print('anything');

          AuthService()
              .updateWallet(widget.currency['price'],
                  '${widget.currency['currency']}UsdPrice')
              .then((value) {});
        }
      } else {
        if (mounted) {
          setState(() {
            _isConnected = false;
            _loading = true;
          });
        }
      }
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    dynamic balance = double.parse(widget.balance);
    print(balance);
    var price = double.parse(widget.currency['price']);
    var convert = price.toStringAsFixed(2);
    dynamic usdEqui = (balance * price) / 1;

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
                  colors: [yellowStartWallet, yellowEndWallet],
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
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset('assets/images/back.svg'),
                            ),
                            Text(
                              "${widget.currency['name']} Wallet",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            SvgPicture.asset('assets/images/back.svg',
                                color: Colors.transparent),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      Text(
                        'Avaliable Balance :',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 20),

                      container(balance.toStringAsFixed(8), widget.currency),
                      Text(
                        "\~ \$${formatPrice(usdEqui.toStringAsFixed(2))}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      // SizedBox(height: 30),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        // height: 50,
                        alignment: Alignment.center,
                        // decoration: BoxDecoration(
                        //   color: Colors.white24,
                        //   borderRadius: BorderRadius.all(
                        //     Radius.circular(10),
                        //   ),
                        // ),
                        child: Text(
                          '  1 ${widget.currency['currency']} \~ \$${formatPrice(convert)}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(height: 30),

                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            !_loader1
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        _loader1 = true;
                                      });
                                      if (balance <= 0) {
                                        _showBottomSheet(AlertSheet(
                                          text1:
                                              'No coin was found in your wallet',
                                          text2: 'you can buy from us',
                                          text3: 'Buy now',
                                          press: () {
                                            _showBottomSheet(BuyCoinScreen(
                                              currency: widget.currency,
                                              balance: widget.balance,
                                              user: widget.user,
                                              nairaRate:
                                                  widget.nairaVeloceSellRate,
                                            ));
                                          },
                                        ));
                                        Fluttertoast.showToast(
                                            msg:
                                                'You don\'t have any money to send ',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            backgroundColor: Colors.black,
                                            textColor: Colors.white);
                                        setState(() {
                                          _loader1 = false;
                                        });
                                      } else {
                                        _showBottomSheet(SendCoinScreen(
                                          currency: widget.currency,
                                          balance: widget.balance,
                                          user: widget.user,
                                        ));
                                        setState(() {
                                          _loader1 = false;
                                        });
                                      }
                                    },
                                    splashColor: yellowEnd,
                                    child: Container(
                                      // width: MediaQuery.of(context).size.width *
                                      //     0.35,
                                      height: 50,
                                      alignment: Alignment.center,
                                      // decoration: BoxDecoration(
                                      //   color: Colors.white24,
                                      //   borderRadius: BorderRadius.all(
                                      //     Radius.circular(10),
                                      //   ),
                                      // ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          SvgPicture.asset(
                                              'assets/images/send.svg'),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            child: Text(
                                              'Send',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : CircularProgressIndicator(),
                            SizedBox(width: 30),
                            !_loader
                                ? InkWell(
                                    splashColor: yellowEnd,
                                    onTap: () async {
                                      setState(() {
                                        _loader = true;
                                      });

                                      dynamic userId =
                                          FirebaseAuth.instance.currentUser.uid;
                                      print(widget.currency['currency']);
                                      dynamic value =
                                          await RecieveCoin().recieveCoin(
                                        widget.currency['currency'],
                                        userId,
                                        widget.user['email'],
                                      );

                                      if (value['status']) {
                                        _showBottomSheet(RecieveCoinScreen(
                                            currency: widget.currency,
                                            value: value));
                                      } else {
                                        String msg = (value['message'] !=
                                                    null &&
                                                value['message'].isNotEmpty)
                                            ? value['message']
                                            : 'An unknown error occured; retry';
                                        DialogService().getSnackBar(
                                          context,
                                          msg,
                                          Colors.red,
                                        );
                                      }
                                      setState(() {
                                        _loader = false;
                                      });

                                      // print('dkjfkz$value');
                                    },
                                    child: Container(
                                      // width: MediaQuery.of(context).size.width *
                                      //     0.35,
                                      height: 50,
                                      alignment: Alignment.center,

                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          SvgPicture.asset(
                                              'assets/images/receive.svg'),
                                          Container(
                                            child: Text(
                                              'Receive',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : CircularProgressIndicator(),
                            SizedBox(
                              width: 30,
                            ),
                            InkWell(
                              onTap: () {
                                _showBottomSheet(BuyCoinScreen(
                                  currency: widget.currency,
                                  balance: widget.balance,
                                  user: widget.user,
                                  nairaRate: widget.nairaVeloceSellRate,
                                ));
                              },
                              child: Container(
                                // width: MediaQuery.of(context).size.width *
                                //     0.35,
                                height: 50,
                                alignment: Alignment.center,

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: 50,
                                      height: 30,
                                      child:
                                          Image.asset('assets/images/buy.png'),
                                    ),
                                    // SizedBox(
                                    //   width: 5,
                                    // ),
                                    Container(
                                      child: Text(
                                        'Buy',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            InkWell(
                              onTap: () {
                                _showBottomSheet(SellCoinScreen(
                                  currency: widget.currency,
                                  balance: widget.balance,
                                  user: widget.user,
                                  nairaRate: widget.nairaVeloceBuyRate,
                                ));
                              },
                              child: Container(
                                height: 50,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: 40,
                                      height: 30,
                                      child: Image.asset(
                                          'assets/images/selling.png'),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      child: Text(
                                        'Sell',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      SizedBox(height: 40),
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
            Container(
              padding: EdgeInsets.only(left: 15, top: 12),
              child: Text(
                'Transaction List',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.43,
              child: RefreshIndicator(
                child: !_loading
                    ?
                    //

                    ListView.builder(
                        itemCount: transactionList.length == 0
                            ? 0
                            : transactionList.length,
                        itemBuilder: (context, index) {
                          return TransactionItemCard(
                              transaction: transactionList[index],
                              walletLogo: Image.asset(widget.image));
                        })
                    : SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Container(
                          height: MediaQuery.of(context).size.height * .43,
                          child: _showLoader(),
                        ),
                      ),
                onRefresh: () async {
                  if (await _checkInternet()) {
                    List list = widget.transactions;
                    // print(list);
                    if (mounted) {
                      setState(() {
                        //  transactionList.clear();
                        //  _loading = true;
                        transactionList = list;
                        if (transactionList.length < 1) {
                          listIsEmpty = true;
                          _loading = true;
                        } else if (transactionList.length > 1) {
                          _loading = false;
                        }
                        // _isConnected = true;

                        print(transactionList);
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
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        pageIndex: _selectedPageIndex,
        selectPage: _selectPage,
      ),
    );
  }
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
  print('somethig');

  if (!_isConnected) {
    print('something');
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

    // height: 100,
    // width: 100,

  } else {
    print('something');
    return listIsEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/no_transaction.gif'),
              // SizedBox(
              //   height: 18,
              // ),
              Text(
                'No Transaction yet',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Any transaction you make will appear here',
                style: TextStyle(
                  fontSize: 17,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        : Center(
            child: SizedBox(
              child: CircularProgressIndicator(),
              height: 100,
              width: 100,
            ),
          );
  }
}

Widget container(balance, currency) {
  return Container(
    // dynamic users = await auth.getUserDataById();

    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          balance,
          // '\$32.026,23',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          currency['currency'],
          // '\$32.026,23',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}

class ChartLineBigPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paintLine = Paint()
      ..color = yellowChartLine
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    var paintCircle = Paint()..color = yellowChartLine;

    var paintCircleStroke = Paint()
      ..color = Color.fromRGBO(228, 228, 228, 1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    var path = Path()
      ..moveTo(0, size.height * 0.7)
      ..quadraticBezierTo(
          size.width * 0.09, 0, size.width * 0.2, size.height * 0.7)
      ..quadraticBezierTo(
          size.width * 0.28, 130, size.width * 0.4, size.height * 0.8)
      ..quadraticBezierTo(
          size.width * 0.5, 45, size.width * 0.6, size.height * 0.8)
      ..quadraticBezierTo(
          size.width * 0.7, 120, size.width * 0.8, size.height * 0.6)
      ..quadraticBezierTo(
          size.width * 0.85, 10, size.width * 0.95, size.height * 0.25)
      ..quadraticBezierTo(
          size.width * 0.99, 30, size.width * 1, size.height * 0.20);

    canvas.drawPath(path, paintLine);
    canvas.drawCircle(
        Offset(size.width * 0.85, size.height * 0.29), 10.0, paintCircleStroke);
    canvas.drawCircle(
        Offset(size.width * 0.85, size.height * 0.29), 6.0, paintCircle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
