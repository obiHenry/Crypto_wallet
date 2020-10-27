import 'package:Crypto_wallet/services/dialog_service.dart';
import 'package:Crypto_wallet/services/recieve_coin.dart';
import 'package:Crypto_wallet/screens/homepage/home_page_screen.dart';
import 'package:Crypto_wallet/screens/profile_screen/profile_screen.dart';
import 'package:Crypto_wallet/screens/transactions/transaction_list_screen.dart';
import 'package:Crypto_wallet/screens/vtu_services/vtu_services_screen.dart';
import 'package:Crypto_wallet/widgets/bottom_navigation_view.dart';
import 'package:Crypto_wallet/widgets/recieve_coin/recieve_coin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../shared/shared.dart';

class Wallet extends StatefulWidget {
  final currency;
  final image;
  final balance;
  final user;

  Wallet({this.currency, this.image, this.balance, this.user});
  static const routeName = '/wallet';
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  bool _loader = false;

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
      'page': ProfileScreen(),
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

  @override
  Widget build(BuildContext context) {
    var price = double.parse(widget.currency['price']);
    var convert = price.toStringAsFixed(2);
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
                              widget.currency['name'],
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
                      SizedBox(height: 30),
                      CircleAvatar(
                        child: Image.asset(widget.image),
                        //  Image.network(widget.currency['logo_url']),
                      ),
                      SizedBox(height: 30),
                      container(widget.balance, widget.currency),
                      SizedBox(height: 30),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          '  1 ${widget.currency['currency']} = \$$convert',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
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
            ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          _showBottomSheet(widget);
                        },
                        splashColor: yellowEnd,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5.0,
                                spreadRadius: 1.0,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              SvgPicture.asset('assets/images/send.svg'),
                              Container(
                                child: Text(
                                  'Send',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      !_loader
                          ? InkWell(
                              splashColor: yellowEnd,
                              onTap: () async {
                                setState(() {
                                  _loader = true;
                                });

                                dynamic userId =
                                    FirebaseAuth.instance.currentUser.uid;

                                dynamic value = await RecieveCoin().recieveCoin(
                                  widget.currency['currency'],
                                  userId,
                                  widget.user['email'],
                                );
                                setState(() {
                                  _loader = false;
                                });

                                if (value['status']) {
                                  _showBottomSheet(RecieveCoinScreen(
                                      currency: widget.currency, value: value));
                                } else {
                                  String msg = (value['message'] != null &&
                                          value['message'].isNotEmpty)
                                      ? value['message']
                                      : 'An unknown error occured; retry';
                                  DialogService().getSnackBar(
                                    context,
                                    msg,
                                    Colors.red,
                                  );
                                }

                                // print('dkjfkz$value');
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.5,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    SvgPicture.asset(
                                        'assets/images/receive.svg'),
                                    Container(
                                      child: Text(
                                        'Receive',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : CircularProgressIndicator(),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
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
          currency['currency'],
          // '\$32.026,23',
          style: TextStyle(
              color: Colors.white, fontSize: 32, fontWeight: FontWeight.w500),
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
