// To parse this JSON data, do
//
//     final getallshotsperhourdataapiresponse = getallshotsperhourdataapiresponseFromJson(jsonString);

import 'dart:convert';

List<Getallshotsperhourdataapiresponse>
    getallshotsperhourdataapiresponseFromJson(String str) =>
        List<Getallshotsperhourdataapiresponse>.from(json
            .decode(str)
            .map((x) => Getallshotsperhourdataapiresponse.fromJson(x)));

String getallshotsperhourdataapiresponseToJson(
        List<Getallshotsperhourdataapiresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getallshotsperhourdataapiresponse {
  String status;
  String message;
  List<GetallshotsperhourdataapiresponseDatum> data;

  Getallshotsperhourdataapiresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Getallshotsperhourdataapiresponse.fromJson(
          Map<String, dynamic> json) =>
      Getallshotsperhourdataapiresponse(
        status: json["status"],
        message: json["message"],
        data: List<GetallshotsperhourdataapiresponseDatum>.from(json["data"]
            .map((x) => GetallshotsperhourdataapiresponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetallshotsperhourdataapiresponseDatum {
  String id;
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
  String machineId;
  DateTime date;

  GetallshotsperhourdataapiresponseDatum({
    required this.id,
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
    required this.machineId,
    required this.date,
  });

  factory GetallshotsperhourdataapiresponseDatum.fromJson(
          Map<String, dynamic> json) =>
      GetallshotsperhourdataapiresponseDatum(
        id: json["id"] ?? "",
        shotsPerHourId: json["shots_per_hour_id"] ?? "",
        time: json["time"] ?? "",
        productId: json["product_id"] ?? "",
        stdShotPerHour: json["std_shot_per_hour"] ?? "",
        shotsPerHour: json["shots_per_hour"] ?? "",
        remark: json["remark"] ?? "",
        isDeleted: json["is_deleted"] ?? "",
        status: json["status"] ?? "",
        createdOn: json["created_on"] != null
            ? DateTime.parse(json["created_on"])
            : DateTime.now(),
        updatedOn: json["updated_on"] != null
            ? DateTime.parse(json["updated_on"])
            : DateTime.now(),
        product: json["product"] ?? "",
        machineName: json["machine_name"] ?? "",
        machineId: json["machine_id"] ?? "",
        date: json["date"] != null
            ? DateTime.parse(json["date"])
            : DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? "",
        "shots_per_hour_id": shotsPerHourId ?? "",
        "time": time ?? "",
        "product_id": productId ?? "",
        "std_shot_per_hour": stdShotPerHour ?? "",
        "shots_per_hour": shotsPerHour ?? "",
        "remark": remark ?? "",
        "is_deleted": isDeleted ?? "",
        "status": status ?? "",
        "created_on": createdOn.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
        "product": product ?? "",
        "machine_name": machineName ?? "",
        "machine_id": machineId ?? "",
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };
}
