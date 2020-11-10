import 'package:Crypto_wallet/shared/CustomTextStyle.dart';
import 'package:Crypto_wallet/shared/app_colors.dart';
import 'package:Crypto_wallet/theme/light_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItemCard extends StatefulWidget {
  final transaction;
  TransactionItemCard({this.transaction});
  @override
  _TransactionItemCardState createState() => _TransactionItemCardState();
}

class _TransactionItemCardState extends State<TransactionItemCard> {
  @override
  Widget build(BuildContext context) {
    final DateFormat format = DateFormat('MMM d, y hh:mm');
    dynamic naira = double.parse(widget.transaction['nairaEquivalence']);
    dynamic nairaEqui = naira.toStringAsFixed(2);
    dynamic coin = double.parse(widget.transaction['coinEquivalance']);
    dynamic coinEqui = coin.toStringAsFixed(4);

    return Container(
      // width: MediaQuery.of(context).size.width*0.5,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      height: 85,
      // color: Colors.white,
      // child: Center(
        child: Row(children: [

           Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: LightColor.navyBlue2,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child:  Center(child: Text('NW',style: TextStyle(color: Colors.white),)),
      ),

          //  CircleAvatar(
          //     backgroundColor: yellowStart,
          //     child: Text('NW',style: TextStyle(color: Colors.white),),
          //   ),
            SizedBox(width: 10,),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                createRow(widget.transaction['TransactionType'], coinEqui, '(NGN$nairaEqui)' , Colors.black),
              //  Text(
              //   '${widget.transaction['TransactionType']} $coinEqui(NGN$nairaEqui)'),
                SizedBox(height: 3,),
                createItem('From:', widget.transaction['from'], Colors.black),
                // SizedBox(height: 5,),
                createItem('To:  ', widget.transaction['to'], Colors.black),
              
            ],),
              Align(
              alignment: Alignment.bottomRight,
              child: Container(
                alignment: Alignment.bottomRight,
                 width: MediaQuery.of(context).size.width*0.2,
                child: Text(
                    format.format(DateTime.parse(widget.transaction['time']))),
              ),
            ),
        ],)
    
    );
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
          
          child: Text(
             value,
                  // // '₦ $total',
                  // style: CustomTextStyle.textFormFieldSemiBold.copyWith(
                  //   // height: 1.5,
                  //   // color: Colors.grey,
                  //   // fontSize: 16,
                  // ),
                
          ),
        ),
      ],
    );
  }

  createRow(String key, value,value2, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          key,
          style: CustomTextStyle.textFormFieldMedium
          
              .copyWith(color: color, fontSize: 17),
        ),
        SizedBox(width: 2,),
        Container(
          
          child: Text(
             value,
                  // '₦ $total',
                  style: CustomTextStyle.textFormFieldSemiBold.copyWith(
                    // height: 1.5,
                    // color: Colors.grey,
                    fontSize: 14,
                  ),
                
          ),
        ),
        // Text(
        //      value1,
        //           // '₦ $total',
        //           style: CustomTextStyle.textFormFieldSemiBold.copyWith(
        //             // height: 1.5,
        //             // color: Colors.grey,
        //             fontSize: 14,
        //           ),
                
        //   ),
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
