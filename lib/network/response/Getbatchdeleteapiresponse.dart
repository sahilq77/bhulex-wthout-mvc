// To parse this JSON data, do
//
//     final getbatchdeleteapiresponse = getbatchdeleteapiresponseFromJson(jsonString);

import 'dart:convert';

List<Getbatchdeleteapiresponse> getbatchdeleteapiresponseFromJson(String str) =>
    List<Getbatchdeleteapiresponse>.from(
        json.decode(str).map((x) => Getbatchdeleteapiresponse.fromJson(x)));

String getbatchdeleteapiresponseToJson(List<Getbatchdeleteapiresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getbatchdeleteapiresponse {
  String status;
  String message;

  Getbatchdeleteapiresponse({
    required this.status,
    required this.message,
  });

  factory Getbatchdeleteapiresponse.fromJson(Map<String, dynamic> json) =>
      Getbatchdeleteapiresponse(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
