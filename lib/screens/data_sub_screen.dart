
import 'package:Crypto_wallet/screens_component/data_sub_component/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Crypto_wallet/shared/app_colors.dart';

class DataSubScreen extends StatefulWidget {
  final walletList;
  DataSubScreen({this.walletList});
  @override
  _DataSubScreenState createState() => _DataSubScreenState();
}

class _DataSubScreenState extends State<DataSubScreen> {
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