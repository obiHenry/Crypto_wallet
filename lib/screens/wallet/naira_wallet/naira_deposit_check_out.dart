import 'package:Crypto_wallet/services/auth.dart';
import 'package:Crypto_wallet/shared/CustomTextStyle.dart';
import 'package:Crypto_wallet/widgets/button.dart';
import 'package:flutter/material.dart';

class NairaDepositeCheckoutScreen extends StatefulWidget {
  final currency;
  final address;
  final user;
  final nairaAmount;
  final currentWalletBalance;
  final coinAmount;
  final Function press;
  final chargeInNaira;
  final chargeInCoin;

  NairaDepositeCheckoutScreen({
    this.currency,
    this.address,
    this.user,
    this.nairaAmount,
    this.currentWalletBalance,
    this.coinAmount,
    this.press,
    this.chargeInNaira,
    this.chargeInCoin,
  });
  @override
  _NairaDepositeCheckoutScreenState createState() =>
      _NairaDepositeCheckoutScreenState();
}

class _NairaDepositeCheckoutScreenState
    extends State<NairaDepositeCheckoutScreen> {
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
    var naira = double.parse(widget.nairaAmount);
    dynamic nairaAmount = naira.toStringAsFixed(2);
    var coin = double.parse(widget.coinAmount);
    dynamic coinAmount = coin.toStringAsFixed(7);
    var nairaCharge = double.parse(widget.chargeInNaira);
    var coinCharge = double.parse(widget.chargeInCoin);
    dynamic totalAmountInNaira = naira + nairaCharge;
    dynamic totalAmountInCoin = coin + coinCharge;


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
                    createItem("From :", widget.user, Colors.purple),
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
                    createItem(
                        "Amount",
                        ' $coinAmount${widget.currency['currency']}(NGN${nairaAmount.toString()}) ',
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
                    createItem(
                        "Charges",
                        ' ${coinCharge.toStringAsFixed(5)}${widget.currency['currency']}(NGN${nairaCharge.toStringAsFixed(2)}) ',
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
                    createItem(
                        "Total",
                        ' ${totalAmountInCoin.toStringAsFixed(5)}${widget.currency['currency']}(NGN${totalAmountInNaira.toStringAsFixed(2)}) ',
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
              press: widget.press,

              // () async {
              //   print('come');
              //   dynamic balance = double.parse(widget.currentWalletBalance);
              //   dynamic sentMoney = double.parse(widget.currencyAmount);
              //   dynamic remainedbalance = balance - sentMoney;
              //   String walletBalance = remainedbalance.toStringAsFixed(2);
              //   print(walletBalance);
              //   dynamic users = await AuthService().getUserDataById();
              //   dynamic nairaBalance = double.parse(users['naira']);
              //   dynamic nairaToSend = double.parse(nairaAmount);
              //   print(nairaBalance);
              //   print(nairaToSend);

              //   dynamic totalNairaAmount = nairaBalance + nairaToSend;
              //   print(totalNairaAmount);
              //   dynamic result = await AuthService().updateWalletData(
              //       walletBalance.toString(),
              //       totalNairaAmount.toString(),
              //       widget.currency['currency']);
              // },
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
}
