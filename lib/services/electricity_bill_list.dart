import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ElectricityBillList with ChangeNotifier {
  List bundles = [];
  Future getUtilityBillList() async {
    try {
      var apiUrl =
          'https://cryptoapi.skyinvest.io/electricity/discoslist?apiKey=8293ui423kjsadhas9oujwasd';

      http.Response response = await http.get(apiUrl);

      dynamic recieve = json.encode(response.body);
      dynamic rep = json.decode(recieve);
      bundles.add(rep);
      // String string = rep.substring(1);
      // Map respond = json.decode(string);

      return {'status': true, 'message': rep};
    } catch (e) {
      print(e.toString());
      return {'status': false, 'message': e};
    }
  }
}