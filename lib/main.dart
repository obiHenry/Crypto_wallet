import 'package:Crypto_wallet/services/auth.dart';
import 'package:Crypto_wallet/services/api_services.dart';
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
        ChangeNotifierProvider.value(value: ApiServices()),
        // ChangeNotifierProvider.value(value: GetCurrenciesInNaira()),
        ChangeNotifierProvider.value(value: AuthService())
      ],
      child:
      
       MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      title: 'Veloce',
      initialRoute: MyRouter.initialRoute,
      onGenerateRoute: MyRouter.generateRoute,
    ),);
  }
}



