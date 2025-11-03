// To parse this JSON data, do
//
//     final getOtPcall = getOtPcallFromJson(jsonString);

import 'dart:convert';

getvehicleloadinghistoryapicall getVehicleLoadingApiCallFromJson(String str) =>
    getvehicleloadinghistoryapicall.fromJson(json.decode(str));

String getVehicleLoadingApiCallToJson(getvehicleloadinghistoryapicall data) =>
    json.encode(data.toJson());

class getvehicleloadinghistoryapicall {
  String history_id;

  getvehicleloadinghistoryapicall({
    required this.history_id,
  });

  factory getvehicleloadinghistoryapicall.fromJson(Map<String, dynamic> json) =>
      getvehicleloadinghistoryapicall(
        history_id: json["history_id"],
      );

  Map<String, dynamic> toJson() => {
        "history_id": history_id,
      };
}
