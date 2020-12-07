
import 'package:Crypto_wallet/screens/vtu_services/cable_tv/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CableTvScreen extends StatefulWidget {
  final walletList;
  CableTvScreen({this.walletList});
  @override
  _CableTvScreenState createState() => _CableTvScreenState();
}

class _CableTvScreenState extends State<CableTvScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
        icon: SvgPicture.asset('assets/images/back.svg'),
        onPressed: () => Navigator.pop(context),
      ),
          
        
          
          title: Text(
            'Cable Tv',
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