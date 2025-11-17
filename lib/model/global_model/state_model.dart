class StateModel {
  final String id;
  final String stateName;

  StateModel({required this.id, required this.stateName});

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      id: json['id']?.toString() ?? '',
      stateName: json['state_name']?.toString() ?? '',
    );
  }
}