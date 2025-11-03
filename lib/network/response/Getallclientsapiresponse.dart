// To parse this JSON data, do
//
//     final getallclientsapiresponse = getallclientsapiresponseFromJson(jsonString);

import 'dart:convert';

List<Getallclientsapiresponse> getallclientsapiresponseFromJson(String str) =>
    List<Getallclientsapiresponse>.from(
        json.decode(str).map((x) => Getallclientsapiresponse.fromJson(x)));

String getallclientsapiresponseToJson(List<Getallclientsapiresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getallclientsapiresponse {
  String status;
  String message;
  List<GetallclientsapiresponseDatum> data;

  Getallclientsapiresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Getallclientsapiresponse.fromJson(Map<String, dynamic> json) =>
      Getallclientsapiresponse(
        status: json["status"],
        message: json["message"],
        data: List<GetallclientsapiresponseDatum>.from(
            json["data"].map((x) => GetallclientsapiresponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetallclientsapiresponseDatum {
  String id;
  String clientName;
  String isDeleted;
  String status;
  DateTime updatedOn;
  DateTime createdOn;

  GetallclientsapiresponseDatum({
    required this.id,
    required this.clientName,
    required this.isDeleted,
    required this.status,
    required this.updatedOn,
    required this.createdOn,
  });

  factory GetallclientsapiresponseDatum.fromJson(Map<String, dynamic> json) =>
      GetallclientsapiresponseDatum(
        id: json["id"] ?? "",
        clientName: json["client_name"] ?? "",
        isDeleted: json["is_deleted"] ?? "",
        status: json["status"] ?? "",
        updatedOn: DateTime.parse(json["updated_on"]),
        createdOn: DateTime.parse(json["created_on"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_name": clientName,
        "is_deleted": isDeleted,
        "status": status,
        "updated_on": updatedOn.toIso8601String(),
        "created_on": createdOn.toIso8601String(),
      };
}
