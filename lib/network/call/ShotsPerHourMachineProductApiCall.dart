import 'dart:convert';

ShotsPerHourMachineProductApi shotsPerHourMachineProductApiFromJson(
        String str) =>
    ShotsPerHourMachineProductApi.fromJson(json.decode(str));

String shotsPerHourMachineProductApiToJson(
        ShotsPerHourMachineProductApi data) =>
    json.encode(data.toJson());

class ShotsPerHourMachineProductApi {
  String machineId;

  ShotsPerHourMachineProductApi({
    required this.machineId,
  });

  factory ShotsPerHourMachineProductApi.fromJson(Map<String, dynamic> json) =>
      ShotsPerHourMachineProductApi(
        machineId: json["machine_id"],
      );

  Map<String, dynamic> toJson() => {
        "machine_id": machineId,
      };
}
