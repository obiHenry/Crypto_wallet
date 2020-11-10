import 'dart:ffi';

import 'package:Crypto_wallet/services/send_coin.dart';
import 'package:Crypto_wallet/shared/CustomTextStyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './button.dart';

class CheckOutScreen extends StatefulWidget {
  final currency;
  final address;
  final user;
  final amount;

  CheckOutScreen({
    this.currency,
    this.address,
    this.user,
    this.amount,
  });
  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  void _showBottomSheet(Widget widget) {
    showDialog(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: 20,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
              top: Radius.circular(25),
              bottom: Radius.circular(25),
            )),
            child: widget,
            // behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var amount = double.parse(widget.amount);
    dynamic charged = (amount) / 100;
    dynamic charge = charged.toStringAsFixed(8);
    dynamic total = charged + (amount);
    dynamic totalAmount = total.toStringAsFixed(8);

    return SingleChildScrollView(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
                icon: Icon(Icons.close_rounded),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          Container(
            height: 70,
            width: double.infinity,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.all(
            //     Radius.circular(5),
            //   ),
            //   gradient: LinearGradient(
            //     begin: Alignment.centerLeft,
            //     end: Alignment.centerRight,
            //     colors: [yellowStart, yellowEnd],
            //   ),
            // ),
            child: Center(
              child: Text(
                'Review ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          // SizedBox(height: 20),
          Container(
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    border: Border.all(color: Colors.grey.shade200)),
                padding:
                    EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "SUMMARY",
                      style: CustomTextStyle.textFormFieldMedium.copyWith(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 0.5,
                      margin: EdgeInsets.symmetric(vertical: 4),
                      color: Colors.grey.shade400,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    createSummaryItem("From :", widget.user, Colors.purple),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 0.5,
                      margin: EdgeInsets.symmetric(vertical: 4),
                      color: Colors.grey.shade400,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    createItem("To", widget.address, Colors.purple),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 0.5,
                      margin: EdgeInsets.symmetric(vertical: 4),
                      color: Colors.grey.shade400,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    createSingleItem(
                        "Amount",
                        '${widget.amount} ${widget.currency['currency']}',
                        Colors.black),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 0.5,
                      margin: EdgeInsets.symmetric(vertical: 4),
                      color: Colors.grey.shade400,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    createSingleItem(
                        "Charges",
                        '${charge.toString()} ${widget.currency['currency']}',
                        Colors.black),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 0.5,
                      margin: EdgeInsets.symmetric(vertical: 4),
                      color: Colors.grey.shade400,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    createSingleItem(
                        "Total",
                        '${totalAmount.toString()} ${widget.currency['currency']}',
                        Colors.black),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Button(
              text: 'Send',

              // icon: Icons.copy,
              press: () async{
                print('come');
                dynamic userId = FirebaseAuth.instance.currentUser.uid;
                dynamic apiKey = '8293ui423kjsadhas9oujwasd';
                Map result = await SendCoin().sendCoin(
                  apiKey,
                  widget.currency['currency'],
                  userId,
                  widget.amount,
                  widget.address,
                  charge.toString(),
                );
                print(result.toString());
                if (result['status']) {
                  print('success');
                } else {
                  String msg = (result['message'] != null &&
                          result['message'].isNotEmpty)
                      ? result['message']
                      : 'An unknown error occured; retry';
                  Fluttertoast.showToast(
                      msg: msg,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.black,
                      textColor: Colors.white);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  createItem(String key, value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          key,
          style: CustomTextStyle.textFormFieldSemiBold
              .copyWith(color: Colors.black, fontSize: 12),
        ),
        Container(
          width: 250,
          padding: EdgeInsets.only(left: 50),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  // '₦ $total',
                  style: CustomTextStyle.textFormFieldMedium.copyWith(
                    // height: 1.5,
                    color: color,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  createSingleItem(String key, value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          key,
          style: CustomTextStyle.textFormFieldSemiBold
              .copyWith(color: Colors.black, fontSize: 12),
        ),
        Text(
          value,
          // '₦ $total',
          style: CustomTextStyle.textFormFieldMedium
              .copyWith(color: color, fontSize: 15),
        ),
      ],
    );
  }

  createSummaryItem(String key, value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            key,
            style: CustomTextStyle.textFormFieldMedium.copyWith(
              color: Colors.grey.shade700,
              fontSize: 12,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 250,
                padding: EdgeInsets.only(left: 50),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: value['email'],
                        // '₦ $total',
                        style: CustomTextStyle.textFormFieldMedium.copyWith(
                          // height: 1.5,
                          color: color,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 250,
                padding: EdgeInsets.only(left: 50),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: value['userName'],
                        // '₦ $total',
                        style: CustomTextStyle.textFormFieldMedium.copyWith(
                          // height: 1.5,
                          color: color,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Text(
              //   value,
              //   style: CustomTextStyle.textFormFieldMedium.copyWith(
              //     color: color,
              //     fontSize: 12,
              //   ),
              // )
            ],
          ),
        ],
      ),
    );
  }
}
