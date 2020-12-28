
import 'package:Crypto_wallet/screens/vtu_services/bet_sub/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BetSubScreen extends StatefulWidget {
  final walletList;
  BetSubScreen({this.walletList});
  @override
  _BetSubScreenState createState() => _BetSubScreenState();
}

class _BetSubScreenState extends State<BetSubScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
        icon: SvgPicture.asset('assets/images/back.svg'),
        onPressed: () => Navigator.pop(context),
      ),
          
        
          
          title: Text(
            'Bet Subscription',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.lightGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
        ),
        body: Body(
          walletList: widget.walletList,
        ));
  }
}