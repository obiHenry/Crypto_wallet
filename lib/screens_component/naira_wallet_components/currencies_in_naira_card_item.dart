import 'package:Crypto_wallet/services/price_formatter.dart';
import 'package:Crypto_wallet/shared/app_colors.dart';
import 'package:flutter/material.dart';

class CurrencyInNaraCard extends StatefulWidget {
  final currency;
  final Function press;
  final color;
  final Widget widget;
  final nairaRate;
  CurrencyInNaraCard({
    this.currency,
    this.press,
    this.color,
    this.widget,
    this.nairaRate,
  });
  @override
  _CurrencyInNaraCardState createState() => _CurrencyInNaraCardState();
}

class _CurrencyInNaraCardState extends State<CurrencyInNaraCard> {
  @override
  Widget build(BuildContext context) {
    dynamic usdPrice = double.parse(widget.currency['price']);
    dynamic nairaRate = double.parse(widget.nairaRate);
    dynamic nairaPrice = usdPrice * nairaRate;
    var convert = nairaPrice.toStringAsFixed(2);
    dynamic percent = double.parse(widget.currency['1d']['price_change_pct']);

    return GestureDetector(
      onTap: widget.press,
      child: Stack(children: [
        Container(
          height: 85,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      child: Image.asset(widget.color),
                      //  Image.network(widget.currency['logo_url']),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.currency['name'],
                          style: TextStyle(
                              fontSize: 15,
                              color: blueMain,
                              fontWeight: FontWeight.w500),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: percent < 0 ? Colors.red : chipColorGreen,
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          child: Text(
                            // 'rygfyub',
                            widget.currency['1d']['price_change_pct'],
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      // 'sdsd',
                      '\₦${formatPrice(convert)}',
                      style: TextStyle(
                          fontSize: 22,
                          color: blueMain,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '\~ 1 ${widget.currency['currency']}',
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),

          child: Positioned(
            bottom: 6,
            right: 10,
            left: 10,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 20,
              ),
              width: 300,
              // color: Colors.black54,
              child: widget.widget,

              //  Text(
              //   title,
              //   style: TextStyle(fontSize: 20, color: Colors.white),
              //   softWrap: true,
              //   overflow: TextOverflow.fade,
              // ),
            ),
          ),
        )
      ]),
    );
  }
}
