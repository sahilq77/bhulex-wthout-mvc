// To parse this JSON data, do
//
//     final getrawmaterialtotaloutwardproductionapiresponse = getrawmaterialtotaloutwardproductionapiresponseFromJson(jsonString);

import 'dart:convert';

List<Getrawmaterialtotaloutwardproductionapiresponse>
    getrawmaterialtotaloutwardproductionapiresponseFromJson(String str) =>
        List<Getrawmaterialtotaloutwardproductionapiresponse>.from(json
            .decode(str)
            .map((x) =>
                Getrawmaterialtotaloutwardproductionapiresponse.fromJson(x)));

String getrawmaterialtotaloutwardproductionapiresponseToJson(
        List<Getrawmaterialtotaloutwardproductionapiresponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Getrawmaterialtotaloutwardproductionapiresponse {
  String status;
  String message;
  List<GetrawmaterialtotaloutwardproductionapiresponseDatum> data;

  Getrawmaterialtotaloutwardproductionapiresponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Getrawmaterialtotaloutwardproductionapiresponse.fromJson(
          Map<String, dynamic> json) =>
      Getrawmaterialtotaloutwardproductionapiresponse(
        status: json["status"],
        message: json["message"],
        data: List<GetrawmaterialtotaloutwardproductionapiresponseDatum>.from(
            json["data"].map((x) =>
                GetrawmaterialtotaloutwardproductionapiresponseDatum.fromJson(
                    x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetrawmaterialtotaloutwardproductionapiresponseDatum {
  String hiddenItemName;
  String itemName;
  String combinedTotal;
  DateTime challanDate;
  String clientName;
  String branchName;

  GetrawmaterialtotaloutwardproductionapiresponseDatum({
    required this.hiddenItemName,
    required this.itemName,
    required this.combinedTotal,
    required this.challanDate,
    required this.clientName,
    required this.branchName,
  });

  factory GetrawmaterialtotaloutwardproductionapiresponseDatum.fromJson(
          Map<String, dynamic> json) =>
      GetrawmaterialtotaloutwardproductionapiresponseDatum(
        hiddenItemName: json["hidden_item_name"] ?? "",
        itemName: json["item_name"] ?? "",
        combinedTotal: json["combined_total"] ?? "",
        challanDate: DateTime.parse(json["challan_date"]),
        clientName: json["client_name"] ?? "",
        branchName: json["branch_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "hidden_item_name": hiddenItemName,
        "item_name": itemName,
        "combined_total": combinedTotal,
        "challan_date":
            "${challanDate.year.toString().padLeft(4, '0')}-${challanDate.month.toString().padLeft(2, '0')}-${challanDate.day.toString().padLeft(2, '0')}",
        "client_name": clientName,
        "branch_name": branchName,
      };
}
