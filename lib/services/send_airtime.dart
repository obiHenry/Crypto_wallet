import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SendAirtime with ChangeNotifier {
  Future sendAirtime(mobileNumber, amount, code) async {
    final auth =
        '935CG7F36VW9A99T73I0HYXUJA10OCKNNP8S602GU31174RSJYG535MK469K78J1';
    final userId = 'CK100240605';
    final authText = "FLWSECK_TEST-SANDBOXDEMOKEY-X";
    print('this is the$code');
    print('this is the account number$mobileNumber');
    print('this is the bank$amount');
    print('anything');

    dynamic txRef = DateTime.now().millisecondsSinceEpoch;
    print(txRef);
    try {
      var apiUrl =
          'https://cryptoapi.skyinvest.io/airtime/airtime?apiKey=8293ui423kjsadhas9oujwasd&phone=$mobileNumber&amount=$amount&network=$code';
      // 'https://cryptoAPI.skyinvest.io/airtime/airtime.php?apiKey=8293ui423kjsadhas9oujwasd&amount=$amount&customer=$mobileNumber&reference=$txRef&auth="FLWSECK_TEST-SANDBOXDEMOKEY-X"';

      http.Response response = await http.get(apiUrl);

      dynamic recieve = json.encode(response.body);
      dynamic rep = json.decode(recieve);
      // String string = rep.substring(1);
      // Map respond = json.decode(string);

      return {'status': true, 'message': rep};
    } catch (e) {
      // print(e.toString());
      return {'status': false, 'message': e.message.toString()};
    }
  }
}
