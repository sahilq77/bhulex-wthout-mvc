// To parse this JSON data, do
//
//     final syllabuscall = syllabuscallFromJson(jsonString);

import 'dart:convert';

batchsfiltercall batchsfiltercallFromJson(String str) =>
    batchsfiltercall.fromJson(json.decode(str));

String batchsfiltercallToJson(batchsfiltercall data) =>
    json.encode(data.toJson());

class batchsfiltercall {
  int offset;
  int limit;
  String clientId, branchId, financialYear, fromDate, toDate, itemGroup;
  batchsfiltercall(
      {required this.offset,
      required this.limit,
      required this.clientId,
      required this.financialYear,
      required this.fromDate,
      required this.toDate,
      required this.branchId,
      required this.itemGroup});

  factory batchsfiltercall.fromJson(Map<String, dynamic> json) =>
      batchsfiltercall(
          offset: json["offset"] ?? 0,
          limit: json["limit"] ?? 10,
          clientId: json["client_id"] ?? "",
          financialYear: json["financial_year"] ?? "",
          fromDate: json["from_date"] ?? "",
          toDate: json["to_date"] ?? "",
          branchId: json["branch_id"] ?? "",
          itemGroup: json["item_group"] ?? "");

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "limit": limit,
        "client_id": clientId,
        "financial_year": financialYear,
        "from_date": fromDate,
        "to_date": toDate,
        "branch_id": branchId,
        "item_group": itemGroup
      };
}
