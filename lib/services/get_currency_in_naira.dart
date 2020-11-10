
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class GetCurrenciesInNaira with ChangeNotifier {
  
  List naira = [];
  GetCurrenciesInNaira() {
    getCurrencyInNaira();
  }



  Future getCurrencyInNaira() async {
    // currencies.clear();
    try {
      var apiUrl =
          'https://api.nomics.com/v1/currencies/ticker?key=demo-26240835858194712a4f8cc0dc635c7a&ids=BTC,ETH,TRX,LTC,BCH,XRP&interval=1d,30d&convert=NGN&per-page=100&page=1';
      // Make a HTTP GET request to the CoinMarketCap API.
      // Await basically pauses execution until the get() function returns a Response
      http.Response response = await http.get(apiUrl);
      // Using the JSON class to decode the JSON String
      dynamic currency = await json.decode(response.body);
      // currencies.add(nairaWallet);

      naira = currency;

      return naira;
    } catch (e) {
      return e.message;
    }
  }

  Future<List> refreshCurrencies() async {
    naira.clear();
    await getCurrencyInNaira();
    return naira;
  }
}