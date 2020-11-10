import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RecieveCoin with ChangeNotifier {
  Future recieveCoin(
    currency,
    userId,
    email,
  ) async {
    print(currency);
    try {
      var apiUrl =
          'http://cryptoapi.skyinvest.io/requestAPI.php?apiKey=8293ui423kjsadhas9oujwasd&currency=$currency&userId=$userId&email=$email';

      http.Response response = await http.get(apiUrl);

      dynamic recieve = json.encode(response.body);
      dynamic rep = json.decode(recieve);
      String string = rep.substring(1);
      Map respond = json.decode(string);

      return {'status': true, 'message': respond};
    } catch (e) {
      print(e.toString());
      return {'status': false, 'message': e.message.toString()};
    }
  }
}
