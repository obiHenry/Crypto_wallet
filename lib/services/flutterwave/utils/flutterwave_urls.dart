class FlutterwaveURLS {
  static const String _DEBUG_BASE_URL =
      "https://ravesandboxapi.flutterwave.com/v3/sdkcheckout/";
  // static const String _PROD_BASE_URL = "https://api.ravepay.co/v3/sdkcheckout/";
  static const String _PROD_BASE_URL = "https://api.flutterwave.com/v3/";
  static const String CHARGE_CARD_URL = "charges?type=card";
  static const String VOUCHER_PAYMENT = "charges?type=voucher_payment";
  static const String BANK_TRANSFER = "charges?type=bank_transfer";
  static const String PAY_WITH_ACCOUNT = "charges?type=debit_ng_account";
  // static const String GET_BANKS_URL =
  //     "https://api.ravepay.co/flwv3-pug/getpaidx/api/flwpbf-banks.js?json=1";
  static const String GET_BANKS_URL = "https://api.flutterwave.com/v3/banks/ng";
  static const String PAY_WITH_USSD = "charges?type=ussd";
  static const String VALIDATE_CHARGE = "validate-charge";
  // static const String VERIFY_TRANSACTION = "mpesa-verify";
  static const String VERIFY_TRANSACTION = "mpesa-verify";
  static const String DEFAULT_REDIRECT_URL = "https://flutterwave.com/ng/";

  /// Returns base url depending on debug mode
  static String getBaseUrl(final bool isDebugMode) {
    return isDebugMode ? _DEBUG_BASE_URL : _PROD_BASE_URL;
  }
}
