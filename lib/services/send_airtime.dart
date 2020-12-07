import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SendAirtime with ChangeNotifier {
 
  
  Future sendAirtime(
    mobileNumber, amount,code
  ) async {
    final auth = '935CG7F36VW9A99T73I0HYXUJA10OCKNNP8S602GU31174RSJYG535MK469K78J1';
  final userId = 'CK100240605';
  final authText = "FLWSECK_TEST-SANDBOXDEMOKEY-X";
   print('this is the account number$mobileNumber');
    print('this is the bank$amount');
  dynamic txRef =  DateTime.now().millisecondsSinceEpoch;
   print(txRef);
    try {
      var apiUrl ='https://cryptoapi.skyinvest.io/airtime/airtime.php?apiKey=8293ui423kjsadhas9oujwasd&auth=$auth&userId=$userId&mobilenetwork_code=$code&customer=$mobileNumber&reference=$txRef&amount=$amount';
          // 'https://cryptoAPI.skyinvest.io/airtime/airtime.php?apiKey=8293ui423kjsadhas9oujwasd&amount=$amount&customer=$mobileNumber&reference=$txRef&auth="FLWSECK_TEST-SANDBOXDEMOKEY-X"';

      http.Response response = await http.get(apiUrl);

      dynamic recieve = json.encode(response.body);
      dynamic rep = json.decode(recieve);
      // String string = rep.substring(1);
      // Map respond = json.decode(string);
      

      return {'status': true, 'message': rep};
    } catch (e) {
      print(e.toString());
      return {'status': false, 'message': e.message.toString()};
    }
  }
  // Future sendAirtime(mobileNumber, amount) async {
  // final publickey = '8293ui423kjsadhas9oujwasd';
  // final auth = 'FLWSECK-dd78218a4fe9bacc11cfa690367b3cd7-X';
  // final authText = "FLWSECK_TEST-SANDBOXDEMOKEY-X";
  // dynamic txRef =  DateTime.now().toIso8601String();
  //   print('this is the account number$mobileNumber');
  //   print('this is the bank$amount');
  //   print(txRef);
  //   const url = 'https://cryptoAPI.skyinvest.io/airtime/airtime.php';

  //   try {
  //     dynamic response = await http.post(url,
  //         // headers: headers,
  //         body: json.encode({
  //           'apiKey': publickey,
  //           'amount': amount,
  //           'customer': mobileNumber,
  //           'reference': txRef,
  //           'auth': authText,
  //         }));
  //     // final responseJson = json.encode(response.body);
  //     dynamic result = json.decode(response.body);
  //     // print('com and see me$responseJson');

  //     return {'status': true, 'message': result};
  //   } catch (e) {
  //     // print(e.toString());
  //     return {'status': false, 'message': e.message.toString()};
  //   }
  // }
}
