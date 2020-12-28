import 'package:Crypto_wallet/screens/homepage/home_page_screen.dart';
import 'package:Crypto_wallet/screens/settings/users_settings_screen.dart';
import 'package:Crypto_wallet/screens/transactions/transaction_list_screen.dart';
import 'package:Crypto_wallet/screens/vtu_services/vtu_services_screen.dart';
import 'package:Crypto_wallet/services/auth.dart';
import 'package:Crypto_wallet/shared/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatefulWidget {
  @override
  _LogoutButtonState createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  final List<Map<String, Object>> _pages = [
    {
      'page': HomePageScreen(),
      'title': 'HomePage',
    },
    {
      'page': VtuServicesScreen(),
      'title': 'wallets',
    },
    {
      'page': TransactionListScreen(),
      'title': 'News',
    },
    {
      'page': UsersSettingsScreen(),
      'title': 'Profile',
    },
  ];

  // TabItem currentTab = TabItem.bitcoin;
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      // currentTab = index;
      _selectedPageIndex = index;
    });
  }

  getSnackBar(String value, MaterialColor color, BuildContext context) {
    Scaffold.of(context).removeCurrentSnackBar();
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: new Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold",
          ),
        ),
        backgroundColor: color,
        duration: Duration(seconds: 3),
      ),
    );
  }

  dynamic _auth = AuthService();
  var user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return user != null
        ? FlatButton(
            onPressed: () async {
              Map res = await _auth.signOut();
              user = null;
              getSnackBar(res['message'], Colors.lightGreen, context);
            },
            child:
                Text('Logout', style: TextStyle(color: blueMain, fontSize: 20)),
          )
        : Container();

    //  _pages[_selectedPageIndex]['page'];
  }
}
