// To parse this JSON data, do
//
//     final generateorderdeleteapiresponse = generateorderdeleteapiresponseFromJson(jsonString);

import 'dart:convert';

List<Generateorderdeleteapiresponse> generateorderdeleteapiresponseFromJson(
        String str) =>
    List<Generateorderdeleteapiresponse>.from(json
        .decode(str)
        .map((x) => Generateorderdeleteapiresponse.fromJson(x)));

String generateorderdeleteapiresponseToJson(
        List<Generateorderdeleteapiresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Generateorderdeleteapiresponse {
  String status;
  String message;

  Generateorderdeleteapiresponse({
    required this.status,
    required this.message,
  });

  factory Generateorderdeleteapiresponse.fromJson(Map<String, dynamic> json) =>
      Generateorderdeleteapiresponse(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
