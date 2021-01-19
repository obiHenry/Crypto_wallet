import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiServices with ChangeNotifier {
  // List naira = [];
  // List naira = [];
  List currencies = [];
  ApiServices() {
    getCurrency();
  }

  Future sendAirtime(mobileNumber, amount, code) async {
    print('this is the$code');
    print('this is the account number$mobileNumber');
    print('this is the bank$amount');
    print('anything');

    dynamic txRef = DateTime.now().millisecondsSinceEpoch;
    print(txRef);
    try {
      var apiUrl =
          'https://api.skyinvest.io/airtime/airtime?apiKey=8293ui423kjsadhas9oujwasd&network=$code&phone=$mobileNumber&amount=$amount&trans_id=$txRef';
      // 'https://api.skyinvest.io/airtime/airtime?apiKey=8293ui423kjsadhas9oujwasd&phone=$mobileNumber&amount=$amount&network=$code';
      // 'https://api.skyinvest.io/airtime/airtime.php?apiKey=8293ui423kjsadhas9oujwasd&amount=$amount&customer=$mobileNumber&reference=$txRef&auth="FLWSECK_TEST-SANDBOXDEMOKEY-X"';

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

  Future getUtilityBillList() async {
    List bundles = [];
    try {
      var apiUrl =
          'https://api.skyinvest.io/electricity/discoslist?apiKey=8293ui423kjsadhas9oujwasd';

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

  Future getCableList() async {
    List bundles = [];
    try {
      var apiUrl =
          'https://api.skyinvest.io/cable/cablelist?apiKey=8293ui423kjsadhas9oujwasd';
      // 'https://api.skyinvest.io/cable/cablelist?apiKey=8293ui423kjsadhas9oujwasd';

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

  Future getCurrency() async {
    // currencies.clear();
    try {
      var apiUrl =
          'https://api.nomics.com/v1/currencies/ticker?key=demo-26240835858194712a4f8cc0dc635c7a&ids=BTC,ETH,TRX,LTC,BCH,XRP&interval=1d,30d&convert=USD&per-page=100&page=1';
      // Make a HTTP GET request to the CoinMarketCap API.
      // Await basically pauses execution until the get() function returns a Response
      http.Response response = await http.get(apiUrl);
      // Using the JSON class to decode the JSON String
      var currency = await json.decode(response.body);
      // currencies.add(nairaWallet);

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

  Future getDataBundles() async {
    List bundles = [];
    try {
      var apiUrl =
          'https://api.skyinvest.io/databundle/bundlelist?apiKey=8293ui423kjsadhas9oujwasd';

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

  Future payElectricityBill(
      electricityCompanycode, meterType, meterNumber, amount) async {
    print('this is the account number$meterType');
    print('this is the bank$electricityCompanycode');
    print('this is the code$meterNumber');
    dynamic txRef = DateTime.now().millisecondsSinceEpoch;
    print(txRef);
    try {
      var apiUrl =
          'https://api.skyinvest.io/electricity/buyelectricity1?apiKey=8293ui423kjsadhas9oujwasd&electric_company_code=$electricityCompanycode&meterType=$meterType&meterNo=$meterNumber&amount=$amount&requestId=$txRef';

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

  Future recieveCoin(
    currency,
    userId,
    email,
  ) async {
    print(currency);
    try {
      var apiUrl =
          'http://api.skyinvest.io/requestAPI.php?apiKey=8293ui423kjsadhas9oujwasd&currency=$currency&userId=$userId&email=$email';

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

  Future sendCableSub(biller, packageId, smartCardNumber) async {
    print('this is the account number$biller');
    print('this is the bank$packageId');
    print('this is th smart no $smartCardNumber');
    print('this is cable');
    dynamic txRef = DateTime.now().millisecondsSinceEpoch;
    print(txRef);
    try {
      var apiUrl =
          'https://api.skyinvest.io/cable/cablesubscription?apiKey=8293ui423kjsadhas9oujwasd&cabletv=$biller&package=$packageId&smartno=$smartCardNumber';

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

  Future sendCoin(apiKey, currency, userId, amount, address, txFee) async {
    const url = 'http://api.skyinvest.io/sendAPI.php';
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

  Future sendData(dataPlan, mobileNumber, code) async {
    print('this is the account number$mobileNumber');
    print('this is the bank$dataPlan');
    print('this is the code$code');
    print('me is here');
    dynamic txRef = DateTime.now().millisecondsSinceEpoch;
    print(txRef);
    try {
      var apiUrl =
          'https://api.skyinvest.io/databundle/buydata?apiKey=8293ui423kjsadhas9oujwasd&network_id=$code&dataplan=$dataPlan&phone=$mobileNumber';
      // 'https://api.skyinvest.io/databundle/buydata.php?apiKey=8293ui423kjsadhas9oujwasd&auth=$auth&userId=$userId&mobilenetwork_code=$code&customer=$mobileNumber&reference=$txRef&dataplan=$dataPlan';

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

  Future sendSmileAirtime(
    smartNumber,
    amount,
  ) async {
    print('this is the account number$smartNumber');
    print('this is the bank$amount');
    print("this is me");
    dynamic txRef = DateTime.now().millisecondsSinceEpoch;
    print(txRef);
    try {
      var apiUrl =
          'https://api.skyinvest.io/smile/smile-airtime?apiKey=8293ui423kjsadhas9oujwasd&trans_id=$txRef&smartno=$smartNumber&amount=$amount';
      // 'https://api.skyinvest.io/airtime/airtime.php?apiKey=8293ui423kjsadhas9oujwasd&amount=$amount&customer=$mobileNumber&reference=$txRef&auth="FLWSECK_TEST-SANDBOXDEMOKEY-X"';

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

  Future sendSmileData(smartNumber, amount, productCode) async {
    // final auth =
    //     '935CG7F36VW9A99T73I0HYXUJA10OCKNNP8S602GU31174RSJYG535MK469K78J1';
    // final userId = 'CK100240605';
    // final authText = "FLWSECK_TEST-SANDBOXDEMOKEY-X";
    print('this is the account number$smartNumber');
    print('this is the bank$amount');
    dynamic txRef = DateTime.now().millisecondsSinceEpoch;
    print(txRef);
    try {
      var apiUrl =
          'https://api.skyinvest.io/smile/smile-data?apiKey=8293ui423kjsadhas9oujwasd&trans_id=$txRef&smartno=$smartNumber&price=$amount&product_code=$productCode';
      // 'https://api.skyinvest.io/airtime/airtime.php?apiKey=8293ui423kjsadhas9oujwasd&amount=$amount&customer=$mobileNumber&reference=$txRef&auth="FLWSECK_TEST-SANDBOXDEMOKEY-X"';

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
    print('this is the account number$productCode');
    print('this is the bank$amount');
    // dynamic txt = Date.now;
    dynamic txRef = DateTime.now().millisecondsSinceEpoch;
    print(txRef);
    try {
      var apiUrl =
          'https://api.skyinvest.io/spectranet/spectranet?apiKey=8293ui423kjsadhas9oujwasd&product_code=$productCode&price=$amount&trans_id=$txRef';
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

  Future sendEmailVerificationToken({userEmail, subject, content, userName}) async {
    print('this is the account number$subject');
    print('this is the bank$userEmail');
    // dynamic txt = Date.now;
    dynamic txRef = DateTime.now().millisecondsSinceEpoch;
    print(txRef);
    try {
      var apiUrl =
          'http://api.skyinvest.io/api/mailer?apiKey=8293ui423kjsadhas9oujwasd&to=$userEmail&subject=$subject&body=$content&user=$userName';
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
