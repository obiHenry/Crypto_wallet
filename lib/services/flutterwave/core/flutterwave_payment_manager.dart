import 'package:flutter/material.dart';
import 'package:Crypto_wallet/services/flutterwave/core/bank_transfer_manager/bank_transfer_payment_manager.dart';
import 'package:Crypto_wallet/services/flutterwave/core/card_payment_manager/card_payment_manager.dart';
import 'package:Crypto_wallet/services/flutterwave/core/pay_with_account_manager/bank_account_manager.dart';
import 'package:Crypto_wallet/services/flutterwave/core/ussd_payment_manager/ussd_manager.dart';
import 'package:Crypto_wallet/services/flutterwave/core/voucher_payment/voucher_payment_manager.dart';

class FlutterwavePaymentManager {
  String publicKey;
  String encryptionKey;
  String secretKey;
  String currency;
  String amount;
  String email;
  String fullName;
  String txRef;
  bool isDebugMode;
  String phoneNumber;
  int frequency;
  int duration;
  bool isPermanent;
  String narration;
  String network;
  bool acceptAccountPayment;
  bool acceptBankTransferPayment;
  bool acceptCardPayment;
  bool acceptUSSDPayment;
  String country;

  bool manualBankTransfer;

  FlutterwavePaymentManager({
    @required this.publicKey,
    @required this.encryptionKey,
    @required this.secretKey,
    @required this.currency,
    @required this.amount,
    @required this.email,
    @required this.fullName,
    @required this.txRef,
    @required this.isDebugMode,
    @required this.phoneNumber,
    this.country,
    this.acceptAccountPayment = false,
    this.acceptBankTransferPayment = false,
    this.acceptCardPayment = false,
    this.acceptUSSDPayment = false,
    this.frequency,
    this.duration,
    this.isPermanent,
    this.narration,
    this.network = "",
    this.manualBankTransfer = false,
  });

  /// Returns an instance of CardPaymentManager
  CardPaymentManager getCardPaymentManager() {
    return CardPaymentManager(
        publicKey: this.publicKey,
        secretKey: this.secretKey,
        encryptionKey: this.encryptionKey,
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
        country: this.country,
        duration: this.duration);
  }

  /// Returns an instance of BankTransferPaymentManager
  BankTransferPaymentManager getBankTransferPaymentManager() {
    return BankTransferPaymentManager(
        publicKey: this.publicKey,
        currency: this.currency,
        email: this.email,
        amount: this.amount,
        txRef: this.txRef,
        isDebugMode: this.isDebugMode,
        narration: this.narration,
        isPermanent: this.isPermanent,
        phoneNumber: this.phoneNumber,
        frequency: this.frequency,
        duration: this.duration);
  }

  /// Returns an instance of BankAccountPaymentManager
  BankAccountPaymentManager getBankAccountPaymentManager() {
    return BankAccountPaymentManager(
        publicKey: this.publicKey,
        secretKey: this.secretKey,
        currency: this.currency,
        email: this.email,
        amount: this.amount,
        txRef: this.txRef,
        isDebugMode: this.isDebugMode,
        phoneNumber: this.phoneNumber,
        fullName: this.fullName);
  }

  /// Returns an instance of USSDPaymentManager
  USSDPaymentManager getUSSDPaymentManager() {
    return USSDPaymentManager(
        publicKey: this.publicKey,
        secretKey: this.secretKey,
        currency: this.currency,
        email: this.email,
        amount: this.amount,
        txRef: this.txRef,
        isDebugMode: this.isDebugMode,
        phoneNumber: this.phoneNumber,
        fullName: this.fullName);
  }

  /// Returns an instance of VoucherPaymentManager
  VoucherPaymentManager getVoucherPaymentManager() {
    return VoucherPaymentManager(
        publicKey: this.publicKey,
        currency: this.currency,
        amount: this.amount,
        txRef: this.txRef,
        isDebugMode: this.isDebugMode,
        phoneNumber: this.phoneNumber,
        fullName: this.fullName,
        email: this.email);
  }
}
