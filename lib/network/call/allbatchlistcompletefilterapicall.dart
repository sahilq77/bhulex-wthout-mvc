// To parse this JSON data, do
//
//     final syllabuscall = syllabuscallFromJson(jsonString);

import 'dart:convert';

allbatchlistcompletefilterapicall allbatchlistcompletefilterapicallFromJson(
        String str) =>
    allbatchlistcompletefilterapicall.fromJson(json.decode(str));

String allbatchlistcompletefilterapicallToJson(
        allbatchlistcompletefilterapicall data) =>
    json.encode(data.toJson());

class allbatchlistcompletefilterapicall {
  int offset;
  int limit;
  String clientId, productName, itemGroup, branchId;
  allbatchlistcompletefilterapicall(
      {required this.offset,
      required this.limit,
      required this.clientId,
      required this.productName,
      // required this.fromDate,
      // required this.toDate,
      required this.itemGroup,
      required this.branchId});

  factory allbatchlistcompletefilterapicall.fromJson(
          Map<String, dynamic> json) =>
      allbatchlistcompletefilterapicall(
        offset: json["offset"],
        limit: json["limit"],
        clientId: json["client_id"] ?? "",
        productName: json["product_name"] ?? "",
        // fromDate: json["from_date"] ?? "",
        // toDate: json["to_date"] ?? "",
        itemGroup: json["item_group"] ?? "",
        branchId: json["branch_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "limit": limit,
        "client_id": clientId,
        "product_name": productName,
        // "from_date": fromDate,
        // "to_date": toDate,
        "item_group": itemGroup,
        "branch_id": branchId
      };
}
