import 'dart:convert';

BatchStartRequest batchStartRequestFromJson(String str) =>
    BatchStartRequest.fromJson(json.decode(str));

String batchStartRequestToJson(BatchStartRequest data) =>
    json.encode(data.toJson());

class BatchStartRequest {
  String id;
  String machineName;
  String startDate;
  String startTime;
  String userId;

  BatchStartRequest({
    required this.id,
    required this.machineName,
    required this.startDate,
    required this.startTime,
    required this.userId,
  });

  factory BatchStartRequest.fromJson(Map<String, dynamic> json) =>
      BatchStartRequest(
        id: json["id"],
        machineName: json["machine_name"],
        startDate: json["start_date"],
        startTime: json["start_time"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "machine_name": machineName,
        "start_date": startDate,
        "start_time": startTime,
        "user_id": userId,
      };
}
