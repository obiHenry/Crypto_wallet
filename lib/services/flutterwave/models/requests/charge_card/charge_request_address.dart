class ChargeRequestAddress {
  String address;
  String city;
  String state;
  String zipCode;
  String country;

  /// ChargeRequestAddress constructor
  ChargeRequestAddress({
    this.address,
    this.city,
    this.state,
    this.zipCode,
    this.country,
  });

  /// Initialized ChargeRequestAddress from a json object
  ChargeRequestAddress.fromJson(Map<String, dynamic> json) {
    this.address = json["address"];
    this.city = json["city"];
    this.state = json["state"];
    this.zipCode = json["zipcode"];
    this.country = json["country"];
  }

}
