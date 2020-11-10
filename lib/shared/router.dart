import 'package:Crypto_wallet/screens/logins_and_signUp/set_up/set_up_screen.dart';
import 'package:Crypto_wallet/screens/logins_and_signUp/sign_in/login.dart';
import 'package:Crypto_wallet/screens/logins_and_signUp/sign_up/sign_up_screen.dart';
import 'package:Crypto_wallet/screens/tab_Screen/tab_screen.dart';
import 'package:Crypto_wallet/screens/wallet/coin_wallet/wallet_screen.dart';
import 'package:Crypto_wallet/widgets/buy_coin.dart/buy_coin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class MyRouter {
  static String initialRoute = 'tab_screen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'login':
        return MaterialPageRoute(builder: (_) => Login());
      case 'tab_screen':
        return MaterialPageRoute(builder: (_) => TabScreen());
      case 'wallet':
        return MaterialPageRoute(builder: (_) => Wallet());
      case 'sign_up':
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case 'set_up':
        return MaterialPageRoute(builder: (_) => SetUpScreen());
        case 'buy_coin':
        return MaterialPageRoute(builder: (_) => BuyCoinScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
