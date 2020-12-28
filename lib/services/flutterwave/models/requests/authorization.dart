class Authorization {
  static const String AVS = "avs_noauth";
  static const String REDIRECT = "redirect";
  static const String OTP = "otp";
  static const String PIN = "pin";
  static const String CALLBACK = "callback";

  String mode;
  String pin;
  String endpoint;
  String redirect;
  String otp;
  String address;
  String city;
  String state;
  String zipcode;
  String country;
  String note;
  List<dynamic> fields;
  String validateInstructions;

  Authorization({this.mode, this.endpoint});
  
  Authorization.fromJson(Map<String, dynamic> json) {
    this.mode = json['mode'];
    this.endpoint = json['endpoint'];
    this.fields = json["fields"];
    this.redirect = json["redirect"];
    this.pin = json["pin"];
    this.otp = json["otp"];
    this.address = json["address"];
    this.city = json["city"];
    this.state = json["state"];
    this.zipcode = json["zipcode"];
    this.country = json["country"];
    this.note = json["note"];
    this.validateInstructions = json["validate_instructions"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["mode"] = this.mode;
    data["endpoint"] = this.endpoint;
    data["fields"] = this.fields;
    data["redirect"] = this.redirect;
    data["pin"] = this.pin;
    data["otp"] = this.otp;
    data["address"] = this.address;
    data["city"] = this.city;
    data["state"] = this.state;
    data["zipcode"] = this.zipcode;
    data["country"] = this.country;
    data["note"] = this.note;
    data["validate_instructions"] = this.validateInstructions;
    return data;
  }

}