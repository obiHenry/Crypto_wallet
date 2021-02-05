import 'package:Crypto_wallet/services/price_formatter.dart';
import 'package:Crypto_wallet/shared/CustomTextStyle.dart';
import 'package:Crypto_wallet/shared/button.dart';
import 'package:flutter/material.dart';

class BillsCheckOutScreen extends StatefulWidget {
  final currency;
  final biller;
  final product;
  final reference;
  final userItem;
  final userItem1;
  final userItem2;
  final coinAmount;
  final Function press;
  final otherCurrencyAmount;
  final chargeInCoin;
  final chargeInOtherCurrency;
  final coinTotalAmountToSend;
  final otherCurrencyTotalAmountToSend;
  final String symbol;
  final String text, text1;
  final userId;

  BillsCheckOutScreen(
      {this.currency,
      this.biller,
      this.product,
      this.reference,
      this.userItem,
      this.userItem1,
      this.userItem2,
      this.coinAmount,
      this.press,
      this.otherCurrencyAmount,
      this.chargeInCoin,
      this.chargeInOtherCurrency,
      this.coinTotalAmountToSend,
      this.otherCurrencyTotalAmountToSend,
      this.symbol,
      this.text,
      this.text1,this.userId,});
  @override
  _BankDepositCheckoutScreenState createState() =>
      _BankDepositCheckoutScreenState();
}

class _BankDepositCheckoutScreenState extends State<BillsCheckOutScreen> {
  @override
  Widget build(BuildContext context) {
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
            width: double.infinity,
            padding: EdgeInsets.all(5),
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
                      widget.userItem,
                      widget.userItem1,
                      widget.userItem2,
                      Colors.purple,
                    ),
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
                    createItem(
                        "Biller", widget.biller.toUpperCase(), Colors.purple),
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
                    createItem(
                        "Product", widget.product.toUpperCase(), Colors.purple),
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
                        "Reference", widget.reference, Colors.black),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 0.5,
                      margin: EdgeInsets.symmetric(vertical: 4),
                      color: Colors.grey.shade400,
                    ),
                    widget.userId != null
                        ? SizedBox(
                            height: 20,
                          )
                        : Container(),
                    widget.userId != null
                        ? createSingleItem(
                            "Bet userId", '${widget.userId}', Colors.black)
                        : Container(),
                    widget.userId != null
                        ? SizedBox(
                            height: 20,
                          )
                        : Container(),
                    widget.userId != null
                        ? Container(
                            width: double.infinity,
                            height: 0.5,
                            margin: EdgeInsets.symmetric(vertical: 4),
                            color: Colors.grey.shade400,
                          )
                        : Container(),
                    SizedBox(
                      height: 20,
                    ),
                    createSingleItem(
                        "charge",
                        '${widget.chargeInCoin.toString()}${widget.symbol}(\₦${formatPrice(widget.chargeInOtherCurrency.toString())})',
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
                        "Amount ",
                        '${widget.coinAmount}${widget.symbol}(\₦${formatPrice(widget.otherCurrencyAmount)})',
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
                        "Total Amount ",
                        '${widget.coinTotalAmountToSend}${widget.symbol}(\₦${formatPrice(widget.otherCurrencyTotalAmountToSend)})',
                        Colors.black),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Button(
              text: 'Continue',

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
        value != null?Text(
          key,
          style: CustomTextStyle.textFormFieldSemiBold
              .copyWith(color: Colors.black, fontSize: 12),
        ): Container(),
        value != null? Text(
          value,
          // '₦ $total',
          style: CustomTextStyle.textFormFieldMedium
              .copyWith(color: color, fontSize: 15),
        ): Container(),
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
