import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:Crypto_wallet/services/flutterwave/core/metrics/metric_manager.dart';
import 'package:Crypto_wallet/services/flutterwave/models/requests/pay_with_bank_account/pay_with_bank_account.dart';
import 'package:Crypto_wallet/services/flutterwave/models/responses/charge_response.dart';
import 'package:Crypto_wallet/services/flutterwave/utils/flutterwave_urls.dart';
import 'package:http/http.dart' as http;

class BankAccountPaymentManager {
  String publicKey;
  String secretKey;
  String currency;
  String amount;
  String email;
  String txRef;
  bool isDebugMode;
  String phoneNumber;
  String accountBank;
  String accountNumber;
  String fullName;

  /// BankAccountPaymentManager constructor
  /// Available for only payments with NGN currency
  BankAccountPaymentManager({
    @required this.publicKey,
    @required this.secretKey,
    @required this.currency,
    @required this.amount,
    @required this.email,
    @required this.txRef,
    @required this.isDebugMode,
    @required this.phoneNumber,
    @required this.fullName,
    this.accountBank,
    this.accountNumber,
  });

  /// Initiates payments via Bank Account
  /// Available for only payments with NGN currency
  /// returns an instance of ChargeResponse or throws an error
  Future<ChargeResponse> payWithAccount(
      BankAccountPaymentRequest bankAccountRequest, http.Client client) async {
    final stopWatch = Stopwatch();
    final requestBody = bankAccountRequest.toJson();

    final url = FlutterwaveURLS.getBaseUrl(this.isDebugMode) +
        FlutterwaveURLS.PAY_WITH_ACCOUNT;
    try {
      final http.Response response = await client.post(url,
          headers: {HttpHeaders.authorizationHeader: this.secretKey},
          body: requestBody);
      MetricManager.logMetric(
          client,
          publicKey,
          MetricManager.INITIATE_ACCOUNT_CHARGE,
          "${stopWatch.elapsedMilliseconds}ms");
      ChargeResponse bankTransferResponse =
          ChargeResponse.fromJson(json.decode(response.body));
      return bankTransferResponse;
    } catch (error) {
      MetricManager.logMetric(
          client,
          publicKey,
          MetricManager.INITIATE_ACCOUNT_CHARGE_ERROR,
          "${stopWatch.elapsedMilliseconds}ms");
      throw (FlutterError(error.toString()));
    }
  }
}
