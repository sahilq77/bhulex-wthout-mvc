// To parse this JSON data, do
//
//     final gettotalpendingorderapiresponse = gettotalpendingorderapiresponseFromJson(jsonString);

import 'dart:convert';

List<Gettotalpendingorderapiresponse> gettotalpendingorderapiresponseFromJson(
        String str) =>
    List<Gettotalpendingorderapiresponse>.from(json
        .decode(str)
        .map((x) => Gettotalpendingorderapiresponse.fromJson(x)));

String gettotalpendingorderapiresponseToJson(
        List<Gettotalpendingorderapiresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Gettotalpendingorderapiresponse {
  String status;
  String message;
  GettotalpendingorderapiresponseData data;

  Gettotalpendingorderapiresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Gettotalpendingorderapiresponse.fromJson(Map<String, dynamic> json) =>
      Gettotalpendingorderapiresponse(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
        data: GettotalpendingorderapiresponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class GettotalpendingorderapiresponseData {
  String totalPendingCount;

  GettotalpendingorderapiresponseData({
    required this.totalPendingCount,
  });

  factory GettotalpendingorderapiresponseData.fromJson(
          Map<String, dynamic> json) =>
      GettotalpendingorderapiresponseData(
        totalPendingCount: json["total_pending_count"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "total_pending_count": totalPendingCount,
      };
}
