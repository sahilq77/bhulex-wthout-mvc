// To parse this JSON data, do
//
//     final syllabuscall = syllabuscallFromJson(jsonString);

import 'dart:convert';

batchprocessinglistcall batchprocessinglistcallFromJson(String str) =>
    batchprocessinglistcall.fromJson(json.decode(str));

String batchprocessinglistcallToJson(batchprocessinglistcall data) =>
    json.encode(data.toJson());

class batchprocessinglistcall {
  int offset;
  int limit;
  String clientName, productName, fromDate, toDate, itemGroup, branchId;
  batchprocessinglistcall(
      {required this.offset,
      required this.limit,
      required this.clientName,
      required this.productName,
      required this.fromDate,
      required this.toDate,
      required this.itemGroup,
      required this.branchId});

  factory batchprocessinglistcall.fromJson(Map<String, dynamic> json) =>
      batchprocessinglistcall(
        offset: json["offset"] ?? "0",
        limit: json["limit"] ?? "10",
        clientName: json["client_id"] ?? "",
        productName: json["product_id"] ?? "",
        fromDate: json["fromDate"] ?? "",
        toDate: json["toDate"] ?? "",
        itemGroup: json["itemGroup"] ?? "",
        branchId: json["branchId"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "limit": limit,
        "client_id": clientName,
        "product_id": productName,
        "fromDate": fromDate,
        "toDate": toDate,
        "itemGroup": itemGroup,
        "branchId": branchId,
      };
}
