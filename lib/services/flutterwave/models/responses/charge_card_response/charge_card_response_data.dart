import 'package:Crypto_wallet/services/flutterwave/models/responses/charge_card_response/charge_card_response_card.dart';
import 'package:Crypto_wallet/services/flutterwave/models/responses/charge_card_response/charge_card_response_customer.dart';

class ChargeResponseData {
  String id;
  String txRef;
  String flwRef;
  String deviceFingerprint;
  String amount;
  String chargedAmount;
  String appFee;
  String merchantFee;
  String processorResponse;
  String authModel;
  String currency;
  String ip;
  String narration;
  String status;
  String authUrl;
  String paymentType;
  String fraudStatus;
  String chargeType;
  String createdAt;
  String accountId;
  String paymentCode;
  ChargeCardResponseCustomer customer;
  ChargeCardResponseCard card;

  ChargeResponseData(
      {this.id,
      this.txRef,
      this.flwRef,
      this.deviceFingerprint,
      this.amount,
      this.chargedAmount,
      this.appFee,
      this.merchantFee,
      this.processorResponse,
      this.authModel,
      this.currency,
      this.ip,
      this.narration,
      this.status,
      this.authUrl,
      this.paymentType,
      this.fraudStatus,
      this.chargeType,
      this.createdAt,
      this.accountId,
      this.customer,
      this.card});

  ChargeResponseData.fromJson(Map<String, dynamic> json) {
    this.id = json['id'].toString();
    this.txRef = json['tx_ref'];
    this.flwRef = json['flw_ref'];
    this.deviceFingerprint = json['device_fingerprint'];
    this.amount = json['amount'].toString();
    this.chargedAmount = json['charged_amount'].toString();
    this.appFee = json['app_fee'].toString();
    this.merchantFee = json['merchant_fee'].toString();
    this.processorResponse = json['processor_response'];
    this.authModel = json['auth_model'];
    this.currency = json['currency'];
    this.ip = json['ip'];
    this.narration = json['narration'];
    this.status = json['status'];
    this.authUrl = json['auth_url'];
    this.paymentType = json['payment_type'];
    this.fraudStatus = json['fraud_status'];
    this.paymentCode = json['payment_code'];
    this.chargeType = json['charge_type'];
    this.createdAt = json['created_at'];
    this.accountId = json['account_id'].toString();
    this.customer = json['customer'] != null
        ? new ChargeCardResponseCustomer.fromJson(json['customer'])
        : null;
    this.card = json['card'] != null
        ? new ChargeCardResponseCard.fromJson(json['card'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tx_ref'] = this.txRef;
    data['flw_ref'] = this.flwRef;
    data['device_fingerprint'] = this.deviceFingerprint;
    data['amount'] = this.amount;
    data['charged_amount'] = this.chargedAmount;
    data['app_fee'] = this.appFee;
    data['merchant_fee'] = this.merchantFee;
    data['processor_response'] = this.processorResponse;
    data['auth_model'] = this.authModel;
    data['currency'] = this.currency;
    data['ip'] = this.ip;
    data['narration'] = this.narration;
    data['status'] = this.status;
    data['auth_url'] = this.authUrl;
    data['payment_type'] = this.paymentType;
    data['fraud_status'] = this.fraudStatus;
    data['payment_code'] = this.paymentCode;
    data['charge_type'] = this.chargeType;
    data['created_at'] = this.createdAt;
    data['account_id'] = this.accountId;
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    if (this.card != null) {
      data['card'] = this.card.toJson();
    }
    return data;
  }
}
