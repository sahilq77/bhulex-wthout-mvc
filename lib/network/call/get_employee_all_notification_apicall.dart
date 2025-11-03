// To parse this JSON data, do
//
//     final userprofilecall = userprofilecallFromJson(jsonString);

import 'dart:convert';

getemployeeallnotificationapicall getemployeeallnotificationapicallFromJson(
        String str) =>
    getemployeeallnotificationapicall.fromJson(json.decode(str));

String getemployeeallnotificationapicallToJson(
        getemployeeallnotificationapicall data) =>
    json.encode(data.toJson());

class getemployeeallnotificationapicall {
  String userId;
  int limit, offset;
  getemployeeallnotificationapicall(
      {required this.userId, required this.limit, required this.offset});

  factory getemployeeallnotificationapicall.fromJson(
          Map<String, dynamic> json) =>
      getemployeeallnotificationapicall(
        userId: json["user_id"],
        limit: json["limit"],
        offset: json["offset"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "limit": limit,
        "offset": offset,
      };
}
