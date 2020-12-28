
import 'bank_transfer_meta.dart';

class BankTransferResponse {
  String status;
  String message;
  BankTransferMeta meta;

  BankTransferResponse({this.status, this.message, this.meta});

  BankTransferResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    meta = json['meta'] != null ? new BankTransferMeta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    return data;
  }
}
