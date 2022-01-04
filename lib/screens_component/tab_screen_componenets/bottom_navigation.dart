import 'package:Crypto_wallet/screens/tab_screen.dart';
import 'package:flutter/material.dart';
import 'tab_item.dart';
import 'package:Crypto_wallet/theme/light_color.dart';


class BottomNavigation extends StatelessWidget {
  BottomNavigation({
    this.onSelectTab,
    this.tabs,
  });
  final ValueChanged<int> onSelectTab;
  final List<TabItem> tabs;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: tabs
          .map(
            (e) => _buildItem(
              index: e.getIndex(),
              icon: e.icon,
              tabName: e.tabName,
            ),
          )
          .toList(),
      onTap: (index) => onSelectTab(
        index,
      ),
    );
  }

  BottomNavigationBarItem _buildItem(
      {int index,  icon, String tabName}) {
    return BottomNavigationBarItem(
      icon:ImageIcon(AssetImage('$icon'),color: _tabColor(index: index),),
      title: Text(
        tabName,
        style: TextStyle(
          color: _tabColor(index: index),
          fontSize: 12,
        ),
      ),
    );
  }

  Color _tabColor({int index}) {
    return TabScreenState.currentTab == index ? LightColor.navyBlue2: Colors.grey;
  }
}