import 'package:Crypto_wallet/screens/logins_and_signUp/account_registration/account_pin_code_setup/account_pin_code_setup_screen.dart';
import 'package:Crypto_wallet/screens/logins_and_signUp/set_up/set_up_screen.dart';
import 'package:Crypto_wallet/screens/logins_and_signUp/sign_in/login.dart';
import 'package:Crypto_wallet/screens/logins_and_signUp/account_registration/account_sign_up/sign_up_screen.dart';
import 'package:Crypto_wallet/screens/logins_and_signUp/account_registration/verify_email/verify_email_screen.dart';
import 'package:Crypto_wallet/screens/tab_Screen/tab_screen.dart';
import 'package:Crypto_wallet/screens/vtu_services/mobile_top_up_screen/mobile_top_up_screen.dart';
import 'package:Crypto_wallet/screens/wallet/coin_wallet/recieve_coin/buy_coin_screen.dart';
import 'package:Crypto_wallet/screens/wallet/coin_wallet/wallet_screen.dart';
import 'package:Crypto_wallet/screens/wallet/naira_wallet/deposit_naira-screen.dart';
import 'package:Crypto_wallet/screens/wallet/naira_wallet/transfer_naira_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Crypto_wallet/Screens/logins_and_signUp/password_reset/pass_reset_screen.dart';
import 'package:Crypto_wallet/screens/wrapper_screen.dart';
import 'package:Crypto_wallet/screens/settings/user_profile_screen.dart';


class MyRouter {
  static String initialRoute = 'wrapper_screen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
       case 'wrapper_screen':
        return MaterialPageRoute(builder: (_) => WrapperScreen());
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
        case 'mobile_top_up':
        return MaterialPageRoute(builder: (_) => MobileTopUpScreen());
         case 'naira_deposit':
        return MaterialPageRoute(builder: (_) => DepositMoney());
         case 'naira_transfer':
        return MaterialPageRoute(builder: (_) => TransferNairaScreen());
         case 'user_profile':
        return MaterialPageRoute(builder: (_) => UserProfileScreen());
         case 'verification_screen':
        return MaterialPageRoute(builder: (_) => VerifyEmailAddress(settings.arguments));
         case 'pin_code_screen':
        return MaterialPageRoute(builder: (_) => AccountPinCodeSetup());
         case 'password_reset':
        return MaterialPageRoute(builder: (_) => PassReset());
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
