// To parse this JSON data, do
//
//     final getOtPcall = getOtPcallFromJson(jsonString);

import 'dart:convert';

getvehicleloadingapicall getvehicleloadingapicallFromJson(String str) =>
    getvehicleloadingapicall.fromJson(json.decode(str));

String getvehicleloadingapicallToJson(getvehicleloadingapicall data) =>
    json.encode(data.toJson());

class getvehicleloadingapicall {
  String customerId, packageId;
  int offset, limit;
  getvehicleloadingapicall({
    required this.customerId,
    required this.offset,
    required this.limit,
    required this.packageId,
  });

  factory getvehicleloadingapicall.fromJson(Map<String, dynamic> json) =>
      getvehicleloadingapicall(
        customerId: json["customer_id"] ?? "",
        offset: json["offset"] ?? 0,
        limit: json["limit"] ?? 10,
        packageId: json["package_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "offset": offset,
        "limit": limit,
        "package_id": packageId,
      };
}
