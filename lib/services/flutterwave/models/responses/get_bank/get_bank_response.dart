class GetBanksResponse {
  String bankname;
  String bankcode;
  bool internetbanking;

  GetBanksResponse({this.bankname, this.bankcode, this.internetbanking});

  GetBanksResponse.fromJson(Map<String, dynamic> json) {
    bankname = json['name'];
    bankcode = json['code'];
    // internetbanking = json['internetbanking'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bankname'] = this.bankname;
    data['bankcode'] = this.bankcode;
    // data['internetbanking'] = this.internetbanking;
    return data;
  }
}
