import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'user_profile_body.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
        icon: SvgPicture.asset('assets/images/back.svg'),
        onPressed: () => Navigator.pop(context),
      ),
          
        
          
          title: Text(
            'User Profile',
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
        body: UserProfileBody(
        ),);
  }
}