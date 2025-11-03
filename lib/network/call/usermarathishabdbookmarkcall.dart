import 'dart:convert';

// To parse this JSON data, do
//
//     final usermarathishabdbookmarkcall = usermarathishabdbookmarkcallFromJson(jsonString);

Usermarathishabdbookmarkcall usermarathishabdbookmarkcallFromJson(String str) =>
    Usermarathishabdbookmarkcall.fromJson(json.decode(str));

String usermarathishabdbookmarkcallToJson(Usermarathishabdbookmarkcall data) =>
    json.encode(data.toJson());

class Usermarathishabdbookmarkcall {
  String loginId;
  String marathiSabdId;

  Usermarathishabdbookmarkcall({
    required this.loginId,
    required this.marathiSabdId,
  });

  factory Usermarathishabdbookmarkcall.fromJson(Map<String, dynamic> json) =>
      Usermarathishabdbookmarkcall(
        loginId: json["login_id"],
        marathiSabdId: json["marathi_sabd_id"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "marathi_sabd_id": marathiSabdId,
      };
}
