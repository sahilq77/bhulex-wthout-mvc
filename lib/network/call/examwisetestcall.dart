// To parse this JSON data, do
//
//     final examwisetestcall = examwisetestcallFromJson(jsonString);

import 'dart:convert';

Examwisetestcall examwisetestcallFromJson(String str) =>
    Examwisetestcall.fromJson(json.decode(str));

String examwisetestcallToJson(Examwisetestcall data) =>
    json.encode(data.toJson());

class Examwisetestcall {
  String machineId;
  String productId;
  String date;
  int limit, offset;
  Examwisetestcall(
      {required this.machineId,
      required this.productId,
      required this.date,
      required this.limit,
      required this.offset});

  factory Examwisetestcall.fromJson(Map<String, dynamic> json) =>
      Examwisetestcall(
        machineId: json["machine_id"] ?? "",
        productId: json["product_id"] ?? "",
        date: json["date"] ?? "",
        limit: json["limit"] ?? 10,
        offset: json["offset"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "machine_id": machineId,
        "product_id": productId,
        "date": date,
        "limit": limit,
        "offset": offset
      };
}
