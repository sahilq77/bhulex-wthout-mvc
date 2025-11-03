// To parse this JSON data, do
//
//     final syllabuscall = syllabuscallFromJson(jsonString);

import 'dart:convert';

instockfiltercall instockfiltercallFromJson(String str) =>
    instockfiltercall.fromJson(json.decode(str));

String instockfiltercallToJson(instockfiltercall data) =>
    json.encode(data.toJson());

class instockfiltercall {
  int offset;
  int limit;
  String clientId, branchId, itemName;
  instockfiltercall(
      {required this.offset,
      required this.limit,
      required this.clientId,
      required this.branchId,
      required this.itemName});

  factory instockfiltercall.fromJson(Map<String, dynamic> json) =>
      instockfiltercall(
          offset: json["offset"] ?? 0,
          limit: json["limit"] ?? 10,
          clientId: json["client_id"] ?? "",
          branchId: json["branch_id"] ?? "",
          itemName: json["item_name"] ?? "");

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "limit": limit,
        "client_id": clientId,
        "branch_id": branchId,
        "item_name": itemName
      };
}
