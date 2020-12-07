
import 'package:Crypto_wallet/screens/vtu_services/utilty_bills/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UtilityBillsScreen extends StatefulWidget {
  final walletList;
  UtilityBillsScreen({this.walletList});
  @override
  _UtilityBillsScreenState createState() => _UtilityBillsScreenState();
}

class _UtilityBillsScreenState extends State<UtilityBillsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
        icon: SvgPicture.asset('assets/images/back.svg'),
        onPressed: () => Navigator.pop(context),
      ),
          
        
          
          title: Text(
            'Utility Bills',
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