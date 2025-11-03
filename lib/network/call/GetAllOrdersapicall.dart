// To parse this JSON data, do
//
//     final getOtPcall = getOtPcallFromJson(jsonString);

import 'dart:convert';

GetAllOrdersapicall getvehicleloadingapicallFromJson(String str) =>
    GetAllOrdersapicall.fromJson(json.decode(str));

String getvehicleloadingapicallToJson(GetAllOrdersapicall data) =>
    json.encode(data.toJson());

// class GetAllOrdersapicall {
//   String customerId, service_id;
//   int offset, limit;
//   GetAllOrdersapicall({
//     required this.customerId,
//     required this.offset,
//     required this.limit,
//     required this.service_id,
//   });

//   factory GetAllOrdersapicall.fromJson(Map<String, dynamic> json) =>
//       GetAllOrdersapicall(
//         customerId: json["customer_id"] ?? "",
//         offset: json["offset"] ?? 0,
//         limit: json["limit"] ?? 10,
//         service_id: json["service_name"] ?? "",
//       );

//   Map<String, dynamic> toJson() => {
//         "customer_id": customerId,
//         "offset": offset,
//         "limit": limit,
//         "service_name": service_id,
//       };
// }
class GetAllOrdersapicall {
  final String customerId;
  final int offset;
  final int limit;
  final String serviceId, package_id; // Assuming this is what packageId maps to
  // final String language;

  GetAllOrdersapicall({
    required this.customerId,
    required this.offset,
    required this.limit,
    required this.serviceId,
    // required this.language,
    required this.package_id,
  });

  factory GetAllOrdersapicall.fromJson(Map<String, dynamic> json) {
    return GetAllOrdersapicall(
      customerId: json['customer_id'] ?? '',
      offset: json['offset'] ?? 0,
      limit: json['limit'] ?? 10,
      serviceId: json['service_id'] ?? '',
      // language: json['language'] ?? 'en',
      package_id: json['package_id'] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "customer_id": customerId,
    "offset": offset,
    "limit": limit,
    "service_id": serviceId,
    // "lang": language, // Adjust key as per API requirement (e.g., "language")
    "package_id": package_id,
  };
}
