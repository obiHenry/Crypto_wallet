class ResolveAccountResponseData {
  String accountNumber;
  String accountName;

  ResolveAccountResponseData({this.accountNumber, this.accountName});

  ResolveAccountResponseData.fromJson(Map<String, dynamic> json) {
    accountNumber = json['account_number'];
    accountName = json['account_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_number'] = this.accountNumber;
    data['account_name'] = this.accountName;
    return data;
  }
}
