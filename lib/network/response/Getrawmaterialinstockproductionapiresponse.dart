// To parse this JSON data, do
//
//     final getrawmaterialinstockproductionapiresponse = getrawmaterialinstockproductionapiresponseFromJson(jsonString);

import 'dart:convert';

Getrawmaterialinstockproductionapiresponse
    getrawmaterialinstockproductionapiresponseFromJson(String str) =>
        Getrawmaterialinstockproductionapiresponse.fromJson(json.decode(str));

String getrawmaterialinstockproductionapiresponseToJson(
        Getrawmaterialinstockproductionapiresponse data) =>
    json.encode(data.toJson());

class Getrawmaterialinstockproductionapiresponse {
  String status;
  String message;
  GetrawmaterialinstockproductionapiresponseData data;

  Getrawmaterialinstockproductionapiresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Getrawmaterialinstockproductionapiresponse.fromJson(
          Map<String, dynamic> json) =>
      Getrawmaterialinstockproductionapiresponse(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
        data: GetrawmaterialinstockproductionapiresponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class GetrawmaterialinstockproductionapiresponseData {
  String totalInwardMaterial;

  GetrawmaterialinstockproductionapiresponseData({
    required this.totalInwardMaterial,
  });

  factory GetrawmaterialinstockproductionapiresponseData.fromJson(Map<String, dynamic> json) => GetrawmaterialinstockproductionapiresponseData(
        totalInwardMaterial: json["total_inward_material"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "total_inward_material": totalInwardMaterial,
      };
}
