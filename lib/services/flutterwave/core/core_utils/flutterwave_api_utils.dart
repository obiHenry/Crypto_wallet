import 'dart:convert';
import 'dart:io';
import 'package:Crypto_wallet/services/flutterwave/utils/flutterwave_get_url.dart';
import 'package:http/http.dart' as http;

import '../../../../services/flutterwave/core/flutterwave_error.dart';
import '../../../../services/flutterwave/core/metrics/metric_manager.dart';
import '../../../../services/flutterwave/models/requests/charge_card/validate_charge_request.dart';
import '../../../../services/flutterwave/models/responses/charge_response.dart';
import '../../../../services/flutterwave/models/responses/get_bank/get_bank_response.dart';
import '../../../../services/flutterwave/utils/flutterwave_urls.dart';

/// Flutterwave Utility class
class FlutterwaveAPIUtils {
  /// This method fetches a list of Nigerian banks
  /// it returns an instance of GetBanksResponse or throws an error
  static Future<List<GetBanksResponse>> getBanks(
      final http.Client client, final String secretKey) async {
    final url = getUrl(FlutterwaveURLS.GET_BANKS_URL);
    try {
      final response = await client.get(
        url,
        headers: {HttpHeaders.authorizationHeader: secretKey},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonDecoded = jsonDecode(response.body)['data'];
        final banks =
            jsonDecoded.map((json) => GetBanksResponse.fromJson(json)).toList();
        banks.sort((a, b) {
          return a.bankname.compareTo(b.bankname);
        });
        return banks;
      } else {
        print(
            FlutterWaveError("Unable to fetch banks. Please contact support"));
      }
    } catch (error) {
      print(FlutterWaveError(error.toString()));
    } finally {
      client.close();
    }
  }

  /// Validates payments with OTP
  /// returns an instance of ChargeResponse or throws an error
  static Future<ChargeResponse> validatePayment(
      String otp,
      String flwRef,
      http.Client client,
      final bool isDebugMode,
      final String secretKey,
      final isBankAccount,
      [String feature = ""]) async {
    final stopWatch = Stopwatch();

    final url = getUrl(FlutterwaveURLS.getBaseUrl(isDebugMode) +
        FlutterwaveURLS.VALIDATE_CHARGE);
    final ValidateChargeRequest chargeRequest =
        ValidateChargeRequest(otp, flwRef, isBankAccount);
    final payload = chargeRequest.toJson();
    try {
      final http.Response response = await client.post(url,
          headers: {HttpHeaders.authorizationHeader: secretKey}, body: payload);

      if (feature.isNotEmpty) {
        MetricManager.logMetric(
            client, secretKey, feature, "${stopWatch.elapsedMilliseconds}ms");
      }
      final ChargeResponse cardResponse =
          ChargeResponse.fromJson(jsonDecode(response.body));
      return cardResponse;
    } catch (error) {
      if (feature.isNotEmpty) {
        MetricManager.logMetric(client, secretKey, "{$feature}_ERROR",
            "${stopWatch.elapsedMilliseconds}ms");
      }
      print(FlutterWaveError(error.toString()));
    }
  }

  /// Verifies payments with Flutterwave reference
  /// returns an instance of ChargeResponse or throws an error
  static Future<ChargeResponse> verifyPayment(
      final String id,
      final http.Client client,
      final String publicKey,
      final String secretKey,
      final bool isDebugMode,
      [String feature = ""]) async {
    final stopWatch = Stopwatch();

    final url = getUrl(
        FlutterwaveURLS.getBaseUrl(isDebugMode) + 'transactions/$id/verify');
    try {
      stopWatch.start();
      final http.Response response = await client
          .get(url, headers: {HttpHeaders.authorizationHeader: secretKey});
      stopWatch.stop();
      final ChargeResponse cardResponse =
          ChargeResponse.fromJson(jsonDecode(response.body));
      if (feature.isNotEmpty) {
        MetricManager.logMetric(
            client, publicKey, feature, "${stopWatch.elapsedMilliseconds}ms");
      }
      return cardResponse;
    } catch (error) {
      if (feature.isNotEmpty) {
        MetricManager.logMetric(client, publicKey, "{$feature}_ERROR",
            "${stopWatch.elapsedMilliseconds}ms");
      }
      print(FlutterWaveError(error.toString()));
    }
  }
}
