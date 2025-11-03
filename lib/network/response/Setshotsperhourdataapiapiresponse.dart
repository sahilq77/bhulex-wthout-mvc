// To parse this JSON data, do
//
//     final setshotsperhourdataapiapiresponse = setshotsperhourdataapiapiresponseFromJson(jsonString);

import 'dart:convert';

List<Setshotsperhourdataapiapiresponse>
    setshotsperhourdataapiapiresponseFromJson(String str) =>
        List<Setshotsperhourdataapiapiresponse>.from(json
            .decode(str)
            .map((x) => Setshotsperhourdataapiapiresponse.fromJson(x)));

String setshotsperhourdataapiapiresponseToJson(
        List<Setshotsperhourdataapiapiresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Setshotsperhourdataapiapiresponse {
  String status;
  String message;
  List<SetshotsperhourdataapiapiresponseDatum> data;

  Setshotsperhourdataapiapiresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Setshotsperhourdataapiapiresponse.fromJson(
          Map<String, dynamic> json) =>
      Setshotsperhourdataapiapiresponse(
        status: json["status"],
        message: json["message"],
        data: List<SetshotsperhourdataapiapiresponseDatum>.from(json["data"]
            .map((x) => SetshotsperhourdataapiapiresponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SetshotsperhourdataapiapiresponseDatum {
  int shotsPerHourId;
  String time;
  String productId;
  String stdShotPerHour;
  String shotsPerHour;
  String remark;
  DateTime createdOn;

  SetshotsperhourdataapiapiresponseDatum({
    required this.shotsPerHourId,
    required this.time,
    required this.productId,
    required this.stdShotPerHour,
    required this.shotsPerHour,
    required this.remark,
    required this.createdOn,
  });

  factory SetshotsperhourdataapiapiresponseDatum.fromJson(
          Map<String, dynamic> json) =>
      SetshotsperhourdataapiapiresponseDatum(
        shotsPerHourId: json["shots_per_hour_id"] ?? "",
        time: json["time"] ?? "",
        productId: json["product_id"] ?? "",
        stdShotPerHour: json["std_shot_per_hour"] ?? "",
        shotsPerHour: json["shots_per_hour"] ?? "",
        remark: json["remark"] ?? "",
        createdOn: DateTime.parse(json["created_on"]),
      );

  Map<String, dynamic> toJson() => {
        "shots_per_hour_id": shotsPerHourId,
        "time": time,
        "product_id": productId,
        "std_shot_per_hour": stdShotPerHour,
        "shots_per_hour": shotsPerHour,
        "remark": remark,
        "created_on": createdOn.toIso8601String(),
      };
}
