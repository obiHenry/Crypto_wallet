
import 'package:Crypto_wallet/screens_component/airtime_sub_components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Crypto_wallet/shared/app_colors.dart';

class AirtimeSubScreen extends StatefulWidget {
  final walletList;
  AirtimeSubScreen({this.walletList});
  @override
  _AirtimeSubScreenState createState() => _AirtimeSubScreenState();
}

class _AirtimeSubScreenState extends State<AirtimeSubScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
        icon: SvgPicture.asset('assets/images/back.svg'),
        onPressed: () => Navigator.pop(context),
      ),
          
        
          
          title: Text(
            'Mobile TopUp',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: blueMain,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
        ),
        body: Body(
          walletList: widget.walletList,
        ));
  }
}
