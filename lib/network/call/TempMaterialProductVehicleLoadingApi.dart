import 'dart:convert';

TempMaterialProductVehicleLoadingApi tempMaterialProductVehicleLoadingApiFromJson(String str) =>
    TempMaterialProductVehicleLoadingApi.fromJson(json.decode(str));

String tempMaterialProductVehicleLoadingApiToJson(TempMaterialProductVehicleLoadingApi data) =>
    json.encode(data.toJson());

class TempMaterialProductVehicleLoadingApi {
  String id;

  TempMaterialProductVehicleLoadingApi({
    required this.id,
  });

  factory TempMaterialProductVehicleLoadingApi.fromJson(Map<String, dynamic> json) =>
      TempMaterialProductVehicleLoadingApi(
        id: json["id"],  // Matching field name from JSON
      );

  Map<String, dynamic> toJson() => {
        "id": id,  // Matching field name for output JSON
      };
}
