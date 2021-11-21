import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiServices with ChangeNotifier {
  // List naira = [];
  // List naira = [];
  List currencies = [];
  List currency = [];
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
          'http://api.skyinvest.io/airtime?apiKey=8293ui423kjsadhas9oujwasd&phone=$mobileNumber&amount=$amount&network_id=$code';
      // 'https://api.skyinvest.io/airtime/airtime?apiKey=8293ui423kjsadhas9oujwasd&network=&phone=&amount=&trans_id=$txRef';

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
          'https://api.skyinvest.io/cable/cable-bundles?apiKey=8293ui423kjsadhas9oujwasd';
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
          'https://api.nomics.com/v1/currencies/ticker?key=ef0ea0793f70cc0a63af1aa3803f5823&ids=BTC,ETH,TRX,LTC,BCH,XRP&interval=1d,30d&convert=USD&per-page=100&page=1';
      // Make a HTTP GET request to the CoinMarketCap API.
      // Await basically pauses execution until the get() function returns a Response
      http.Response response = await http.get(apiUrl);
      // Using the JSON class to decode the JSON String

      currency = await json.decode(response.body);
      // currencies.add(nairaWallet);
      currencies.clear();
      currency.forEach((element) {
        currencies.add(element);
      });

      // currencies = currency;
      print(currencies);

      return currencies;
    } catch (e) {
      return e.message;
    }
  }

  Future<List> refreshCurrencies() async {
    // currencies.clear();
    await getCurrency();
    return currencies;
  }

  Future getDataBundles() async {
    List bundles = [];
    try {
      var apiUrl =
          'https://api.skyinvest.io/data-variations?apiKey=8293ui423kjsadhas9oujwasd';

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

  Future getSmileBundles() async {
    List bundles = [];
    try {
      var apiUrl =
          'https://api.skyinvest.io/smile/smile-databundles?apiKey=8293ui423kjsadhas9oujwasd';

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

  Future getSpectranetBundles() async {
    List bundles = [];
    try {
      var apiUrl =
          'https://api.skyinvest.io/spectranet/spectranet-bundles?apiKey=8293ui423kjsadhas9oujwasd';

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

  Future sendCableSub(
      biller, smartCardNumber, userEmail, userPhoneNumber, amount) async {
    print('this is the account number$biller');
    print('this is the bank$amount');
    print('this is th smart no $smartCardNumber');
    print('this is cable');
    dynamic txRef = DateTime.now().millisecondsSinceEpoch;
    print(txRef);
    try {
      var apiUrl =
          'https://api.skyinvest.io/cable/cablesubscription?cable=$biller&customer_id=234463452342&apiKey=8293ui423kjsadhas9oujwasd&amount=$amount&smartcard_no=$smartCardNumber&email=$userEmail&phone=$userPhoneNumber';

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

  Future sendData(uniqueId, mobileNumber, networkId) async {
    print('this is the account number$mobileNumber');
    print('this is the bank$uniqueId');
    print('this is the code$networkId');
    print('me is here');
    dynamic txRef = DateTime.now().millisecondsSinceEpoch;
    print(txRef);
    try {
      var apiUrl =
          'https://api.skyinvest.io/buy-data?apiKey=8293ui423kjsadhas9oujwasd&phone=$mobileNumber&network_id=$networkId&variation=$uniqueId';

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

  Future sendSmileAirtime(smartNumber, amount, mobile, email) async {
    print('this is the account number$smartNumber');
    print('this is the bank$amount');
    print("this is $email");
    print("this is $mobile");
    dynamic txRef = DateTime.now().millisecondsSinceEpoch;
    print(txRef);
    try {
      var apiUrl =
          'https://api.skyinvest.io/smile/smile-airtime?apiKey=8293ui423kjsadhas9oujwasd&customer_id=$smartNumber&amount=$amount&email=$email&phone=$mobile';

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

  Future sendSmileData(smartNumber, planId, email, mobile) async {
    // final auth =
    //     '935CG7F36VW9A99T73I0HYXUJA10OCKNNP8S602GU31174RSJYG535MK469K78J1';
    // final userId = 'CK100240605';
    // final authText = "FLWSECK_TEST-SANDBOXDEMOKEY-X";
    print('this is the account number$smartNumber');
    print('this is the bank$planId');
    dynamic txRef = DateTime.now().millisecondsSinceEpoch;
    print(txRef);
    try {
      var apiUrl =
          'https://api.skyinvest.io/smile/smile-data?apiKey=8293ui423kjsadhas9oujwasd&customer_id=$smartNumber&variation=$planId&email=$email&phone=$mobile';

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

  Future sendSpectranetData(planId, email, mobile) async {
    print('this is the account number$planId');
    print('this is the bank$mobile');
    // dynamic txt = Date.now;
    dynamic txRef = DateTime.now().millisecondsSinceEpoch;
    print(txRef);
    try {
      var apiUrl =
          'https://api.skyinvest.io/spectranet/spectranet-data?apiKey=8293ui423kjsadhas9oujwasd&customer_id=9872342349&variation=$planId&email=$email&phone=$mobile';

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

  Future sendEmailVerificationToken(
      {userEmail, subject, content, userName}) async {
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
