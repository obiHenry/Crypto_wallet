class Card {
  String cardNumber;
  String nameOnCard;
  String expiryDate;
  String cvv;
  String city;
  String state;
  String address_1;
  String address_2;
  String expiryMonth;
  String expiryYear;

  Card({
    this.cardNumber,
    this.cvv,
    this.expiryMonth,
    this.expiryYear
  });

  Card.virtual({
    this.cardNumber,
    this.nameOnCard,
    this.expiryDate,
    this.cvv,
    this.city,
    this.state,
    this.address_1,
    this.address_2,
  });

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      cardNumber: json["card_pan"],
      cvv: json["cvv"],
      expiryMonth: json["expiry_month"],
      expiryYear: json["expiry_year"]
    );
  }

  factory Card.virtualCardFromJson(Map<String, dynamic> json) {
    return Card.virtual(
        cardNumber: json["card_pan"],
        nameOnCard: json["name_on_card"],
        expiryDate: json["expiration"],
        cvv: json["cvv"],
        city: json["city"],
        state: json["state"],
        address_1: json["address_1"],
        address_2: json["address_2"]
    );
  }
}
