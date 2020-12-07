import 'package:Crypto_wallet/screens/tab_Screen/body.dart';
import 'package:Crypto_wallet/screens/transactions/transaction_list_screen.dart';
import 'package:Crypto_wallet/screens/vtu_services/vtu_services_screen.dart';
import 'package:Crypto_wallet/shared/app_colors.dart';
import 'package:Crypto_wallet/theme/light_color.dart';
import 'package:Crypto_wallet/widgets/bottom_navigation_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../homepage/home_page_screen.dart';
import '../profile_screen/profile_screen.dart';

enum TabItem { bitcoin, wallets, news, profile }

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
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
      'page': ProfileScreen(),
      'title': 'Profile',
    },
  ];

  TabItem currentTab = TabItem.bitcoin;
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      // currentTab = index;
      _selectedPageIndex = index;
    });
  }

  var user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: LightColor.navyBlue2,
      //   elevation: 0,
      //   // leading: Padding(
      //   //   padding: const EdgeInsets.all(18.0),
      //   //   child: SvgPicture.asset('assets/images/menu.svg'),
      //   // ),
      //   title: Text('Wallets', style: TextStyle(color: Colors.white),),
      //   actions: <Widget>[
      //     Container(
      //       child: Padding(
      //         padding: const EdgeInsets.only(right: 10),
      //         child: Stack(
      //           children: <Widget>[
      //             user != null ? LogoutButton() : Container(),
      //             // Padding(
      //             //   padding: const EdgeInsets.only(top: 5),
      //             //   child: SvgPicture.asset('assets/images/bell.svg'),
      //             // ),
      //             // Positioned(
      //             //   top: 0,
      //             //   right: 0,
      //             //   child: Container(
      //             //     width: 12,
      //             //     height: 12,
      //             //     decoration: BoxDecoration(
      //             //       color: bellRedDot,
      //             //       borderRadius: BorderRadius.all(
      //             //         Radius.circular(12),
      //             //       ),
      //             //     ),
      //             //   ),
      //             // ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigation(
        pageIndex: _selectedPageIndex,
        selectPage: _selectPage,
      ),
    );
  }
}
