import 'dart:io';

import 'package:Crypto_wallet/screens/wallet/naira_wallet/deposit_naira-screen.dart';
import 'package:Crypto_wallet/services/auth.dart';
import 'package:Crypto_wallet/services/get_currency.dart';
import 'package:Crypto_wallet/services/get_naira_rate.dart';
import 'package:Crypto_wallet/services/price_formatter.dart';
import 'package:Crypto_wallet/theme/light_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
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
  @override
  void didChangeDependencies() async {
    dynamic user = await AuthService().getUserDataById();
    dynamic naira1 = await GetNairaRate().getNairaRate();

    nairaRate = (naira1['current-price'].toString());
    dynamic rate = double.parse(nairaRate);

    dynamic naira = user['naira'];
    dynamic balance = double.parse(naira);
    nairaBalance = balance.toStringAsFixed(2);
    dynamic usd = balance / rate;
    usdEqui = usd.toStringAsFixed(2);
    print('anyting$usdEqui');

    print(nairaBalance);
    //  void currency() {

    Locale locale = Localizations.localeOf(context);
    
    // String  f = CurrencyPickerUtils.getCountryByIsoCode('PK').currencyCode.toString();
    var format = NumberFormat.simpleCurrency(locale: Platform.localeName);
    print("CURRENCY SYMBOL ${format.currencySymbol}"); // $
    print("CURRENCY NAME ${format.currencyName}"); // USD
// }
    super.didChangeDependencies();
  }

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
              height: MediaQuery.of(context).size.height * .3,
              margin: EdgeInsets.only(top: 0, left: 0, right: 0),
              width: double.infinity,
              decoration: BoxDecoration(
                // LightColor.navyBlue1
                color: Colors.green,
                // LightColor.navyBlue1
                // blueMain
                gradient: LinearGradient(
                  // yellowStartWallet, yellowEndWallet
                  colors: [
                    LightColor.navyBlue1,
                    LightColor.navyBlue2,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment(0.6, 0.3),
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),

                  // Radius.circular(40),
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
                        Radius.circular(40),
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
                              Text(
                                '#${formatPrice(nairaBalance)}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
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
                              Text(
                                '\$${formatPrice(usdEqui)}',
                                // '4.2432232 BTC',
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
                                          builder: (context) =>
                                              DepositMoney()));
                                },
                                child: Container(
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
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 6),
            Container(
                // margin: EdgeInsets.symmetric(horizontal: 20),

                height: MediaQuery.of(context).size.height * 0.5,
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
