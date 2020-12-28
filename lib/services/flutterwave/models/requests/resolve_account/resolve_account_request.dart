class ResolveAccountRequest {
  String accountNumber;
  String acountBankCode;
  ResolveAccountRequest data;

  ResolveAccountRequest({this.accountNumber, this.acountBankCode});


  /// Initializes a new ResolveAccountRequest object from json
  ResolveAccountRequest.fromJson(Map<String, dynamic> json) {
    this.accountNumber = json['account_number'];
    this.acountBankCode = json['account_bank'];
    data = json['data'] != null
        ? new ResolveAccountRequest.fromJson(json['data'])
        : null;
  }


  /// Converts instance of ResolveAccountRequest to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_number'] = this.accountNumber;
    data['account_bank'] = this.acountBankCode;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}