import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AccountValidator with ChangeNotifier {
  final publickey = 'FLWPUBK-d09a03406c259a9cba068545fc971cce-X';
  Future validateAccount(accountNumber, accountBank) async {
    print('this is the account number$accountNumber');
    print('this is the bank$accountBank');
    const url = 'https://api.ravepay.co/flwv3-pug/getpaidx/api/resolve_account';

    dynamic headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer FLWSECK_TEST-SANDBOXDEMOKEY-X',
    };
    try {
      dynamic response = await http.post(url,
          headers: headers,
          body: json.encode({
            'recipientaccount': accountNumber,
            'destbankcode': accountBank,
            'PBFPubKey': publickey,

          }));
      final responseJson = json.encode(response.body);
      dynamic result = json.decode(responseJson);
      // print('com and see me$responseJson');

      return {'status': true, 'message': result};
    } catch (e) {
      print(e.toString());
      return {'status': false, 'message': e.message.toString()};
    }
  }
}
