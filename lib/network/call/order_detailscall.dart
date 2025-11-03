// To parse this JSON data, do
//
//     final getemployeelistcall = getemployeelistcallFromJson(jsonString);

import 'dart:convert';

orderdetailscall getemployeelistcallFromJson(String str) =>
    orderdetailscall.fromJson(json.decode(str));

String getemployeelistcallToJson(orderdetailscall data) =>
    json.encode(data.toJson());

class orderdetailscall {
  String customerId;
  String leadId, tblName;

  orderdetailscall({
    required this.customerId,
    required this.leadId,
    required this.tblName,
  });

  factory orderdetailscall.fromJson(Map<String, dynamic> json) =>
      orderdetailscall(
        customerId: json["customer_id"],
        leadId: json["lead_id"],
        tblName: json["tbl_name"],
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "lead_id": leadId,
        "tbl_name": tblName,
      };
}
