import 'dart:io';

import 'package:Crypto_wallet/screens/wallet/naira_wallet/deposit_naira-screen.dart';
import 'package:Crypto_wallet/screens/wallet/naira_wallet/transfer_naira_screen.dart';
import 'package:Crypto_wallet/services/price_formatter.dart';
import 'package:Crypto_wallet/shared/app_colors.dart';
import 'package:Crypto_wallet/widgets/bottom_navigation_view.dart';
import 'package:Crypto_wallet/widgets/transaction_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NairaWalletScreen extends StatefulWidget {
  final nairaBalance;
  final user;
  final nairaRate;
  final List nairatransactionList;

  NairaWalletScreen(
      {this.nairaBalance,
      this.user,
      this.nairaRate,
      this.nairatransactionList});
  static const routeName = '/wallet';
  _NairaWalletScreenState createState() => _NairaWalletScreenState();
}

bool _isConnected = true;
bool listIsEmpty = false;

class _NairaWalletScreenState extends State<NairaWalletScreen> {
  bool _loading = true;
  //  final List<Map<String, Object>> _pages = [
  //   {
  //     'page': HomePageScreen(),
  //     'title': 'HomePage',
  //   },
  //   {
  //     'page': VtuServicesScreen(),
  //     'title': 'wallets',
  //   },
  //   {
  //     'page': TransactionListScreen(),
  //     'title': 'News',
  //   },
  //   {
  //     'page': ProfileScreen(),
  //     'title': 'Profile',
  //   },
  // ];
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

  // bool _loading = true;

  List transactionList = [];

  @override
  void didChangeDependencies() {
    _checkInternet().then((value) {
      //that is there is internet connection
      if (value) {
        if (mounted) {
          setState(() {
            // transactionList.clear();
            transactionList = widget.nairatransactionList;
            _isConnected = true;
            _loading = false;
            print('anything$transactionList');
            if (transactionList.length < 1) {
              listIsEmpty = true;
              _loading = true;
            } else {}
          });

          print('anything');
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
    dynamic nairaRate = double.parse(widget.nairaRate);
    dynamic nairabalance = double.parse(widget.nairaBalance);
    dynamic usdEqui = (1 * nairabalance) / nairaRate;
    return Scaffold(
      backgroundColor: lightBlueStart,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: yellowEndWallet,
                gradient: LinearGradient(
                  // yellowStartWallet, yellowEndWallet
                  colors: [
                    Colors.green,
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
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset('assets/images/back.svg'),
                            ),
                            Text(
                              'Naira wallet',
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
                      Text(
                        'Avaliable Balance :',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "₦${formatPrice(nairabalance.toStringAsFixed(1))}",
                        // '\$32.026,23',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "\~ \$${formatPrice(usdEqui.toStringAsFixed(2))}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(
                          "₦${widget.nairaRate}  ~ \$1",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DepositMoney(balance: nairabalance.toString() , user: widget.user,)));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  '  Deposit',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TransferNairaScreen(balance: nairabalance.toString() , user: widget.user,)));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  '  Transfer',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ]),
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
              height: MediaQuery.of(context).size.height * 0.48,
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
                            walletLogo: Image.asset('assets/images/index.png')
                          );
                        })
                    : SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Container(
                          height: MediaQuery.of(context).size.height * .48,
                          child: _showLoader(),
                        ),
                      ),
                onRefresh: () async {
                  if (await _checkInternet()) {
                    List list = widget.nairatransactionList;
                    // print(list);
                    if (mounted) {
                      setState(() {
                        //  transactionList.clear();
                        //  _loading = true;
                        transactionList = list;
                        if(transactionList.length < 1){
                          listIsEmpty = true;
                        _loading = true;
                        }else if (transactionList.length > 1){
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
              SizedBox(
                height: 18,
              ),
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
              color: Colors.white, fontSize: 32, fontWeight: FontWeight.w500),
        ),
        Text(
          currency,
          // '\$32.026,23',
          style: TextStyle(
              color: Colors.white, fontSize: 32, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}
