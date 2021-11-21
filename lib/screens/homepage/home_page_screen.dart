
import 'package:Crypto_wallet/screens/wallet/naira_wallet/deposit_naira-screen.dart';
import 'package:Crypto_wallet/services/api_services.dart';
import 'package:Crypto_wallet/services/auth.dart';
import 'package:Crypto_wallet/services/price_formatter.dart';
import 'package:Crypto_wallet/theme/light_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../shared/shared.dart';
import 'currencies/currencies_list.dart';

class HomePageScreen extends StatefulWidget {
  static const routeName = '/homepage';
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  dynamic nairaBalance;
  dynamic nairaRate;
  dynamic usdEqui;
  dynamic user;
  dynamic naira1;
  dynamic rate;
  dynamic naira;
  dynamic balance;
  dynamic usd;
  bool balanceAvailable = false;

  @override
  void didChangeDependencies() async {
    AuthService().getUserDataById().then((value) {
      if (value != null) {
        user = value;
        AuthService().getNairaRate().then((value) {
          naira1 = value;
          nairaRate = (naira1['buyRate'].toString());
          if (user.containsKey('naira')) {
            if(mounted){
               naira = user['naira'];

            rate = double.parse(nairaRate);
            balance = double.parse(naira);
            nairaBalance = balance.toStringAsFixed(2);
            usd = balance / rate;
            usdEqui = usd.toStringAsFixed(2);
            setState(() {
              balanceAvailable = true;
            });

            print('anyting$usdEqui');
            print(nairaBalance);
            }
           
          }
        });
      }
    });

  
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // getBalance();
    print('anyting$usdEqui');

    print(nairaBalance);
    ChangeNotifierProvider.value(value: ApiServices());

    return Scaffold(
      backgroundColor: lightBlueStart,
      body:

          //  SingleChildScrollView(
          // child:
          Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[ 
          Container(
            decoration: BoxDecoration(
              color: yellowEndWallet,
              gradient: LinearGradient(
                // yellowStartWallet, yellowEndWallet
                colors: [
                  // LightColor.navyBlue2,
                  blueMain,
                  // Colors.green,
                  blueMain,
                  // LightColor.navyBlue2,
                  // Colors.lightGreen,
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
                            'My Wallets',
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
          // Container(
          //   //  height: MediaQuery.of(context).size.height*0.03,
          //   margin: EdgeInsets.only(top: 50, left: 20),
          //   child: Text('My Wallets',
          //       style: TextStyle(
          //           color: LightColor.navyBlue2,
          //           fontSize: 21,
          //           fontWeight: FontWeight.w500)),
          // ),
          SizedBox(height: 20),
          Container(
            height: MediaQuery.of(context).size.height * .3,
            margin: EdgeInsets.only(top: 0, left: 10, right: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              // LightColor.navyBlue1
              color: Colors.green,
              // LightColor.navyBlue1
              // blueMain
              gradient: LinearGradient(
                // yellowStartWallet, yellowEndWallet
                colors: [
                  blueMain,
                  blueMain,
                  // LightColor.navyBlue2,
                  // LightColor.navyBlue2,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment(0.6, 0.3),
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),

                // Radius.circular(40),
                // Radius.circular(50),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Container(
                //   alignment: Alignment.bottomLeft,
                //    margin: EdgeInsets.only(top: 30, left: 20),
                //   child: Text('Wallets', style: TextStyle(color: Colors.white,fontSize: 21))),
                Container(
                  margin: EdgeInsets.only(top: 25, right: 30, left: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [blueMain, blueMain],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Naira Wallet balance',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            Text(
                              'NAIRA',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            balanceAvailable
                                ? Text(
                                    '₦${formatPrice(nairaBalance)}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500),
                                  )
                                : Text(
                                    '₦0.00...',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500),
                                  ),
                            // Transform(
                            //   transform: Matrix4.identity()..scale(0.9),
                            //   alignment: Alignment.bottomRight,
                            //   child: Chip(
                            //     backgroundColor: chipColorGreen,
                            //     labelPadding:
                            //         EdgeInsets.symmetric(horizontal: 12),
                            //     label: Text(
                            //       '+ 3.5%',
                            //       overflow: TextOverflow.ellipsis,
                            //       style: TextStyle(
                            //           color: Colors.white,
                            //           fontSize: 15,
                            //           fontWeight: FontWeight.w500),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            balanceAvailable
                                ? Text(
                                    '\$${formatPrice(usdEqui)}',
                                    // '4.2432232 BTC',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  )
                                : Text(
                                    '\$0.00...',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DepositMoney(
                                            balance: nairaBalance,
                                            user: user,)));
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: blueMain,
                                  // walletAddButtomColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 4,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 7.0,
                                      spreadRadius: 1.0,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  height: 15,
                  margin: EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: yellowSecondContainer,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 25, top: 8),
            child: Text(
              'Currencies',
              style: TextStyle(
                color: LightColor.navyBlue2,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 6),
          Container(
              // margin: EdgeInsets.symmetric(horizontal: 20),

              height: MediaQuery.of(context).size.height * 0.43,
              child: CurrenciesList()),
          // _transectionList(),
        ],
      ),
      // ),
      
    );
  }
}

class ChartLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paintLine = Paint()
      ..color = yellowChartLine
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    var paintCircle = Paint()..color = yellowChartLine;

    var paintCircleStroke = Paint()
      ..color = Colors.black12
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    var path = Path()
      ..moveTo(0, size.height * 0.7)
      ..quadraticBezierTo(
          size.width * 0.09, 0, size.width * 0.2, size.height * 0.7)
      ..quadraticBezierTo(
          size.width * 0.3, 90, size.width * 0.4, size.height * 0.8)
      ..quadraticBezierTo(
          size.width * 0.5, 50, size.width * 0.6, size.height * 0.8)
      ..quadraticBezierTo(
          size.width * 0.75, 85, size.width * 0.8, size.height * 0.6)
      ..quadraticBezierTo(
          size.width * 0.85, 0, size.width * 0.95, size.height * 0.25)
      ..quadraticBezierTo(
          size.width * 0.99, 30, size.width * 1, size.height * 0.20);

    canvas.drawPath(path, paintLine);
    canvas.drawCircle(
        Offset(size.width * 0.6, size.height * 0.79), 2.0, paintCircle);
    canvas.drawCircle(
        Offset(size.width * 0.6, size.height * 0.79), 2.0, paintCircleStroke);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
