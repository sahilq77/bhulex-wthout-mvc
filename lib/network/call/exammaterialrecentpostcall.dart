// To parse this JSON data, do
//
//     final exammaterialrecentpostcall = exammaterialrecentpostcallFromJson(jsonString);

import 'dart:convert';

Exammaterialrecentpostcall exammaterialrecentpostcallFromJson(String str) =>
    Exammaterialrecentpostcall.fromJson(json.decode(str));

String exammaterialrecentpostcallToJson(Exammaterialrecentpostcall data) =>
    json.encode(data.toJson());

class Exammaterialrecentpostcall {
  String fromDate;
  String toDate;
  String machineId;
  int limit, offset;
  Exammaterialrecentpostcall(
      {required this.fromDate,
      required this.toDate,
      required this.machineId,
      required this.limit,
      required this.offset});

  factory Exammaterialrecentpostcall.fromJson(Map<String, dynamic> json) =>
      Exammaterialrecentpostcall(
        fromDate: json["from_date"],
        toDate: json["to_date"],
        machineId: json["machine_id"],
        limit: json["limit"],
        offset: json["offset"],
      );

  Map<String, dynamic> toJson() => {
        "from_date": fromDate,
        "to_date": toDate,
        "machine_id": machineId,
        "limit": limit,
        "offset": offset
      };
}
