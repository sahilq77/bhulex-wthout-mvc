// To parse this JSON data, do
//
//     final getemployeelistcall = getemployeelistcallFromJson(jsonString);

import 'dart:convert';

getTotalOngoingOrderApiCall getemployeelistcallFromJson(String str) =>
    getTotalOngoingOrderApiCall.fromJson(json.decode(str));

String getemployeelistcallToJson(getTotalOngoingOrderApiCall data) =>
    json.encode(data.toJson());

class getTotalOngoingOrderApiCall {
  String user_id;
  String pushtoken;

  getTotalOngoingOrderApiCall({
    required this.user_id,
    required this.pushtoken,
  });

  factory getTotalOngoingOrderApiCall.fromJson(Map<String, dynamic> json) =>
      getTotalOngoingOrderApiCall(
        user_id: json["user_id"],
        pushtoken: json["pushtoken"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": user_id,
        "pushtoken": pushtoken,
      };
}
