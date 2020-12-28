class USSDRequest {
  String amount;
  String currency;
  String email;
  String txRef;
  String fullName;
  String accountBank;
  String phoneNumber;

  USSDRequest({
    this.amount,
    this.currency,
    this.email,
    this.txRef,
    this.fullName,
    this.accountBank,
    this.phoneNumber
  });

  /// Converts instance of USSDRequest to json
  Map<String, dynamic> toJson() {
    return {
      'amount': this.amount,
      'currency': this.currency,
      'email': this.email,
      'tx_ref': this.txRef,
      'fullname': this.fullName,
      'account_bank': this.accountBank,
      'phone_number': this.phoneNumber
    };
  }
}