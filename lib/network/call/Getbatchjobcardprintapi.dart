import 'dart:convert';

Getbatchjobcardprintapi getbatchjobcardprintapiFromJson(String str) =>
    Getbatchjobcardprintapi.fromJson(json.decode(str));

String getbatchjobcardprintapiToJson(Getbatchjobcardprintapi data) =>
    json.encode(data.toJson());

class Getbatchjobcardprintapi {
  List<String> selectedIds;

  Getbatchjobcardprintapi({
    required this.selectedIds,
  });

  factory Getbatchjobcardprintapi.fromJson(Map<String, dynamic> json) =>
      Getbatchjobcardprintapi(
        selectedIds:
            List<String>.from(json["selected_ids"].map((x) => x.toString())),
      );

  Map<String, dynamic> toJson() => {
        "selected_ids": List<dynamic>.from(selectedIds.map((x) => x)),
      };
}
