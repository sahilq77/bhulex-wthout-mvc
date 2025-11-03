// To parse this JSON data, do
//
//     final getVehicleLoadingApiResponse = getVehicleLoadingApiResponseFromJson(jsonString);

import 'dart:convert';

List<GetVehicleLoadingApiResponse> getVehicleLoadingApiResponseFromJson(
        String str) =>
    List<GetVehicleLoadingApiResponse>.from(
        json.decode(str).map((x) => GetVehicleLoadingApiResponse.fromJson(x)));

String getVehicleLoadingApiResponseToJson(
        List<GetVehicleLoadingApiResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetVehicleLoadingApiResponse {
  String status;
  String message;
  List<GetVehicleLoadingApiResponseDatum> data;

  GetVehicleLoadingApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetVehicleLoadingApiResponse.fromJson(Map<String, dynamic> json) =>
      GetVehicleLoadingApiResponse(
        status: json["status"],
        message: json["message"],
        data: List<GetVehicleLoadingApiResponseDatum>.from(json["data"]
            .map((x) => GetVehicleLoadingApiResponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetVehicleLoadingApiResponseDatum {
  String id;
  String tempId;
  DateTime loadingDate;
  String loadingTime;
  String isDeleted;
  String status;
  DateTime updatedOn;
  DateTime createdOn;

  GetVehicleLoadingApiResponseDatum({
    required this.id,
    required this.tempId,
    required this.loadingDate,
    required this.loadingTime,
    required this.isDeleted,
    required this.status,
    required this.updatedOn,
    required this.createdOn,
  });

  factory GetVehicleLoadingApiResponseDatum.fromJson(
          Map<String, dynamic> json) =>
      GetVehicleLoadingApiResponseDatum(
        id: json["id"] ?? "",
        tempId: json["temp_id"] ?? "",
        loadingDate: DateTime.parse(json["loading_date"]),
        loadingTime: json["loading_time"] ?? "",
        isDeleted: json["is_deleted"] ?? "",
        status: json["status"] ?? "",
        updatedOn: DateTime.parse(json["updated_on"]),
        createdOn: DateTime.parse(json["created_on"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "temp_id": tempId,
        "loading_date":
            "${loadingDate.year.toString().padLeft(4, '0')}-${loadingDate.month.toString().padLeft(2, '0')}-${loadingDate.day.toString().padLeft(2, '0')}",
        "loading_time": loadingTime,
        "is_deleted": isDeleted,
        "status": status,
        "updated_on": updatedOn.toIso8601String(),
        "created_on": createdOn.toIso8601String(),
      };
}
