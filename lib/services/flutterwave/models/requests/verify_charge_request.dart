class VerifyChargeRequest {
  String flwRef;

  VerifyChargeRequest(this.flwRef);

  VerifyChargeRequest.fromJson(Map<String, dynamic> json) {
    this.flwRef = json["flw_ref"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["flw_ref"] = this.flwRef;
    return data;
  }
}