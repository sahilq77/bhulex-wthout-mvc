class ShotsPerHourRequest {
  String date;
  String machineId;
  List<ShotsPerHourData> shotsPerHourData;

  ShotsPerHourRequest({
    required this.date,
    required this.machineId,
    required this.shotsPerHourData,
  });

  factory ShotsPerHourRequest.fromJson(Map<String, dynamic> json) =>
      ShotsPerHourRequest(
        date: json["date"],
        machineId: json["machine_id"],
        shotsPerHourData: List<ShotsPerHourData>.from(
          json["shots_per_hour_data"].map((x) => ShotsPerHourData.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "machine_id": machineId,
        "shots_per_hour_data":
            List<dynamic>.from(shotsPerHourData.map((x) => x.toJson())),
      };
}

class ShotsPerHourData {
  String time;
  String productId;
  double stdShotPerHour;
  int shotsPerHour;
  String remark;

  ShotsPerHourData({
    required this.time,
    required this.productId,
    required this.stdShotPerHour,
    required this.shotsPerHour,
    required this.remark,
  });

  factory ShotsPerHourData.fromJson(Map<String, dynamic> json) =>
      ShotsPerHourData(
        time: json["time"],
        productId: json["product_id"],
        stdShotPerHour: json["std_shot_per_hour"].toDouble(),
        shotsPerHour: json["shots_per_hour"],
        remark: json["remark"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "product_id": productId,
        "std_shot_per_hour": stdShotPerHour,
        "shots_per_hour": shotsPerHour,
        "remark": remark,
      };
}
