import 'dart:convert';

import 'package:myapp9/generated/json/base/json_field.dart';
import 'package:myapp9/generated/json/borrow_list_entity.g.dart';

@JsonSerializable()
class BorrowListEntity {
  bool? success;
  String? errorMessage;
  List<BorrowListData>? data;
  BorrowListOther? other;
  int? total;
  int? currentPage;
  int? perPage;
  bool? hasMorePages;

  BorrowListEntity();

  factory BorrowListEntity.fromJson(Map<String, dynamic> json) => $BorrowListEntityFromJson(json);

  Map<String, dynamic> toJson() => $BorrowListEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BorrowListData {
  int? id;
  @JSONField(name: "h_sn")
  String? hSn;
  @JSONField(name: "j_status")
  int? jStatus;
  @JSONField(name: "d_product_id")
  int? dProductId;
  @JSONField(name: "k_sub_status")
  int? kSubStatus;
  @JSONField(name: "m_borrow_amount")
  int? mBorrowAmount;
  @JSONField(name: "q_expect_repay_time")
  String? qExpectRepayTime;
  @JSONField(name: "t_settled_time")
  String? tSettledTime;
  @JSONField(name: "y_show_extend_btn")
  int? yShowExtendBtn;
  @JSONField(name: "a_t_max_extend_days")
  int? aTMaxExtendDays;
  @JSONField(name: "a_p_period_count")
  int? aPPeriodCount;
  @JSONField(name: "o_loan_time")
  String? oLoanTime;
  @JSONField(name: "p_loan_amount")
  int? pLoanAmount;
  @JSONField(name: "a_m_bankcard")
  String? aMBankcard;
  @JSONField(name: "created_at")
  String? createdAt;

  BorrowListData();

  factory BorrowListData.fromJson(Map<String, dynamic> json) => $BorrowListDataFromJson(json);

  Map<String, dynamic> toJson() => $BorrowListDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BorrowListOther {
  int? all;
  int? review;
  int? rejected;
  int? disbursing;
  int? outstanding;
  int? overdue;
  int? closed;
  int? cleared;

  BorrowListOther();

  factory BorrowListOther.fromJson(Map<String, dynamic> json) => $BorrowListOtherFromJson(json);

  Map<String, dynamic> toJson() => $BorrowListOtherToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
