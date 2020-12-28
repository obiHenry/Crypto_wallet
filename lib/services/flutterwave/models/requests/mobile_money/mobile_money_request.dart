import 'package:flutter/material.dart';
import 'package:Crypto_wallet/services/flutterwave/utils/flutterwave_urls.dart';

class MobileMoneyRequest {
  String amount;
  String currency;
  String network;
  String txRef;
  String fullName;
  String email;
  String phoneNumber;
  String redirectUrl;
  String voucher;
  String country;

  MobileMoneyRequest(
      {@required this.amount,
      @required this.currency,
      @required this.txRef,
      @required this.fullName,
      @required this.email,
      @required this.phoneNumber,
      this.network = "",
      this.voucher = "",
      this.country = "",
      this.redirectUrl = FlutterwaveURLS.DEFAULT_REDIRECT_URL});

  /// Converts MobileMoneyRequest instance to json
  Map<String, dynamic> toJson() {
    return {
      'amount': this.amount,
      'currency': this.currency,
      'network': this.network == null ? " " : this.network,
      'tx_ref': this.txRef,
      'fullname': this.fullName,
      'email': this.email,
      'phone_number': this.phoneNumber,
      'redirect_url': this.redirectUrl,
      'voucher': this.voucher,
      'country': this.country
    };
  }
}
