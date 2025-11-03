import 'dart:convert';

// To parse the delete account request, do
//
//     final deleteAccountCall = deleteAccountCallFromJson(jsonString);

getclientbranchapiCall getclientbranchapiCallFromJson(String str) =>
    getclientbranchapiCall.fromJson(json.decode(str));

String getclientbranchapiCallToJson(getclientbranchapiCall data) =>
    json.encode(data.toJson());

class getclientbranchapiCall {
  String client_id;

  getclientbranchapiCall({
    required this.client_id,
  });

  factory getclientbranchapiCall.fromJson(Map<String, dynamic> json) =>
      getclientbranchapiCall(
        client_id: json["client_id"],
      );

  Map<String, dynamic> toJson() => {
        "client_id": client_id,
      };
}
