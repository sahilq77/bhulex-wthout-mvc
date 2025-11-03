// To parse this JSON data, do
//
//     final getOtPcall = getOtPcallFromJson(jsonString);

import 'dart:convert';

getclientbranchapicall getclientbranchapicallFromJson(String str) =>
    getclientbranchapicall.fromJson(json.decode(str));

String getclientbranchapicallToJson(getclientbranchapicall data) =>
    json.encode(data.toJson());

class getclientbranchapicall {
  String clientId;

  getclientbranchapicall({
    required this.clientId,
  });

  factory getclientbranchapicall.fromJson(Map<String, dynamic> json) =>
      getclientbranchapicall(
        clientId: json["client_id"],
      );

  Map<String, dynamic> toJson() => {
        "client_id": clientId,
      };
}
