import 'dart:convert';

GetNotificationCall getNotificationCallFromJson(String str) =>
    GetNotificationCall.fromJson(json.decode(str));

String getNotificationCallToJson(GetNotificationCall data) =>
    json.encode(data.toJson());

class GetNotificationCall {
  String loginId;
  String offset;
  String limit;

  GetNotificationCall({
    required this.loginId,
    required this.offset,
    required this.limit,
  });

  factory GetNotificationCall.fromJson(Map<String, dynamic> json) =>
      GetNotificationCall(
        loginId: json["login_id"],
        offset: json["offset"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "offset": offset,
        "limit": limit,
      };
}
