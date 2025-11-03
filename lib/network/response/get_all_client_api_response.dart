// To parse this JSON data, do
//
//     final getAllClientsResponse = getAllClientsResponseFromJson(jsonString);

import 'dart:convert';

List<GetAllClientsResponse> getAllClientsResponseFromJson(String str) =>
    List<GetAllClientsResponse>.from(
        json.decode(str).map((x) => GetAllClientsResponse.fromJson(x)));

String getAllClientsResponseToJson(List<GetAllClientsResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllClientsResponse {
  String status;
  String message;
  List<GetAllClientsResponseDatum> data;

  GetAllClientsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetAllClientsResponse.fromJson(Map<String, dynamic> json) =>
      GetAllClientsResponse(
        status: json["status"],
        message: json["message"],
        data: List<GetAllClientsResponseDatum>.from(
            json["data"].map((x) => GetAllClientsResponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetAllClientsResponseDatum {
  String id;
  String clientName;
  String isDeleted;
  String status;
  DateTime updatedOn;
  DateTime createdOn;

  GetAllClientsResponseDatum({
    required this.id,
    required this.clientName,
    required this.isDeleted,
    required this.status,
    required this.updatedOn,
    required this.createdOn,
  });

  factory GetAllClientsResponseDatum.fromJson(Map<String, dynamic> json) =>
      GetAllClientsResponseDatum(
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
