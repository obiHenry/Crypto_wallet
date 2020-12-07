import 'dart:ffi';

import 'package:Crypto_wallet/services/price_formatter.dart';
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
  final coinAmount;
  final Function press;
  final otherCurrencyAmount;
  final chargeInCoin;
  final chargeInOtherCurrency;
  final coinTotalAmountToSend;
  final otherCurrencyTotalAmountToSend;
  final String symbol;
  final String text, text1;
  final bankName;
  final accountName;
  final accountNumber;

  CheckOutScreen(
      {this.currency,
      this.address,
      this.user,
      this.coinAmount,
      this.press,
      this.otherCurrencyAmount,
      this.chargeInCoin,
      this.chargeInOtherCurrency,
      this.coinTotalAmountToSend,
      this.otherCurrencyTotalAmountToSend,
      this.symbol,
      this.text,
      this.text1,
      this.bankName,
      this.accountName,
      this.accountNumber});
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
    // var amount = double.parse(widget.amount);
    // dynamic charged = (amount) / 100;
    // dynamic charge = charged.toStringAsFixed(8);
    // dynamic total = charged + (amount);
    // dynamic totalAmount = total.toStringAsFixed(8);

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
            // height: 50,
            width: double.infinity,

            child: Center(
              child: Text(
                'Confirm ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerRight,
            width: MediaQuery.of(context).size.width * 0.95,
            child: Align(
              alignment: Alignment.topCenter,
              child: Center(
                child: FittedBox(
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Container(
            width: double.infinity,
            child: Center(
              child: Text(
                widget.text1,
                style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
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
                    createSummaryItem(
                        "From :",
                        widget.user['email'],
                        widget.user['userName'],
                        '${widget.currency['currency']} Wallet',
                        Colors.purple),
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
                        "Amount ToSend",
                        '${widget.coinAmount} ${widget.currency['currency']}(${widget.symbol}${formatPrice(widget.otherCurrencyAmount)})',
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
                        '${widget.chargeInCoin.toString()}${widget.currency['currency']}(${widget.symbol}${formatPrice(widget.chargeInOtherCurrency)})',
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
                        '${widget.coinTotalAmountToSend}${widget.currency['currency']}(${widget.symbol}${formatPrice(widget.otherCurrencyTotalAmountToSend)})',
                        Colors.black),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // SizedBox(
          //   height: 20,
          // ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 23, right: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Account Details',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        )),
                    FlatButton(
                        onPressed: () {},
                        child: Text(
                          'Edit/change',
                          style: TextStyle(color: Colors.purple, fontSize: 17),
                        ))
                  ],
                ),
              ),
              widget.accountName != null
                  ? Container(
                      // decoration: BoxDecoration(
                      //   border:
                      // ),
                      height: 110,
                      width: MediaQuery.of(context).size.width * 7,
                      margin: EdgeInsets.only(
                          top: 0, bottom: 10, left: 15, right: 15),

                      child: Card(

                          // elevation: 0,
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(widget.accountName,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ))),
                          Container(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                widget.bankName,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              )),
                          Container(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                widget.accountNumber,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              )),
                        ],
                      )),
                    )
                  : Container(),
            ],
          ),

          Container(
            padding: EdgeInsets.all(15),
            child: Button(
              text: 'Send',

              // icon: Icons.copy,
              press: widget.press,
            ),
          )
        ],
      ),
    );
  }

  createItem(String key, value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          key,
          style: CustomTextStyle.textFormFieldSemiBold
              .copyWith(color: Colors.black, fontSize: 12),
        ),
        Container(
          width: 250,
          // padding: EdgeInsets.only(left: 50),
          child: Align(
            alignment: Alignment.centerRight,
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
        ),
      ],
    );
  }

  createSingleItem(String key, value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // crossAxisAlignment: CrossAxisAlignment.start,
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

  createSummaryItem(String key, value, value1, value2, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.end,
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
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 250,
                // padding: EdgeInsets.only(left: 50),
                child: Align(
                  alignment: Alignment.centerRight,
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
              ),
              Container(
                width: 250,
                // padding: EdgeInsets.only(left: 50),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: value1,
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
              ),

              Container(
                width: 250,
                // padding: EdgeInsets.only(left: 50),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: value2,
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
