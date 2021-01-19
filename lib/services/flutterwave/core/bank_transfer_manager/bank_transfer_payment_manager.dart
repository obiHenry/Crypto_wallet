import 'dart:convert';
import 'dart:io';

import 'package:Crypto_wallet/services/flutterwave/utils/flutterwave_get_url.dart';
import 'package:flutter/material.dart';
import 'package:Crypto_wallet/services/flutterwave/core/flutterwave_error.dart';
import 'package:Crypto_wallet/services/flutterwave/models/requests/bank_transfer/bank_transfer_request.dart';
import 'package:Crypto_wallet/services/flutterwave/models/requests/verify_charge_request.dart';
import 'package:Crypto_wallet/services/flutterwave/models/responses/bank_transfer_response/bank_transfer_response.dart';
import 'package:Crypto_wallet/services/flutterwave/models/responses/charge_response.dart';
import 'package:Crypto_wallet/services/flutterwave/utils/flutterwave_urls.dart';
import 'package:http/http.dart' as http;

class BankTransferPaymentManager {
  String publicKey;
  String currency;
  String amount;
  String email;
  String txRef;
  bool isDebugMode;
  String phoneNumber;
  int frequency;
  int duration;
  bool isPermanent;
  String narration;

  /// Bank Transfer Payment Manager Constructor
  /// This is responsible for creating instances of BankTransferPaymentManager
  BankTransferPaymentManager({
    @required this.publicKey,
    @required this.currency,
    @required this.amount,
    @required this.email,
    @required this.txRef,
    @required this.isDebugMode,
    @required this.phoneNumber,
    @required this.frequency,
    @required this.narration,
    this.duration,
    this.isPermanent,
  });

  /// Resposnsible for making payments with bank transfer
  /// it returns a bank transfer response or throws an error
  Future<BankTransferResponse> payWithBankTransfer(
      BankTransferRequest bankTransferRequest, http.Client client) async {
    final requestBody = bankTransferRequest.toJson();
    final url = getUrl(FlutterwaveURLS.getBaseUrl(this.isDebugMode) +
        FlutterwaveURLS.BANK_TRANSFER);
    try {
      final http.Response response = await client.post(url,
          headers: {HttpHeaders.authorizationHeader: this.publicKey},
          body: requestBody);

      BankTransferResponse bankTransferResponse =
          BankTransferResponse.fromJson(json.decode(response.body));

      return bankTransferResponse;
    } catch (error) {
      print(error.toString());
    }
  }

  /// Responsible for verifying payments made with bank transfers
  /// it returns an instance of ChargeResponse or throws an error
  Future<ChargeResponse> verifyPayment(
      final String flwRef, final http.Client client) async {
    final url = getUrl(FlutterwaveURLS.getBaseUrl(this.isDebugMode) +
        FlutterwaveURLS.VERIFY_TRANSACTION);
    final VerifyChargeRequest verifyRequest = VerifyChargeRequest(flwRef);
    final payload = verifyRequest.toJson();
    try {
      final http.Response response = await client.post(url,
          headers: {HttpHeaders.authorizationHeader: this.publicKey},
          body: payload);

      final ChargeResponse cardResponse =
          ChargeResponse.fromJson(jsonDecode(response.body));
      return cardResponse;
    } catch (error) {
      print(FlutterWaveError(error.toString()));
    }
  }
}
