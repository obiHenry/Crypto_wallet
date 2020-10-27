import 'package:Crypto_wallet/services/get_currency.dart';
import 'package:Crypto_wallet/widgets/currencies/currencies_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../shared/shared.dart';

class HomePageScreen extends StatefulWidget {
  static const routeName = '/homepage';
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    ChangeNotifierProvider.value(value: GetCurrencies());

    return Scaffold(
      backgroundColor: lightBlueStart,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 0, left: 10, right: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: blueMain,
                borderRadius: BorderRadius.all(
                  Radius.circular(40),
                  // Radius.circular(50),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 15, right: 30, left: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [yellowStart, yellowEnd],
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
                                'Current balance',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                              Text(
                                'USD',
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
                              Text(
                                '\$32.026',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 35,
                                    fontWeight: FontWeight.w500),
                              ),
                              Transform(
                                transform: Matrix4.identity()..scale(0.9),
                                alignment: Alignment.bottomRight,
                                child: Chip(
                                  backgroundColor: chipColorGreen,
                                  labelPadding:
                                      EdgeInsets.symmetric(horizontal: 12),
                                  label: Text(
                                    '+ 3.5%',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 35),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '4.2432232 BTC',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: walletAddButtomColor,
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
              padding: EdgeInsets.only(left: 25,top: 8),
              child: Text(
                'Currencies',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 6),
            Container(
                // margin: EdgeInsets.symmetric(horizontal: 20),

                height: MediaQuery.of(context).size.height * 0.45,
                child: CurrenciesList()),
            // _transectionList(),
          ],
        ),
      ),
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
