import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SendCoin with ChangeNotifier {
  Future sendCoin(apiKey, currency, userId, amount, address, txFee) async {
    const url = 'http://cryptoAPI.skyinvest.io/sendAPI.php';
    try {
      dynamic response = await http.post(url,
          body: json.encode({
            'apiKey': apiKey,
            'currency': currency,
            'userId': userId,
            'amount': amount,
            'address': address,
            'txFee': txFee,
          }));
      print(response);
       
      return {'status': true, 'message': response};
    } catch (e) {
      print(e.toString());
      return {'status': false, 'message': e.message.toString()};
    }
  }
}
