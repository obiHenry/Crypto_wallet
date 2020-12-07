import 'dart:convert';

import 'package:Crypto_wallet/screens/vtu_services/components/billers/billers_or_products_drop_down.dart';
import 'package:Crypto_wallet/screens/vtu_services/components/outLined_box.dart';
import 'package:Crypto_wallet/services/auth.dart';
import 'package:Crypto_wallet/services/get_currency.dart';
import 'package:Crypto_wallet/services/get_naira_rate.dart';
import 'package:Crypto_wallet/widgets/wallet_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bills_botton.dart';

class BillsPaymentForm extends StatefulWidget {
  final billerList;
  final productList;
  final ValueChanged<String> chooseAccountOnChanged;
  final ValueChanged<String> billerOnChanged;
  final ValueChanged<String> productOnChanged;
  final ValueChanged<String> amountOnChanged;
  final ValueChanged<String> refrenceOrNumberOnChanged;
  final walletList;
  final String numberOrReferenceText;
  final Function continuePressed;
  final Widget widget,widget1,widget2;
  BillsPaymentForm(
      {this.billerList,
      this.productList,
      this.chooseAccountOnChanged,
      this.billerOnChanged,
      this.productOnChanged,
      this.amountOnChanged,
      this.refrenceOrNumberOnChanged,
      this.numberOrReferenceText,
      this.walletList,
      this.continuePressed,
      this.widget,this.widget1, this.widget2});
  @override
  _BillsPaymentFormState createState() => _BillsPaymentFormState();
}

class _BillsPaymentFormState extends State<BillsPaymentForm> {
  dynamic nairaBalance;
  dynamic btcBalance;
  dynamic ethBalance;
  dynamic xrpBalance;
  dynamic bchBalance;
  dynamic ltcBalance;
  dynamic trxBalance;
  double nairaUsdEquivalance;
  dynamic cbnNairaRate;
  GetCurrencies getCurrencies;
  List currencies = [];
  List price = [];
  double btcUsdPrice, btcNairaPrice;
  double ethUsdPrice, ethNairaPrice;
  double xrpUsdPrice, xrpNairaPrice;
  double ltcUsdPrice, ltcNairaPrice;
  double bchUsdPrice, bchNairaPrice;
  double trxUsdPrice, trxNairaPrice;
  dynamic nairaRate;
  @override
  void didChangeDependencies() async {
    dynamic users = await AuthService().getUserDataById();
    dynamic naira1 = await GetNairaRate().getNairaRate();
    nairaRate = naira1['buy_rate'];

    cbnNairaRate = (naira1['cbn_rate']).toStringAsFixed(1);

    nairaBalance = users['naira'].toString();
    btcBalance = users['BTC'].toString();
    ethBalance = users['ETH'].toString();
    xrpBalance = users['XRP'].toString();
    bchBalance = users['BCH'].toString();
    ltcBalance = users['LTC'].toString();
    trxBalance = users['TRX'].toString();

    getCurrencies = Provider.of<GetCurrencies>(context, listen: false);
    getCurrencies.refreshCurrencies().then((value) {
      currencies = value;
      price.clear();
      currencies.forEach((element) {
        dynamic pri = json.decode(element['price']);
        price.add(pri);
      });

      btcUsdPrice = price[0];
      ethUsdPrice = price[1];
      xrpUsdPrice = price[2];
      ltcUsdPrice = price[3];
      bchUsdPrice = price[4];
      trxUsdPrice = price[5];

      nairaUsdEquivalance =
          double.parse(nairaBalance) / double.parse(cbnNairaRate);

      btcNairaPrice = (double.parse(btcBalance) * btcUsdPrice) * nairaRate;

      ethNairaPrice = (double.parse(ethBalance) * ethUsdPrice) * nairaRate;
      xrpNairaPrice = (double.parse(xrpBalance) * xrpUsdPrice) * nairaRate;
      ltcNairaPrice = (double.parse(ltcBalance) * ltcUsdPrice) * nairaRate;
      bchNairaPrice = (double.parse(bchBalance) * bchUsdPrice) * nairaRate;
      trxNairaPrice = (double.parse(trxBalance) * trxUsdPrice) * nairaRate;

      print('mine$btcNairaPrice');
      print(nairaUsdEquivalance);
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // List walletList = [
    //   {
    //     'walletName': 'Naira Wallet',
    //     'logo': 'assets/images/index.png',
    //     'balance': nairaBalance,
    //     'otherCurrency': nairaUsdEquivalance.toStringAsFixed(2),
    //   },
    //   {
    //     'walletName': 'BTC Wallet',
    //     'logo': 'assets/images/btc.png',
    //     'balance': btcBalance,
    //     'otherCurrency': btcNairaPrice.toStringAsFixed(2),
    //   },
    //   {
    //     'walletName': 'ETH Wallet',
    //     'logo': 'assets/images/etherium.jpg',
    //     'balance': ethBalance,
    //     'otherCurrency': ethNairaPrice.toStringAsFixed(2),
    //   },
    //   {
    //     'walletName': 'XRP Wallet',
    //     'logo': 'assets/images/ripple.png',
    //     'balance': xrpBalance,
    //     'otherCurrency': xrpNairaPrice.toStringAsFixed(2),
    //   },
    //   {
    //     'walletName': 'BCH Wallet',
    //     'logo': 'assets/images/bitcoin_cash.png',
    //     'balance': bchBalance,
    //     'otherCurrency': bchNairaPrice.toStringAsFixed(2),
    //   },
    //   {
    //     'walletName': 'LTC Wallet',
    //     'logo': 'assets/images/litcoin.jpg',
    //     'balance': ltcBalance,
    //     'otherCurrency': ltcNairaPrice.toStringAsFixed(2),
    //   },
    //   {
    //     'walletName': 'TRX Wallet',
    //     'logo': 'assets/images/tron.jpg',
    //     'balance': trxBalance,
    //     'otherCurrency': trxNairaPrice.toStringAsFixed(2),
    //   },
    // ];
    return
     SingleChildScrollView(
      // child: Container(

      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 5),
            margin: EdgeInsets.only(left: 18),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Choose Account*',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          WalletDropDown(
              hintText: ' Choose Wallet Account ',
              options: widget.walletList,
              onChanged: widget.chooseAccountOnChanged),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            margin: EdgeInsets.only(left: 18),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Biller*',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          BillersOrProductsDropDown(
            hintText: 'Select Biller',
            options: widget.billerList,
            onChanged: widget.billerOnChanged,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 18),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Product*',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          BillersOrProductsDropDown(
            hintText: 'Select Product',
            options: widget.productList,
            onChanged: widget.productOnChanged,
          ),
          SizedBox(height: 30),
          Container(
            // padding: EdgeInsets.only(
                // bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            margin: EdgeInsets.only(left: 18),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Amount*',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          widget.widget1,
            SizedBox(height: 30),
          Container(
            // padding: EdgeInsets.only(
                // bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            margin: EdgeInsets.only(left: 18),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Equivalence*',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          widget.widget2,

          SizedBox(
            height: 30,
          ),
          
          //  Container(child: widget.widget,),

          Container(
            // padding: EdgeInsets.only(
            //     bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            margin: EdgeInsets.only(left: 18),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.numberOrReferenceText,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: OutLinedBox(
              validate: false,
              isNumberType: true,
              label: widget.numberOrReferenceText,
              press: widget.refrenceOrNumberOnChanged,
            ),
          ),


         
          BillsButton(
            press: widget.continuePressed,
            text: 'Continue',
            // color: color,
            // disa
          ),
          SizedBox(height: 30,),
        ],
      ),
      // ),
    );
  }
}
