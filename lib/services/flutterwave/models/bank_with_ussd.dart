class BanksWithUssd {
  
  BanksWithUssd(this.bankName, this.bankCode);
  
  String bankName;
  String bankCode;

  static List<BanksWithUssd> getBanks() {
    final BanksWithUssd fidelity = BanksWithUssd("Fidelity Bank", "070");
    final BanksWithUssd gtb = BanksWithUssd("Guaranty Trust Bank", "058");
    final BanksWithUssd keystone = BanksWithUssd("Keystone Bank", "082");
    final BanksWithUssd sterling = BanksWithUssd("Sterling Bank", "232");
    final BanksWithUssd uba = BanksWithUssd("United Bank For Bank", "033");
    final BanksWithUssd unity = BanksWithUssd("Unity Bank", "215");
    final BanksWithUssd zenith = BanksWithUssd("Zenith Bank", "057");
    return[fidelity, gtb, keystone, sterling, uba, unity, zenith];
  }
}