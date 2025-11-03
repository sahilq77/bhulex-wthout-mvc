// To parse this JSON data, do
//
//     final getmachinestatusapiresponse = getmachinestatusapiresponseFromJson(jsonString);

import 'dart:convert';

List<Getmachinestatusapiresponse> getmachinestatusapiresponseFromJson(
        String str) =>
    List<Getmachinestatusapiresponse>.from(
        json.decode(str).map((x) => Getmachinestatusapiresponse.fromJson(x)));

String getmachinestatusapiresponseToJson(
        List<Getmachinestatusapiresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getmachinestatusapiresponse {
  String status;
  String message;
  List<GetmachinestatusapiresponseDatum> data;

  Getmachinestatusapiresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Getmachinestatusapiresponse.fromJson(Map<String, dynamic> json) =>
      Getmachinestatusapiresponse(
        status: json["status"],
        message: json["message"],
        data: List<GetmachinestatusapiresponseDatum>.from(json["data"]
            .map((x) => GetmachinestatusapiresponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetmachinestatusapiresponseDatum {
  String machineId;
  String machineName;
  String status;

  GetmachinestatusapiresponseDatum({
    required this.machineId,
    required this.machineName,
    required this.status,
  });

  factory GetmachinestatusapiresponseDatum.fromJson(
          Map<String, dynamic> json) =>
      GetmachinestatusapiresponseDatum(
        machineId: json["machine_id"] ?? "",
        machineName: json["machine_name"] ?? "",
        status: json["status"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "machine_id": machineId,
        "machine_name": machineName,
        "status": status,
      };
}
