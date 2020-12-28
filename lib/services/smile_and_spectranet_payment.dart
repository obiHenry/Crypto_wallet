import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SmileAndSpectranetPayment with ChangeNotifier {
  Future sendSmileData(smartNumber, amount, productCode) async {
    final auth =
        '935CG7F36VW9A99T73I0HYXUJA10OCKNNP8S602GU31174RSJYG535MK469K78J1';
    final userId = 'CK100240605';
    final authText = "FLWSECK_TEST-SANDBOXDEMOKEY-X";
    print('this is the account number$smartNumber');
    print('this is the bank$amount');
    dynamic txRef = DateTime.now().millisecondsSinceEpoch;
    print(txRef);
    try {
      var apiUrl =
          'https://cryptoapi.skyinvest.io/smile/smile-data?apiKey=8293ui423kjsadhas9oujwasd&trans_id=$txRef&smartno=$smartNumber&price=$amount&product_code=$productCode';
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

  Future sendSpectranetData(amount, productCode) async {
    final auth =
        '935CG7F36VW9A99T73I0HYXUJA10OCKNNP8S602GU31174RSJYG535MK469K78J1';
    final userId = 'CK100240605';
    final authText = "FLWSECK_TEST-SANDBOXDEMOKEY-X";
    print('this is the account number$productCode');
    print('this is the bank$amount');
    dynamic txRef = DateTime.now().millisecondsSinceEpoch;
    print(txRef);
    try {
      var apiUrl = 'https://cryptoapi.skyinvest.io/spectranet/spectranet?apiKey=8293ui423kjsadhas9oujwasd&product_code=$productCode&price=$amount&trans_id=$txRef';
        // var apiUrl = 'https://mobilenig.com/API/bills/spectranet_test?username=EJIOBIHDAVID6&api_key=1bd34693a49428b1e3db43ca995efabc&product_code=$productCode&price=$amount&trans_id=$txRef';

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
