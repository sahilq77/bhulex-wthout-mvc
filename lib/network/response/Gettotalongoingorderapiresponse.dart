// To parse this JSON data, do
//
//     final gettotalongoingorderapiresponse = gettotalongoingorderapiresponseFromJson(jsonString);

import 'dart:convert';

List<Gettotalongoingorderapiresponse> gettotalongoingorderapiresponseFromJson(
        String str) =>
    List<Gettotalongoingorderapiresponse>.from(json
        .decode(str)
        .map((x) => Gettotalongoingorderapiresponse.fromJson(x)));

String gettotalongoingorderapiresponseToJson(
        List<Gettotalongoingorderapiresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Gettotalongoingorderapiresponse {
  String status;
  String message;
  GettotalongoingorderapiresponseData data;

  Gettotalongoingorderapiresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Gettotalongoingorderapiresponse.fromJson(Map<String, dynamic> json) =>
      Gettotalongoingorderapiresponse(
        status: json["status"],
        message: json["message"],
        data: GettotalongoingorderapiresponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class GettotalongoingorderapiresponseData {
  String totalOngoingCount;

  GettotalongoingorderapiresponseData({
    required this.totalOngoingCount,
  });

  factory GettotalongoingorderapiresponseData.fromJson(
          Map<String, dynamic> json) =>
      GettotalongoingorderapiresponseData(
        totalOngoingCount: json["total_ongoing_count"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "total_ongoing_count": totalOngoingCount,
      };
}
