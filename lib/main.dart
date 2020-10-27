import 'package:Crypto_wallet/services/get_currency.dart';
import 'package:Crypto_wallet/shared/router.dart';
import 'package:Crypto_wallet/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return
     MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: GetCurrencies()),
      ],
      child:
      
       MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      title: 'CryptoWallet',
      initialRoute: MyRouter.initialRoute,
      onGenerateRoute: MyRouter.generateRoute,
    ),);
  }
}



