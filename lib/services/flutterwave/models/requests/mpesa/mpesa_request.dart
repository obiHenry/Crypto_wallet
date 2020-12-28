class MpesaRequest {
  String amount;
  String currency;
  String email;
  String txRef;
  String fullName;
  String phoneNumber;

  MpesaRequest({
    this.amount,
    this.currency,
    this.email,
    this.txRef,
    this.fullName,
    this.phoneNumber
  });

/// Converts instance of MpesaRequest to json
  Map<String, dynamic> toJson() {
    return {
      'amount': this.amount,
      'currency': this.currency,
      'email': this.email,
      'tx_ref': this.txRef,
      'fullname': this.fullName,
      'phone_number': this.phoneNumber
    };
  }
}

