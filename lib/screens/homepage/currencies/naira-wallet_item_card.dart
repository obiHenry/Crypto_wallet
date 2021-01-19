
import 'package:flutter/material.dart';

class NairaWalletCard extends StatefulWidget {
  final currency;
  final Function press;
  final  nairaRate;

  final Widget widget;
  NairaWalletCard({this.currency, this.press, this.widget, this.nairaRate});
  @override
  _NairaWalletCardState createState() => _NairaWalletCardState();
}

// dynamic naira;
// getNaira() async {
//   dynamic na = await NairaEquivalence().getNairaEquivalence();
//  na; return naira =
// }

class _NairaWalletCardState extends State<NairaWalletCard> {
  // dynamic naira1;
  // getRate() async {}
  // // @override
  // // void initState() {
  // //   getRate();
  // //   super.initState();
  // // }
  // dynamic nairaRate;
  // @override
  // void didChangeDependencies() async {
  //   naira1 = await GetNairaRate().getNairaRate();

  //   // naira1 = naira;
  //   // print('anything${naira1['message']['nairaRate'].toStringAsFixed(1)}');
  //   nairaRate = (naira1['message']['nairaRate']).toStringAsFixed(1);
  //   // print(widget.nairaRate);
  //   // getRate();
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    // dynamic rate = nairaRate;
    // print(rate);
    // dynamic naira = double.parse(naira1['message']['nairaRate']);
    // if (naira1 == null) {
    //   return Container();
    // } else {
    //   widget.nairaRate = (naira1['message']['nairaRate']).toStringAsFixed(1);
    //   print(widget.nairaRate);
    // }

    return GestureDetector(
      onTap: widget.press,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 20),
        elevation: 0,
              child: Stack(children: [
          Container(
            // height: 80,
            margin: EdgeInsets.symmetric(horizontal: 20, ),
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
                        child: Image.asset('assets/images/index.png'),
                        //  Image.network(widget.currency['logo_url']),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Naira wallet',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      widget.nairaRate != null
                          ? Text(
                              '₦${widget.nairaRate}',
                              // 'NGN${naira1['nairaRate']}',
                              // ' NGN 410',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500),
                            )
                          : Text('Loading...'),
                      Text(
                        '\~ \$1 ',
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
      ),
    );
  }
}
