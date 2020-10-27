import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class GetCurrencies with ChangeNotifier {
  List currencies = [];
  GetCurrencies() {
    getCurrency();
  }

  Future<List> getCurrency() async {
    // currencies.clear();
    try {
      var apiUrl =
          'https://api.nomics.com/v1/currencies/ticker?key=demo-26240835858194712a4f8cc0dc635c7a&ids=BTC,ETH,TRX,LTC,PAX,BCH,XRP&interval=1d,30d&convert=USD&per-page=100&page=1';
      // Make a HTTP GET request to the CoinMarketCap API.
      // Await basically pauses execution until the get() function returns a Response
      http.Response response = await http.get(apiUrl);
      // Using the JSON class to decode the JSON String
      var currency = await json.decode(response.body);
      currencies = currency;

      return currencies;
    } catch (e) {
      return e.message;
    }
  }

   Future<List> refreshCurrencies() async {
    currencies.clear();
    await getCurrency();
    return currencies;
  }
}
