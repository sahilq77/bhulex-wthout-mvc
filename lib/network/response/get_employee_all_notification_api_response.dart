// To parse this JSON data, do
//
//     final getEmployeeAllNotificationApiResponse = getEmployeeAllNotificationApiResponseFromJson(jsonString);

import 'dart:convert';

List<GetEmployeeAllNotificationApiResponse>
    getEmployeeAllNotificationApiResponseFromJson(String str) =>
        List<GetEmployeeAllNotificationApiResponse>.from(json
            .decode(str)
            .map((x) => GetEmployeeAllNotificationApiResponse.fromJson(x)));

String getEmployeeAllNotificationApiResponseToJson(
        List<GetEmployeeAllNotificationApiResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetEmployeeAllNotificationApiResponse {
  String status;
  String message;
  List<GetEmployeeAllNotificationApiResponseDatum> data;

  GetEmployeeAllNotificationApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetEmployeeAllNotificationApiResponse.fromJson(
          Map<String, dynamic> json) =>
      GetEmployeeAllNotificationApiResponse(
        status: json["status"],
        message: json["message"],
        data: List<GetEmployeeAllNotificationApiResponseDatum>.from(json["data"]
            .map(
                (x) => GetEmployeeAllNotificationApiResponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetEmployeeAllNotificationApiResponseDatum {
  String userId;
  String notificationTitle;
  String recordId;
  String notificationDescription;
  String appRedirectionUrl;
  DateTime createdOn;

  GetEmployeeAllNotificationApiResponseDatum({
    required this.userId,
    required this.notificationTitle,
    required this.recordId,
    required this.notificationDescription,
    required this.appRedirectionUrl,
    required this.createdOn,
  });

  factory GetEmployeeAllNotificationApiResponseDatum.fromJson(
          Map<String, dynamic> json) =>
      GetEmployeeAllNotificationApiResponseDatum(
        userId: json["user_id"] ?? "",
        notificationTitle: json["notification_title"] ?? "",
        recordId: json["record_id"] ?? "",
        notificationDescription: json["notification_description"] ?? "",
        appRedirectionUrl: json["app_redirection_url"] ?? "",
        createdOn: DateTime.parse(json["created_on"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "notification_title": notificationTitle,
        "record_id": recordId,
        "notification_description": notificationDescription,
        "app_redirection_url": appRedirectionUrl,
        "created_on": createdOn.toIso8601String(),
      };
}
