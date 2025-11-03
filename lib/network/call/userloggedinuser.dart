import 'dart:convert';

UserLoginCall userLoginCallFromJson(String str) =>
    UserLoginCall.fromJson(json.decode(str));

String userLoginCallToJson(UserLoginCall data) => json.encode(data.toJson());

class UserLoginCall {
  String project;
  String username;
  String deviceId;
  String userId;
  String name;
  String mobileNo;
  String email;
  String password;
  DeviceDetails deviceDetails;
  List<PermissionDetails> permissionDetails;

  UserLoginCall({
    required this.project,
    required this.username,
    required this.deviceId,
    required this.userId,
    required this.name,
    required this.mobileNo,
    required this.email,
    required this.password,
    required this.deviceDetails,
    required this.permissionDetails,
  });

  factory UserLoginCall.fromJson(Map<String, dynamic> json) => UserLoginCall(
        project: json["project"],
        username: json["username"],
        deviceId: json["device_id"],
        userId: json["user_id"],
        name: json["name"],
        mobileNo: json["mobile_no"],
        email: json["email"],
        password: json["password"],
        deviceDetails: DeviceDetails.fromJson(json["device_details"]),
        permissionDetails: List<PermissionDetails>.from(
            json["permission_details"]
                .map((x) => PermissionDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "project": project,
        "username": username,
        "device_id": deviceId,
        "user_id": userId,
        "name": name,
        "mobile_no": mobileNo,
        "email": email,
        "password": password,
        "device_details": deviceDetails.toJson(),
        "permission_details":
            List<dynamic>.from(permissionDetails.map((x) => x.toJson())),
      };
}

class DeviceDetails {
  String deviceId;
  String appVersion;
  String androidVersion;

  DeviceDetails({
    required this.deviceId,
    required this.appVersion,
    required this.androidVersion,
  });

  factory DeviceDetails.fromJson(Map<String, dynamic> json) => DeviceDetails(
        deviceId: json["device_id"],
        appVersion: json["app_version"],
        androidVersion: json["android"],
      );

  Map<String, dynamic> toJson() => {
        "device_id": deviceId,
        "app_version": appVersion,
        "android": androidVersion,
      };
}

class PermissionDetails {
  String permission;
  String isRequired;
  String status;

  PermissionDetails({
    required this.permission,
    required this.isRequired,
    required this.status,
  });

  factory PermissionDetails.fromJson(Map<String, dynamic> json) =>
      PermissionDetails(
        permission: json["permission"],
        isRequired: json["is_required"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "permission": permission,
        "is_required": isRequired,
        "status": status,
      };
}
