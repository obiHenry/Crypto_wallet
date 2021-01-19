
import 'package:Crypto_wallet/theme/light_color.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  
  final int pageIndex;
  final Function selectPage;
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
          
           label: '',
          icon: ImageIcon(
            AssetImage('assets/images/wallets.png'),
          ),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: ImageIcon(
            AssetImage('assets/images/bill.png'),
          ),
        ),
        // BottomNavigationBarItem(
        //   title: Text(''),
        //   icon: ImageIcon(
        //     AssetImage('assets/images/label.png'),
        //   ),
        // ),
        BottomNavigationBarItem(
            label: '',
          icon: ImageIcon(
            AssetImage('assets/images/profile.png'),
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
