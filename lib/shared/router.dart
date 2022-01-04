import 'package:Crypto_wallet/screens/airtime_sub_screen.dart';
import 'package:Crypto_wallet/screens/account_pin_code_setup_screen.dart';
import 'package:Crypto_wallet/screens/account_set_up_screen.dart';
import 'package:Crypto_wallet/screens/pass_reset_screen.dart';
import 'package:Crypto_wallet/screens/sign_up_screen.dart';
import 'package:Crypto_wallet/screens/signin_screen.dart';
import 'package:Crypto_wallet/screens/verify_email_screen.dart';
import 'package:Crypto_wallet/screens/profile_screen.dart';
import 'package:Crypto_wallet/screens/tab_screen.dart';
import 'package:Crypto_wallet/screens/buy_crypto_screen.dart';
import 'package:Crypto_wallet/screens/crypto_wallet_screen.dart';
import 'package:Crypto_wallet/screens/deposit_naira-screen.dart';
import 'package:Crypto_wallet/screens/transfer_naira_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Crypto_wallet/screens/wrapper_screen.dart';


class MyRouter {
  static String initialRoute = 'wrapper_screen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
       case 'wrapper_screen':
        return MaterialPageRoute(builder: (_) => WrapperScreen());
      case 'login':
        return MaterialPageRoute(builder: (_) => SiginScreen());
      case 'tab_screen':
        return MaterialPageRoute(builder: (_) => TabScreen());
      case 'wallet':
        return MaterialPageRoute(builder: (_) => CryptoWalletScreen());
      case 'sign_up':
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case 'set_up':
        return MaterialPageRoute(builder: (_) => SetUpScreen());
        case 'buy_coin':
        return MaterialPageRoute(builder: (_) => BuyCoinScreen());
        case 'mobile_top_up':
        return MaterialPageRoute(builder: (_) => AirtimeSubScreen());
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
