// To parse this JSON data, do
//
//     final getAllShotsPerHourHistoryDataApiResponse = getAllShotsPerHourHistoryDataApiResponseFromJson(jsonString);

import 'dart:convert';

List<GetAllShotsPerHourHistoryDataApiResponse>
    getAllShotsPerHourHistoryDataApiResponseFromJson(String str) =>
        List<GetAllShotsPerHourHistoryDataApiResponse>.from(json
            .decode(str)
            .map((x) => GetAllShotsPerHourHistoryDataApiResponse.fromJson(x)));

String getAllShotsPerHourHistoryDataApiResponseToJson(
        List<GetAllShotsPerHourHistoryDataApiResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllShotsPerHourHistoryDataApiResponse {
  String status;
  String message;
  List<GetAllShotsPerHourHistoryDataApiResponseDatum> data;

  GetAllShotsPerHourHistoryDataApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetAllShotsPerHourHistoryDataApiResponse.fromJson(
          Map<String, dynamic> json) =>
      GetAllShotsPerHourHistoryDataApiResponse(
        status: json["status"],
        message: json["message"],
        data: List<GetAllShotsPerHourHistoryDataApiResponseDatum>.from(
            json["data"].map((x) =>
                GetAllShotsPerHourHistoryDataApiResponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetAllShotsPerHourHistoryDataApiResponseDatum {
  String id;
  DateTime date;
  String machineId;
  String shotsPerHourId;
  String time;
  String productId;
  String stdShotPerHour;
  String shotsPerHour;
  String remark;
  String isDeleted;
  String status;
  DateTime createdOn;
  DateTime updatedOn;
  String product;
  String machineName;

  GetAllShotsPerHourHistoryDataApiResponseDatum({
    required this.id,
    required this.date,
    required this.machineId,
    required this.shotsPerHourId,
    required this.time,
    required this.productId,
    required this.stdShotPerHour,
    required this.shotsPerHour,
    required this.remark,
    required this.isDeleted,
    required this.status,
    required this.createdOn,
    required this.updatedOn,
    required this.product,
    required this.machineName,
  });

  factory GetAllShotsPerHourHistoryDataApiResponseDatum.fromJson(
          Map<String, dynamic> json) =>
      GetAllShotsPerHourHistoryDataApiResponseDatum(
        id: json["id"] ?? "",
        date: DateTime.parse(json["date"]),
        machineId: json["machine_id"] ?? "",
        shotsPerHourId: json["shots_per_hour_id"] ?? "",
        time: json["time"] ?? "",
        productId: json["product_id"] ?? "",
        stdShotPerHour: json["std_shot_per_hour"] ?? "",
        shotsPerHour: json["shots_per_hour"] ?? "",
        remark: json["remark"] ?? "",
        isDeleted: json["is_deleted"] ?? "",
        status: json["status"] ?? "",
        createdOn: DateTime.parse(json["created_on"]),
        updatedOn: DateTime.parse(json["updated_on"]),
        product: json["product"] ?? "",
        machineName: json["machine_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "machine_id": machineId,
        "shots_per_hour_id": shotsPerHourId,
        "time": time,
        "product_id": productId,
        "std_shot_per_hour": stdShotPerHour,
        "shots_per_hour": shotsPerHour,
        "remark": remark,
        "is_deleted": isDeleted,
        "status": status,
        "created_on": createdOn.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
        "product": product,
        "machine_name": machineName,
      };
}
