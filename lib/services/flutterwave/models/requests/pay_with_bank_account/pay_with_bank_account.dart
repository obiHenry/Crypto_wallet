class BankAccountPaymentRequest {
  String amount;
  String currency;
  String email;
  String fullName;
  String txRef;
  String phoneNumber;
  String accountBank;
  String accountNumber;

  BankAccountPaymentRequest(
      {this.amount,
      this.currency,
      this.email,
      this.fullName,
      this.txRef,
      this.phoneNumber,
      this.accountNumber,
      this.accountBank});

/// Converts instance of BankAccountPaymentRequest to json
  Map<String, dynamic> toJson() {
    return {
      'amount': this.amount,
      'currency': this.currency,
      'email': this.email,
      'tx_ref': this.txRef,
      'fullname': this.fullName,
      'account_bank': this.accountBank,
      'account_number': this.accountNumber,
      'phone_number': this.phoneNumber
    };
  }
}
