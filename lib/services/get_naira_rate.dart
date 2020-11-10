import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

class GetNairaRate with ChangeNotifier {
  // List naira = [];
  // List currencies = [];
  // GetCurrencies() {
  //   getCurrency();
  // }
  final _dbRef = FirebaseDatabase.instance.reference();

  Future getNairaRate() async {


      try {
      dynamic naira = await _dbRef
          .child('naira_equivalence')
          .once()
          .then((DataSnapshot snapshot) {
        dynamic naira = snapshot.value;
        print(naira['current-price']);
        return naira;
      });

      return naira;
    } catch (e) {
      print(e.toString());
    }
    // currencies.clear();
    // try {
    //   var apiUrl = 'https://cryptoapi.skyinvest.io/curcon.php';
    //   // Make a HTTP GET request to the CoinMarketCap API.
    //   // Await basically pauses execution until the get() function returns a Response
    //   http.Response response = await http.get(apiUrl);
    //   // Using the JSON class to decode the JSON String
    //   dynamic rate = json.encode(response.body);
    //   // http.Response response = await http.get(apiUrl);

    //   // dynamic recieve = json.encode(response.body);
    //   String rep = json.decode(rate);
    //   // String string = rep.substring(1);
    //   // Map respond = json.decode(string);
    //   Map respond =json.decode(rep);
    //   // currencies.add(nairaWallet);

    //   // print('come${rep['nairaRate']}');
    //   print('come$respond');

    //   return {'status': true, 'message': respond};
    // } catch (e) {
    //   return e.message;
    // }
  }
}
