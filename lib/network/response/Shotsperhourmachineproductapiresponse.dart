// To parse this JSON data, do
//
//     final shotsperhourmachineproductapiresponse = shotsperhourmachineproductapiresponseFromJson(jsonString);

import 'dart:convert';

List<Shotsperhourmachineproductapiresponse>
    shotsperhourmachineproductapiresponseFromJson(String str) =>
        List<Shotsperhourmachineproductapiresponse>.from(json
            .decode(str)
            .map((x) => Shotsperhourmachineproductapiresponse.fromJson(x)));

String shotsperhourmachineproductapiresponseToJson(
        List<Shotsperhourmachineproductapiresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Shotsperhourmachineproductapiresponse {
  String status;
  String message;
  List<ShotsperhourmachineproductapiresponseDatum> data;

  Shotsperhourmachineproductapiresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Shotsperhourmachineproductapiresponse.fromJson(
          Map<String, dynamic> json) =>
      Shotsperhourmachineproductapiresponse(
        status: json["status"],
        message: json["message"],
        data: List<ShotsperhourmachineproductapiresponseDatum>.from(json["data"]
            .map(
                (x) => ShotsperhourmachineproductapiresponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ShotsperhourmachineproductapiresponseDatum {
  String id;
  String productName;
  String productMachineName;
  String shotsPerHour;

  ShotsperhourmachineproductapiresponseDatum({
    required this.id,
    required this.productName,
    required this.productMachineName,
    required this.shotsPerHour,
  });

  factory ShotsperhourmachineproductapiresponseDatum.fromJson(
          Map<String, dynamic> json) =>
      ShotsperhourmachineproductapiresponseDatum(
        id: json["id"] ?? "",
        productName: json["product_name"] ?? "",
        productMachineName: json["product_machine_name"] ?? "",
        shotsPerHour: json["shots_per_hour"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "product_machine_name": productMachineName,
        "shots_per_hour": shotsPerHour,
      };
}
