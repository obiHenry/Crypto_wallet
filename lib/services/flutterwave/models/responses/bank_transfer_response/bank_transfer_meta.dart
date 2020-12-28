
import 'bank_transfer_authorization.dart';

class BankTransferMeta {
  BankTransferAuthorization authorization;

  BankTransferMeta({this.authorization});

  BankTransferMeta.fromJson(Map<String, dynamic> json) {
    authorization = json['authorization'] != null
        ? new BankTransferAuthorization.fromJson(json['authorization'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.authorization != null) {
      data['authorization'] = this.authorization.toJson();
    }
    return data;
  }
}
