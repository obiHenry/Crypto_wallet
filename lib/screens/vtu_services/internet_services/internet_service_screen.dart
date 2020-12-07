
import 'package:Crypto_wallet/screens/vtu_services/internet_services/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InternetServiceScreen extends StatefulWidget {
  final walletList;
  InternetServiceScreen({this.walletList});
  @override
  _InternetServiceScreenState createState() => _InternetServiceScreenState();
}

class _InternetServiceScreenState extends State<InternetServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
        icon: SvgPicture.asset('assets/images/back.svg'),
        onPressed: () => Navigator.pop(context),
      ),
          
        
          
          title: Text(
            'Internet Service',
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