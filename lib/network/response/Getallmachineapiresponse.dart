// To parse this JSON data, do
//
//     final getallmachineapiresponse = getallmachineapiresponseFromJson(jsonString);

import 'dart:convert';

List<Getallmachineapiresponse> getallmachineapiresponseFromJson(String str) =>
    List<Getallmachineapiresponse>.from(
        json.decode(str).map((x) => Getallmachineapiresponse.fromJson(x)));

String getallmachineapiresponseToJson(List<Getallmachineapiresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getallmachineapiresponse {
  String status;
  String message;
  List<GetallmachineapiresponseDatum> data;

  Getallmachineapiresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Getallmachineapiresponse.fromJson(Map<String, dynamic> json) =>
      Getallmachineapiresponse(
        status: json["status"],
        message: json["message"],
        data: List<GetallmachineapiresponseDatum>.from(
            json["data"].map((x) => GetallmachineapiresponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetallmachineapiresponseDatum {
  String id;
  String machineName;
  String number;
  String activity;
  String isDeleted;
  String status;
  DateTime createdOn;
  DateTime updatedOn;

  GetallmachineapiresponseDatum({
    required this.id,
    required this.machineName,
    required this.number,
    required this.activity,
    required this.isDeleted,
    required this.status,
    required this.createdOn,
    required this.updatedOn,
  });

  factory GetallmachineapiresponseDatum.fromJson(Map<String, dynamic> json) =>
      GetallmachineapiresponseDatum(
        id: json["id"] ?? "",
        machineName: json["machine_name"] ?? "",
        number: json["number"] ?? "",
        activity: json["activity"] ?? "",
        isDeleted: json["is_deleted"] ?? "",
        status: json["status"],
        createdOn: DateTime.parse(json["created_on"]),
        updatedOn: DateTime.parse(json["updated_on"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "machine_name": machineName,
        "number": number,
        "activity": activity,
        "is_deleted": isDeleted,
        "status": status,
        "created_on": createdOn.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
      };
}
