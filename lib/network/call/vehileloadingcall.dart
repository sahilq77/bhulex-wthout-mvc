class VehicleLoading {
  String id;
  List<RowData> data;

  VehicleLoading({
    required this.id,
    required this.data,
  });

  factory VehicleLoading.fromJson(Map<String, dynamic> json) => VehicleLoading(
        id: json["id"],
        data: List<RowData>.from(
          json["data"].map((x) => RowData.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
class RowData {
  String product;
  String boxPacking;
  String row;
  String column;

  RowData({
    required this.product,
    required this.boxPacking,
    required this.row,
    required this.column,
  });

  factory RowData.fromJson(Map<String, dynamic> json) => RowData(
        product: json["product"],
        boxPacking: json["boxPacking"],
        row: json["row"],
        column: json["column"],
      );

  Map<String, dynamic> toJson() => {
        "product": product,
        "boxPacking": boxPacking,
        "row": row,
        "column": column,
      };
}
