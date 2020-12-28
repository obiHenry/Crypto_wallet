import 'package:flutter/material.dart';
import 'package:Crypto_wallet/services/flutterwave/core/flutterwave_error.dart';
import 'package:Crypto_wallet/services/flutterwave/models/responses/charge_response.dart';
import 'package:Crypto_wallet/services/flutterwave/utils/flutterwave_currency.dart';
import 'package:Crypto_wallet/services/flutterwave/widgets/home/flutterwave_payment.dart';

import 'flutterwave_payment_manager.dart';

class Flutterwave {
  BuildContext context;
  String publicKey;
  String encryptionKey;
  String secretKey;
  bool isDebugMode;
  String amount;
  String currency;
  String email;
  String fullName;
  String txRef;
  String redirectUrl;
  bool acceptAccountPayment;
  bool acceptCardPayment;
  bool acceptUSSDPayment;
  String phoneNumber;
  int frequency;
  int duration;
  bool isPermanent;
  String narration;

  //todo include these when they become available and stable on v3
  // bool acceptVoucherPayment;
  // bool acceptUKAccountPayment;
  // bool acceptBarterPayment;
  // bool acceptSouthAfricaBankPayment;
  // bool acceptBankTransferPayment;

  /// Flutterwave Constructor
  Flutterwave.forUIPayment({
    @required this.context,
    @required this.currency,
    @required this.amount,
    @required this.email,
    @required this.fullName,
    @required this.txRef,
    @required this.phoneNumber,

    /*** TEST KEYS FOR TEST ENVIRONMENT  - USED AS DEFAULT ***/
    this.publicKey = 'FLWPUBK_TEST-SANDBOXDEMOKEY-X',
    this.encryptionKey = 'FLWSECK_TEST74e0b6c7db0e',
    this.secretKey = 'FLWSECK_TEST-SANDBOXDEMOKEY-X',
    this.isDebugMode = true,
    /*******************************************************/

    this.frequency,
    this.duration = 0,
    this.isPermanent = false,
    this.narration = "",
    this.acceptAccountPayment = false,
    this.acceptCardPayment = false,
    this.acceptUSSDPayment = false,
  }) {
    _validateKeys();
    this.currency = this.currency.toUpperCase();
  }

  String country;

  String _setCountry() {
    switch (this.currency) {
      case FlutterwaveCurrency.NGN:
        return "NG";
      default:
        return "NG";
    }
  }

  /// Launches payment screen
  /// Returns a future ChargeResponse intance
  /// Nullable
  Future<ChargeResponse> initializeForUiPayments() async {
    FlutterwavePaymentManager paymentManager = FlutterwavePaymentManager(
        publicKey: this.publicKey,
        encryptionKey: this.encryptionKey,
        secretKey: this.secretKey,
        currency: this.currency,
        email: this.email,
        fullName: this.fullName,
        amount: this.amount,
        txRef: this.txRef,
        isDebugMode: this.isDebugMode,
        narration: this.narration,
        isPermanent: this.isPermanent,
        phoneNumber: this.phoneNumber,
        frequency: this.frequency,
        duration: this.duration,
        acceptAccountPayment: this.acceptAccountPayment,
        acceptCardPayment: this.acceptCardPayment,
        acceptUSSDPayment: this.acceptUSSDPayment,
        country: this._setCountry());

    final chargeResponse = await this._launchPaymentScreen(paymentManager);
    return chargeResponse;
  }

  Future<ChargeResponse> _launchPaymentScreen(
      final FlutterwavePaymentManager paymentManager) async {
    return await Navigator.push(
      this.context,
      MaterialPageRoute(builder: (context) => FlutterwaveUI(paymentManager)),
    );
  }

  void _validateKeys() {
    if (this.encryptionKey.trim().isEmpty)
      throw FlutterWaveError("Encrytion key is required");
    if (this.publicKey.trim().isEmpty)
      throw FlutterWaveError("Public key is required");
    if (this.secretKey.trim().isEmpty)
      throw FlutterWaveError("Private key is required");
    if (this.currency.trim().isEmpty)
      throw FlutterWaveError("Currency is required");
    if (this.amount.trim().isEmpty)
      throw FlutterWaveError("Amount is required");
    if (this.email.trim().isEmpty) throw FlutterWaveError("Email is required");
    if (this.fullName.trim().isEmpty)
      throw FlutterWaveError("Full Name is required");
    if (this.txRef.trim().isEmpty) throw FlutterWaveError("txRef is required");
    if (this.phoneNumber.trim().isEmpty)
      throw FlutterWaveError("Phone Number is required");
  }
}
