class BankTransferRequest {
  String amount;
  String currency;
  String duration;
  String email;
  String frequency;
  String isPermanent;
  String narration;
  String txRef;
  String phoneNumber;


  /// BankTransferRequest constructor
  BankTransferRequest({
    this.amount,
    this.currency,
    this.duration,
    this.email,
    this.frequency,
    this.isPermanent,
    this.narration,
    this.txRef,
    this.phoneNumber
  });

  /// Constructor to initialize BankTransferRequest from json
  BankTransferRequest.fromJson(Map<String, dynamic> json) {
    this.amount = json['amount'];
    this.currency = json['currency'];
    this.duration = json['duration'];
    this.email = json['email'];
    this.frequency = json['frequency'];
    this.isPermanent = json['is_permanent'];
    this.narration = json['narration'];
    this.txRef = json['tx_ref'];
    this.phoneNumber = json["phone_number"];
  }

  /// Converts BankTransferRequest instance to a map
  Map<String, dynamic> toJson() {
    return {
      'amount': this.amount,
      'currency': this.currency,
      'duration': this.duration,
      'email': this.email,
      'frequency': this.frequency,
      'is_permanent': this.isPermanent,
      'narration': this.narration,
      'tx_ref': this.txRef,
      'phone_number': this.phoneNumber
    };
  }
}
