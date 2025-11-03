// To parse this JSON data, do
//
//     final syllabuscall = syllabuscallFromJson(jsonString);

import 'dart:convert';

batchprocessinglisfiltercall batchprocessinglisfiltercallFromJson(String str) =>
    batchprocessinglisfiltercall.fromJson(json.decode(str));

String batchprocessinglisfiltercallToJson(batchprocessinglisfiltercall data) =>
    json.encode(data.toJson());

class batchprocessinglisfiltercall {
  int offset;
  int limit;
  String machineId, productId, fromDate, toDate, itemGroup, branchId;
  batchprocessinglisfiltercall(
      {required this.offset,
      required this.limit,
      required this.machineId,
      required this.productId,
      required this.fromDate,
      required this.toDate,
      required this.itemGroup,
      required this.branchId});

  factory batchprocessinglisfiltercall.fromJson(Map<String, dynamic> json) =>
      batchprocessinglisfiltercall(
        offset: json["offset"] ?? "0",
        limit: json["limit"] ?? "10",
        machineId: json["machine_id"] ?? "",
        productId: json["product_id"] ?? "",
        fromDate: json["fromDate"] ?? "",
        toDate: json["toDate"] ?? "",
        itemGroup: json["itemGroup"] ?? "",
        branchId: json["branchId"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "limit": limit,
        "machine_id": machineId,
        "product_id": productId,
        "fromDate": fromDate,
        "toDate": toDate,
        "itemGroup": itemGroup,
        "branchId": branchId,
      };
}
