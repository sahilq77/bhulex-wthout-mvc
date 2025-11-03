// To parse this JSON data, do
//
//     final syllabuscall = syllabuscallFromJson(jsonString);

import 'dart:convert';

ClientMaterialcall instockfiltercallFromJson(String str) =>
    ClientMaterialcall.fromJson(json.decode(str));

String instockfiltercallToJson(ClientMaterialcall data) =>
    json.encode(data.toJson());

class ClientMaterialcall {
  String clientId, branchId, item_group;
  ClientMaterialcall({
    required this.clientId,
    required this.branchId,
    required this.item_group,
  });

  factory ClientMaterialcall.fromJson(Map<String, dynamic> json) =>
      ClientMaterialcall(
        clientId: json["client_id"] ?? "",
        branchId: json["branch_id"] ?? "",
        item_group: json["item_group"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "client_id": clientId,
        "branch_id": branchId,
        "item_group": item_group,
      };
}
