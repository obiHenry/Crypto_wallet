
import 'package:Crypto_wallet/screens/settings_screen.dart';
import 'package:Crypto_wallet/screens_component/tab_screen_componenets/bottom_navigation.dart';
import 'package:Crypto_wallet/screens_component/tab_screen_componenets/tab_item.dart';
import 'package:flutter/material.dart';
import 'home_page_screen.dart';
import 'package:Crypto_wallet/screens/bills_payment_screen.dart';

class TabScreen extends StatefulWidget {
  @override
  TabScreenState createState() => TabScreenState();
}

class TabScreenState extends State<TabScreen> {
  // this is static property so other widget throughout the app
  // can access it simply by AppState.currentTab
  static int currentTab = 0;

  // list tabs here
  final List<TabItem> tabs = [
    TabItem(
      tabName: "HomePage",
      icon: 'assets/images/wallets.png',
      page: HomePageScreen(),
    ),
    
    TabItem(
      tabName: "BillsPayment",
      icon: 'assets/images/bill.png',
      page: BillsPaymentScreen(),
    ),
    TabItem(
      tabName: "Settings",
      icon: 'assets/images/profile.png',
      page: UsersSettingsScreen(),
    ),
  ];

   TabScreenState() {
    // indexing is necessary for proper funcationality
    // of determining which tab is active
    tabs.asMap().forEach((index, details) {
      details.setIndex(index);
    });
  }

  // sets current tab index
  // and update state
  void _selectTab(int index) {
    if (index == currentTab) {
      // pop to first route
      // if the user taps on the active tab
      tabs[index].key.currentState.popUntil((route) => route.isFirst);
    } else {
      // update the state
      // in order to repaint
      setState(() => currentTab = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await tabs[currentTab].key.currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (currentTab != 0) {
            // select 'main' tab
            _selectTab(0);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      // this is the base scaffold
      // don't put appbar in here otherwise you might end up
      // with multiple appbars on one screen
      // eventually breaking the app
      child: Scaffold(
        // indexed stack shows only one child
        body: IndexedStack(
          index: currentTab,
          children: tabs.map((e) => e.page).toList(),
        ),
        // Bottom navigation
        bottomNavigationBar: BottomNavigation(
          onSelectTab: _selectTab,
          tabs: tabs,
        ),
      ),
    );
  }
}


