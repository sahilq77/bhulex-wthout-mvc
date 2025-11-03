// To parse this JSON data, do
//
//     final getbatchjobcardprintapiresponse = getbatchjobcardprintapiresponseFromJson(jsonString);

import 'dart:convert';

List<Getbatchjobcardprintapiresponse> getbatchjobcardprintapiresponseFromJson(
        String str) =>
    List<Getbatchjobcardprintapiresponse>.from(json
        .decode(str)
        .map((x) => Getbatchjobcardprintapiresponse.fromJson(x)));

String getbatchjobcardprintapiresponseToJson(
        List<Getbatchjobcardprintapiresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getbatchjobcardprintapiresponse {
  String status;
  String message;
  String data;

  Getbatchjobcardprintapiresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Getbatchjobcardprintapiresponse.fromJson(Map<String, dynamic> json) =>
      Getbatchjobcardprintapiresponse(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
        data: json["data"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
      };
}
