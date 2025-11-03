// To parse this JSON data, do
//
//     final tempmaterialproductvehicleloadingapiresponse = tempmaterialproductvehicleloadingapiresponseFromJson(jsonString);

import 'dart:convert';

List<Tempmaterialproductvehicleloadingapiresponse>
    tempmaterialproductvehicleloadingapiresponseFromJson(String str) =>
        List<Tempmaterialproductvehicleloadingapiresponse>.from(json
            .decode(str)
            .map((x) =>
                Tempmaterialproductvehicleloadingapiresponse.fromJson(x)));

String tempmaterialproductvehicleloadingapiresponseToJson(
        List<Tempmaterialproductvehicleloadingapiresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tempmaterialproductvehicleloadingapiresponse {
  String status;
  String message;
  List<TempmaterialproductvehicleloadingapiresponseDatum> data;

  Tempmaterialproductvehicleloadingapiresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Tempmaterialproductvehicleloadingapiresponse.fromJson(
          Map<String, dynamic> json) =>
      Tempmaterialproductvehicleloadingapiresponse(
        status: json["status"],
        message: json["message"],
        data: List<TempmaterialproductvehicleloadingapiresponseDatum>.from(
            json["data"].map((x) =>
                TempmaterialproductvehicleloadingapiresponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TempmaterialproductvehicleloadingapiresponseDatum {
  String tblMaterialDispatchLastId;
  String productName;
  String productId;
  String avgQty;
  String package;
  String quantity;
  String packagingName;
  String uniqueId;
  TempmaterialproductvehicleloadingapiresponseDatum({
    required this.tblMaterialDispatchLastId,
    required this.productName,
    required this.productId,
    required this.avgQty,
    required this.package,
    required this.quantity,
    required this.packagingName,
    required this.uniqueId,
  });

  factory TempmaterialproductvehicleloadingapiresponseDatum.fromJson(
          Map<String, dynamic> json) =>
      TempmaterialproductvehicleloadingapiresponseDatum(
        tblMaterialDispatchLastId: json["tbl_material_dispatch_last_id"] ?? "",
        productName: json["product_name"] ?? "",
        productId: json["product_id"] ?? "",
        avgQty: json["avg_qty"] ?? "",
        package: json["package"] ?? "",
        quantity: json["quantity"] ?? "",
        packagingName: json["packaging_name"] ?? "",
        uniqueId: json["id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "tbl_material_dispatch_last_id": tblMaterialDispatchLastId,
        "product_name": productName,
        "product_id": productId,
        "avg_qty": avgQty,
        "package": package,
        "quantity": quantity,
        "packaging_name": packagingName,
        "id": uniqueId,
      };
}
