import 'package:Crypto_wallet/shared/app_colors.dart';
import 'package:Crypto_wallet/theme/light_color.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  
  int pageIndex;
  Function selectPage;
  BottomNavigation({ this.pageIndex, this.selectPage});
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
 
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          
          title: Text(''),
          icon: ImageIcon(
            AssetImage('assets/images/wallet.png'),
          ),
        ),
        BottomNavigationBarItem(
          title: Text(''),
          icon: ImageIcon(
            AssetImage('assets/images/search.png'),
          ),
        ),
        BottomNavigationBarItem(
          title: Text(''),
          icon: ImageIcon(
            AssetImage('assets/images/label.png'),
          ),
        ),
        BottomNavigationBarItem(
          title: Text(''),
          icon: ImageIcon(
            AssetImage('assets/images/account.png'),
          ),
        ),
      ],
      currentIndex: widget.pageIndex,
      
      selectedItemColor:LightColor.navyBlue2,
      //  bottomNavActive,
      unselectedItemColor: Colors.grey,
      //  bottomNavInActive,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      // LightColor.navyBlue2,
      
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: widget.selectPage,
    );
  }
}
