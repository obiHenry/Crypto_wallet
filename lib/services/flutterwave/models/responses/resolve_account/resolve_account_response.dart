import 'resolve_account_response_data.dart';

class ResolveAccountResponse {
  String status;
  String message;
  ResolveAccountResponseData data;

  ResolveAccountResponse({this.status, this.message, this.data});

  ResolveAccountResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? new ResolveAccountResponseData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}
