// To parse this JSON data, do
//
//     final buycoursecall = buycoursecallFromJson(jsonString);

import 'dart:convert';

Buycoursecall buycoursecallFromJson(String str) =>
    Buycoursecall.fromJson(json.decode(str));

String buycoursecallToJson(Buycoursecall data) => json.encode(data.toJson());

class Buycoursecall {
  String loginId;
  String courseId;
  String transactionId;
  String paymentStatus;
  String isCouponApplied;
  String appliedCouponId;
  String paymentAmount;

  Buycoursecall({
    required this.loginId,
    required this.courseId,
    required this.transactionId,
    required this.paymentStatus,
    required this.isCouponApplied,
    required this.appliedCouponId,
    required this.paymentAmount,
  });

  factory Buycoursecall.fromJson(Map<String, dynamic> json) => Buycoursecall(
        loginId: json["login_id"],
        courseId: json["course_id"],
        transactionId: json["transaction_id"],
        paymentStatus: json["payment_status"],
        isCouponApplied: json["is_coupon_applied"],
        appliedCouponId: json["applied_coupon_id"],
        paymentAmount: json["payment_amount"],
      );

  Map<String, dynamic> toJson() => {
        "login_id": loginId,
        "course_id": courseId,
        "transaction_id": transactionId,
        "payment_status": paymentStatus,
        "is_coupon_applied": isCouponApplied,
        "applied_coupon_id": appliedCouponId,
        "payment_amount": paymentAmount,
      };
}
