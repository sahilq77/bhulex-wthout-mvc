// To parse this JSON data, do
//
//     final getMachineProductApiResponse = getMachineProductApiResponseFromJson(jsonString);

import 'dart:convert';

List<GetMachineProductApiResponse> getMachineProductApiResponseFromJson(
        String str) =>
    List<GetMachineProductApiResponse>.from(
        json.decode(str).map((x) => GetMachineProductApiResponse.fromJson(x)));

String getMachineProductApiResponseToJson(
        List<GetMachineProductApiResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetMachineProductApiResponse {
  String status;
  String message;
  List<GetMachineProductApiResponseDatum> data;

  GetMachineProductApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetMachineProductApiResponse.fromJson(Map<String, dynamic> json) =>
      GetMachineProductApiResponse(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
        data: List<GetMachineProductApiResponseDatum>.from(json["data"]
            .map((x) => GetMachineProductApiResponseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetMachineProductApiResponseDatum {
  String id;
  String clientId;
  String branchName;
  String itemGroup;
  String itemType;
  String productName;
  dynamic labourCharges;
  DateTime bomDate;
  String shotsPerHour;
  String numberOfCavities;
  String mouldingCycle;
  String pcsPerHr;
  String pcsPerDay;
  String netWtPerPc;
  String runner;
  String shotWt;
  String lossPercentage;
  String lossPerPiece;
  String grossWt;
  String grossCalWt;
  String materialPerDay;
  String productMachineName;
  String machineShiftRatePerDay;
  String ratePer;
  String ratePerPc;
  String ratePerKg;
  String roundUp;
  String notes;
  dynamic productGst;
  String productHsnCode;
  String natureOfProcessing;
  String effectMachineTarrifPerDay;
  dynamic tblItemIdNew;
  String isDeleted;
  String status;
  DateTime createdOn;
  DateTime updatedOn;

  GetMachineProductApiResponseDatum({
    required this.id,
    required this.clientId,
    required this.branchName,
    required this.itemGroup,
    required this.itemType,
    required this.productName,
    required this.labourCharges,
    required this.bomDate,
    required this.shotsPerHour,
    required this.numberOfCavities,
    required this.mouldingCycle,
    required this.pcsPerHr,
    required this.pcsPerDay,
    required this.netWtPerPc,
    required this.runner,
    required this.shotWt,
    required this.lossPercentage,
    required this.lossPerPiece,
    required this.grossWt,
    required this.grossCalWt,
    required this.materialPerDay,
    required this.productMachineName,
    required this.machineShiftRatePerDay,
    required this.ratePer,
    required this.ratePerPc,
    required this.ratePerKg,
    required this.roundUp,
    required this.notes,
    required this.productGst,
    required this.productHsnCode,
    required this.natureOfProcessing,
    required this.effectMachineTarrifPerDay,
    required this.tblItemIdNew,
    required this.isDeleted,
    required this.status,
    required this.createdOn,
    required this.updatedOn,
  });

  factory GetMachineProductApiResponseDatum.fromJson(
          Map<String, dynamic> json) =>
      GetMachineProductApiResponseDatum(
        id: json["id"] ?? "",
        clientId: json["client_id"] ?? "",
        branchName: json["branch_name"] ?? "",
        itemGroup: json["item_group"] ?? "",
        itemType: json["item_type"] ?? "",
        productName: json["product_name"] ?? "",
        labourCharges: json["labour_charges"] ?? "",
        bomDate: DateTime.parse(json["bom_date"]),
        shotsPerHour: json["shots_per_hour"] ?? "",
        numberOfCavities: json["number_of_cavities"] ?? "",
        mouldingCycle: json["moulding_cycle"] ?? "",
        pcsPerHr: json["pcs_per_hr"] ?? "",
        pcsPerDay: json["pcs_per_day"] ?? "",
        netWtPerPc: json["net_wt_per_pc"] ?? "",
        runner: json["runner"] ?? "",
        shotWt: json["shot_wt"] ?? "",
        lossPercentage: json["loss_percentage"] ?? "",
        lossPerPiece: json["loss_per_piece"] ?? "",
        grossWt: json["gross_wt"] ?? "",
        grossCalWt: json["gross_cal_wt"] ?? "",
        materialPerDay: json["material_per_day"] ?? "",
        productMachineName: json["product_machine_name"] ?? "",
        machineShiftRatePerDay: json["machine_shift_rate_per_day"] ?? "",
        ratePer: json["rate_per"] ?? "",
        ratePerPc: json["rate_per_pc"] ?? "",
        ratePerKg: json["rate_per_kg"] ?? "",
        roundUp: json["round_up"] ?? "",
        notes: json["notes"] ?? "",
        productGst: json["product_gst"] ?? "",
        productHsnCode: json["product_hsn_code"] ?? "",
        natureOfProcessing: json["nature_of_processing"] ?? "",
        effectMachineTarrifPerDay: json["effect_machine_tarrif_per_day"] ?? "",
        tblItemIdNew: json["tbl_item_id_new"] ?? "",
        isDeleted: json["is_deleted"] ?? "",
        status: json["status"] ?? "",
        createdOn: DateTime.parse(json["created_on"]),
        updatedOn: DateTime.parse(json["updated_on"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "branch_name": branchName,
        "item_group": itemGroup,
        "item_type": itemType,
        "product_name": productName,
        "labour_charges": labourCharges,
        "bom_date":
            "${bomDate.year.toString().padLeft(4, '0')}-${bomDate.month.toString().padLeft(2, '0')}-${bomDate.day.toString().padLeft(2, '0')}",
        "shots_per_hour": shotsPerHour,
        "number_of_cavities": numberOfCavities,
        "moulding_cycle": mouldingCycle,
        "pcs_per_hr": pcsPerHr,
        "pcs_per_day": pcsPerDay,
        "net_wt_per_pc": netWtPerPc,
        "runner": runner,
        "shot_wt": shotWt,
        "loss_percentage": lossPercentage,
        "loss_per_piece": lossPerPiece,
        "gross_wt": grossWt,
        "gross_cal_wt": grossCalWt,
        "material_per_day": materialPerDay,
        "product_machine_name": productMachineName,
        "machine_shift_rate_per_day": machineShiftRatePerDay,
        "rate_per": ratePer,
        "rate_per_pc": ratePerPc,
        "rate_per_kg": ratePerKg,
        "round_up": roundUp,
        "notes": notes,
        "product_gst": productGst,
        "product_hsn_code": productHsnCode,
        "nature_of_processing": natureOfProcessing,
        "effect_machine_tarrif_per_day": effectMachineTarrifPerDay,
        "tbl_item_id_new": tblItemIdNew,
        "is_deleted": isDeleted,
        "status": status,
        "created_on": createdOn.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
      };
}
