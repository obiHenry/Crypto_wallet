import 'package:Crypto_wallet/shared/CustomTextStyle.dart';
import 'package:Crypto_wallet/shared/app_colors.dart';
import 'package:Crypto_wallet/theme/light_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItemCard extends StatefulWidget {
  final transaction;
  final walletLogo;
  TransactionItemCard({this.transaction, this.walletLogo});
  @override
  _TransactionItemCardState createState() => _TransactionItemCardState();
}

bool coinisnull = false;
dynamic coinEqui;

class _TransactionItemCardState extends State<TransactionItemCard> {
  @override
  Widget build(BuildContext context) {
    final DateFormat format = DateFormat('MMM d, y hh:mm');
    dynamic naira = double.parse(widget.transaction['nairaEquivalence']);
    dynamic nairaEqui = naira.toStringAsFixed(2);
    String coinAmount = widget.transaction['coinEquivalance'];
    print(' come and eat ${coinAmount.toString()}');

    if (coinAmount.isEmpty) {
      setState(() {
        coinisnull = true;
      });
    } else {
      setState(() {
        coinisnull = false;
      });
      dynamic coin = double.parse(coinAmount);
      coinEqui = coin.toStringAsFixed(7);
    }

    return Container(
        // width: MediaQuery.of(context).size.width*0.5,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        height: 105,
        // color: Colors.white,
        // child: Center(
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              // decoration: BoxDecoration(
              //   color: LightColor.navyBlue2,
              //   borderRadius: BorderRadius.all(Radius.circular(10)),
              // ),
              child: Center(
                child: widget.walletLogo,
              ),
            ),

            //  CircleAvatar(
            //     backgroundColor: yellowStart,
            //     child: Text('NW',style: TextStyle(color: Colors.white),),
            //   ),
            SizedBox(
              width: 10,
            ),

            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: createRow(
                      widget.transaction['TransactionType'],
                      coinEqui,
                      widget.transaction['currency'],
                      '(₦$nairaEqui)',
                      Colors.black),
                ),

                //  Text(
                //   '${widget.transaction['TransactionType']} $coinEqui(NGN$nairaEqui)'),
                SizedBox(
                  height: 3,
                ),
                createItem('From:', widget.transaction['from'], Colors.black),
                // SizedBox(height: 5,),
                FittedBox(
                  child: createItem(
                      'To:  ', widget.transaction['to'], Colors.black),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: !widget.transaction['completed']
                        ? Colors.red
                        : chipColorGreen,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: !widget.transaction['completed']
                      ? Text(
                          // 'rygfyub',
                          'Pendening',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        )
                      : Text(
                          // 'rygfyub',
                          'Completed',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    alignment: Alignment.centerRight,
                    width: MediaQuery.of(context).size.width * 0.72,
                    child:
                        //  FittedBox(
                        // fit: ,
                        Text(format.format(
                            DateTime.parse(widget.transaction['createdAt']))),
                    // ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  createItem(String key, value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          key,
          style: TextStyle(color: color, fontSize: 15),
        ),
        Container(
          // width: 230,
          // child: Align(
          //   alignment: Alignment.centerRight,
          child: Text(
            value,
            // // '₦ $total',
            // style: CustomTextStyle.textFormFieldSemiBold.copyWith(
            //   // height: 1.5,
            //   // color: Colors.grey,
            //   // fontSize: 16,
            // ),
            // ),
          ),
        ),
      ],
    );
  }

  createRow(String key, value, value1, value2, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FittedBox(
          child: Text(
            key,
            style: CustomTextStyle.textFormFieldMedium
                .copyWith(color: color, fontSize: 17),
          ),
        ),
        SizedBox(
          width: 2,
        ),
        Container(
          child: !coinisnull
              ? Text(
                  value,
                  // '₦ $total',
                  style: CustomTextStyle.textFormFieldSemiBold.copyWith(
                    // height: 1.5,
                    // color: Colors.grey,
                    fontSize: 14,
                  ),
                )
              : Container(),
        ),
        value1 != null
            ? Text(
                value1,
                // '₦ $total',
                style: CustomTextStyle.textFormFieldSemiBold.copyWith(
                  // height: 1.5,
                  // color: Colors.grey,
                  fontSize: 14,
                ),
              )
            : Container(),
        Text(
          value2,
          // '₦ $total',
          style: CustomTextStyle.textFormFieldSemiBold.copyWith(
            // height: 1.5,
            // color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
