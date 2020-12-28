class ChargeCardResponseCard {
  String first6digits;
  String last4digits;
  String issuer;
  String country;
  String type;
  String expiry;

  ChargeCardResponseCard(
      {this.first6digits,
        this.last4digits,
        this.issuer,
        this.country,
        this.type,
        this.expiry});

  ChargeCardResponseCard.fromJson(Map<String, dynamic> json) {
    first6digits = json['first_6digits'];
    last4digits = json['last_4digits'];
    issuer = json['issuer'];
    country = json['country'];
    type = json['type'];
    expiry = json['expiry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_6digits'] = this.first6digits;
    data['last_4digits'] = this.last4digits;
    data['issuer'] = this.issuer;
    data['country'] = this.country;
    data['type'] = this.type;
    data['expiry'] = this.expiry;
    return data;
  }
}