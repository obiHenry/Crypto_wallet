import 'dart:convert';
import 'dart:io';

import 'package:Crypto_wallet/services/flutterwave/utils/flutterwave_get_url.dart';
import 'package:flutter/material.dart';
import 'package:Crypto_wallet/services/flutterwave/models/requests/voucher/voucher_payment_request.dart';
import 'package:Crypto_wallet/services/flutterwave/models/responses/charge_response.dart';
import 'package:Crypto_wallet/services/flutterwave/utils/flutterwave_urls.dart';
import 'package:http/http.dart' as http;

class VoucherPaymentManager {
  String publicKey;
  String currency;
  String amount;
  String txRef;
  bool isDebugMode;
  String phoneNumber;
  String fullName;
  String email;

  /// VoucherPaymentManager constructor
  /// returns an instance of VoucherPaymentManager
  VoucherPaymentManager({
    @required this.publicKey,
    @required this.isDebugMode,
    @required this.amount,
    @required this.currency,
    @required this.email,
    @required this.txRef,
    @required this.fullName,
    @required this.phoneNumber,
  });

  /// VoucherPaymentManager constructor
  /// returns an instance of VoucherPaymentManager from a json object
  VoucherPaymentManager.fromJson(Map<String, dynamic> json) {
    this.amount = json['amount'];
    this.currency = json['currency'];
    this.email = json['email'];
    this.txRef = json['tx_ref'];
    this.fullName = json['fullname'];
    this.phoneNumber = json["phone_number"];
  }

  /// Converts this instance of VoucherPaymentManager to a Map
  Map<String, dynamic> toJson() {
    return {
      'amount': this.amount,
      'currency': this.currency,
      'email': this.email,
      'tx_ref': this.txRef,
      'fullname': this.fullName,
      'phone_number': this.phoneNumber
    };
  }

  /// Initiates voucher payments
  /// Returns an inatance of ChargeResponse or throws an error
  Future<ChargeResponse> payWithVoucher(
      VoucherPaymentRequest payload, http.Client client) async {
    final url = getUrl(FlutterwaveURLS.getBaseUrl(this.isDebugMode) +
        FlutterwaveURLS.VOUCHER_PAYMENT);
    try {
      final http.Response response = await client.post(url,
          headers: {HttpHeaders.authorizationHeader: this.publicKey},
          body: payload.toJson());

      ChargeResponse chargeResponse =
          ChargeResponse.fromJson(json.decode(response.body));
      return chargeResponse;
    } catch (error) {
      print(error.toString());
    }
  }
}
