// To parse this JSON data, do
//
//     final syllabussubjectwisetypecall = syllabussubjectwisetypecallFromJson(jsonString);

import 'dart:convert';

getproductsapicall syllabussubjectwisetypecallFromJson(String str) =>
    getproductsapicall.fromJson(json.decode(str));

String syllabussubjectwisetypecallToJson(getproductsapicall data) =>
    json.encode(data.toJson());

class getproductsapicall {
  String clientId;
  String itemGroup;
  String branchName;

  getproductsapicall({
    required this.clientId,
    required this.itemGroup,
    required this.branchName,
  });

  factory getproductsapicall.fromJson(Map<String, dynamic> json) =>
      getproductsapicall(
        clientId: json["client_id"],
        itemGroup: json["item_group"],
        branchName: json["branch_name"],
      );

  Map<String, dynamic> toJson() => {
        "client_id": clientId,
        "item_group": itemGroup,
        "branch_name": branchName,
      };
}
