import 'dart:convert';

import 'package:http/http.dart' as http;

class MetricManager {
  static const INITIATE_CARD_CHARGE =  "Initiate-Card-charge";
  static const INITIATE_CARD_CHARGE_ERROR =  "Initiate-Card-charge-error";
  static const VALIDATE_CARD_CHARGE = "Validate-Card-charge";
  static const VALIDATE_CARD_CHARGE_ERROR = "Validate-Card-charge-error";
  static const VERIFY_CARD_CHARGE = "Verify-Card-charge";
  static const VERIFY_CARD_CHARGE_ERROR = "Verify-Card-charge-error";
  static const INITIATE_ACCOUNT_CHARGE = "Initiate-Account-charge";
  static const INITIATE_ACCOUNT_CHARGE_ERROR = "Initiate-Account-charge-error";
  static const ACCOUNT_CHARGE_VALIDATE = "Account-charge-validate";
  static const ACCOUNT_CHARGE_VALIDATE_ERROR = "Account-charge-validate-error";
  static const ACCOUNT_CHARGE_VERIFY = "Account-charge-verify";
  static const ACCOUNT_CHARGE_VERIFY_ERROR = "Account-charge-verify-error";

  static const _METRIC_URL = "https://kgelfdz7mf.execute-api.us-east-1.amazonaws.com/staging/sendevent";

  static void logMetric(final http.Client client,
      final String publicKey, 
      final String featureName, 
      String responseTime ) async {
    final request = {
    "publicKey": publicKey,
    "language": "Flutter Rave v3",
    "version": "Flutter SDK 0.0.3",
    "title": featureName,
    "message": responseTime
    };
    try {
      client.post(_METRIC_URL, body: jsonEncode(request));
    } catch (ignored) { }
  }
  

}