import 'package:flutter/material.dart';

import '../shared/constants.dart';

class SearchTextBox extends StatelessWidget {

    final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  const SearchTextBox({
    Key key,
    this.hintText,
    this.icon = Icons.search,
    this.onChanged,
    this.controller
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 15,),
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child:  TextField(
        onChanged: onChanged,
        controller: controller ,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}