class ChargeCardResponseCustomer {
  String id;
  String phoneNumber;
  String name;
  String email;
  String createdAt;

  ChargeCardResponseCustomer({this.id, this.phoneNumber, this.name, this.email, this.createdAt});

  ChargeCardResponseCustomer.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    phoneNumber = json['phone_number'].toString();
    name = json['name'];
    email = json['email'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone_number'] = this.phoneNumber;
    data['name'] = this.name;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    return data;
  }
}
