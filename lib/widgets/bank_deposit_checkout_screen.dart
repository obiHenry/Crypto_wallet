import 'package:Crypto_wallet/services/price_formatter.dart';
import 'package:Crypto_wallet/shared/CustomTextStyle.dart';
import 'package:flutter/material.dart';

import 'button.dart';

class BankDepositCheckoutScreen extends StatefulWidget {
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
  

  BankDepositCheckoutScreen(
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
      this.text1});
  @override
  _BankDepositCheckoutScreenState createState() => _BankDepositCheckoutScreenState();
}

class _BankDepositCheckoutScreenState extends State<BankDepositCheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return    SingleChildScrollView(
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
            width: double.infinity,
            child: Center(
              child: Text(
                widget.text,
                style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 17,
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
                         widget.user['bankAccountName'],
                        widget.user['bankName'],
                       widget.user['bankAccountNumber'],
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
                        '${widget.symbol}${formatPrice(widget.otherCurrencyAmount)}',
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
              text: 'Continue to payment',

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
