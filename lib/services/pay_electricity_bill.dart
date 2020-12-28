import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PayElectricityBill with ChangeNotifier {
  // List bundles = [];

  Future payElectricityBill(electricityCompanycode, meterType, meterNumber,amount) async {
    final auth =
        '935CG7F36VW9A99T73I0HYXUJA10OCKNNP8S602GU31174RSJYG535MK469K78J1';
    final userId = 'CK100240605';
    print('this is the account number$meterType');
    print('this is the bank$electricityCompanycode');
    print('this is the code$meterNumber');
    dynamic txRef = DateTime.now().millisecondsSinceEpoch;
    print(txRef);
    try {
      var apiUrl =
          'https://cryptoapi.skyinvest.io/electricity/buyelectricity1?apiKey=8293ui423kjsadhas9oujwasd&electric_company_code=$electricityCompanycode&meterType=$meterType&meterNo=$meterNumber&amount=$amount&requestId=$txRef';

      http.Response response = await http.get(apiUrl);

      dynamic recieve = json.encode(response.body);
      dynamic rep = json.decode(recieve);
      // bundles.add(rep);
      // String string = rep.substring(1);
      // Map respond = json.decode(string);

      return {'status': true, 'message': rep};
    } catch (e) {
      print(e.toString());
      return {'status': false, 'message': e.message};
    }
  }
}