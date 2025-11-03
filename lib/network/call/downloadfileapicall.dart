// To parse this JSON data, do
//
//     final getemployeelistcall = getemployeelistcallFromJson(jsonString);

import 'dart:convert';

downloadfileapicall getemployeelistcallFromJson(String str) =>
    downloadfileapicall.fromJson(json.decode(str));

String getemployeelistcallToJson(downloadfileapicall data) =>
    json.encode(data.toJson());

class downloadfileapicall {
  String customerId;
  String document_id, tblName;

  downloadfileapicall({
    required this.customerId,
    required this.document_id,
    required this.tblName,
  });

  factory downloadfileapicall.fromJson(Map<String, dynamic> json) =>
      downloadfileapicall(
        customerId: json["customer_id"],
        document_id: json["document_id"],
        tblName: json["tbl_name"],
      );

  Map<String, dynamic> toJson() => {
    "customer_id": customerId,
    "document_id": document_id,
    "tbl_name": tblName,
  };
}
