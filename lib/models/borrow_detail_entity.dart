import 'dart:convert';

import 'package:myapp9/generated/json/base/json_field.dart';
import 'package:myapp9/generated/json/borrow_detail_entity.g.dart';

@JsonSerializable()
class BorrowDetailEntity {
  bool? success;
  BorrowDetailData? data;
  List<dynamic>? other;
  String? message;

  BorrowDetailEntity();

  factory BorrowDetailEntity.fromJson(Map<String, dynamic> json) => $BorrowDetailEntityFromJson(json);

  Map<String, dynamic> toJson() => $BorrowDetailEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BorrowDetailData {
  BorrowDetailDataBorrow? borrow;
  List<BorrowDetailDataPeriods>? periods;
  BorrowDetailDataProduct? product;
  BorrowDetailDataLoan? loan;
  List<String>? tips;

  BorrowDetailData();

  factory BorrowDetailData.fromJson(Map<String, dynamic> json) => $BorrowDetailDataFromJson(json);

  Map<String, dynamic> toJson() => $BorrowDetailDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BorrowDetailDataBorrow {
  @JSONField(name: "h_sn")
  String? hSn;
  @JSONField(name: "j_status")
  int? jStatus;
  @JSONField(name: "k_sub_status")
  int? kSubStatus;
  @JSONField(name: "q_expect_repay_time")
  String? qExpectRepayTime;
  @JSONField(name: "m_borrow_amount")
  int? mBorrowAmount;
  @JSONField(name: "u_settled_period")
  int? uSettledPeriod;
  @JSONField(name: "t_settled_time")
  String? tSettledTime;
  @JSONField(name: "y_show_extend_btn")
  int? yShowExtendBtn;
  @JSONField(name: "a_t_max_extend_days")
  int? aTMaxExtendDays;
  @JSONField(name: "a_p_period_count")
  int? aPPeriodCount;


  BorrowDetailDataBorrow();

  factory BorrowDetailDataBorrow.fromJson(Map<String, dynamic> json) => $BorrowDetailDataBorrowFromJson(json);

  Map<String, dynamic> toJson() => $BorrowDetailDataBorrowToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BorrowDetailDataPeriods {
  @JSONField(name: "id")
  int? id;
  @JSONField(name: "d_index")
  int? dIndex;
  @JSONField(name: "e_status")
  int? eStatus;
  @JSONField(name: "a_p_expect_repay_time")
  String? aPExpectRepayTime;
  @JSONField(name: "f_expect_repay_total_amount")
  int? fExpectRepayTotalAmount;
  @JSONField(name: "l_overdue_days")
  int? lOverdueDays;
  @JSONField(name: "g_expect_borrow_amount")
  int? gExpectBorrowAmount;
  @JSONField(name: "h_expect_interest")
  int? hExpectInterest;
  @JSONField(name: "i_expect_service_fee")
  int? iExpectServiceFee;
  @JSONField(name: "j_expect_violate_fee")
  int? jExpectViolateFee;
  @JSONField(name: "k_expect_overdue_amount")
  int? kExpectOverdueAmount;
  @JSONField(name: "n_paid_amount")
  int? nPaidAmount;
  @JSONField(name: "o_paid_borrow_amount")
  int? oPaidBorrowAmount;
  @JSONField(name: "p_paid_interest")
  int? pPaidInterest;
  @JSONField(name: "q_paid_service_fee")
  int? qPaidServiceFee;
  @JSONField(name: "r_paid_violate_fee")
  int? rPaidViolateFee;
  @JSONField(name: "s_paid_overdue_amount")
  int? sPaidOverdueAmount;
  @JSONField(name: "a_u_current_deduction_fee")
  int? aUCurrentDeductionFee;
  @JSONField(name: "a_v_borrow_amount")
  int? aVBorrowAmount;
  @JSONField(name: "a_w_interest")
  int? aWInterest;
  @JSONField(name: "a_x_service_fee")
  int? aXServiceFee;
  @JSONField(name: "a_y_settled_time")
  String? aYSettledTime;

  BorrowDetailDataPeriods();

  factory BorrowDetailDataPeriods.fromJson(Map<String, dynamic> json) => $BorrowDetailDataPeriodsFromJson(json);

  Map<String, dynamic> toJson() => $BorrowDetailDataPeriodsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BorrowDetailDataProduct {

  @JSONField(name: "e_life")
  int? eLife;
  @JSONField(name: "f_settlement_type")
  int? fSettlementType;
  @JSONField(name: "g_interest")
  int? gInterest;
  @JSONField(name: "i_overdue_rate")
  int? iOverdueRate;
  @JSONField(name: "j_violate_fee_rate")
  int? jViolateFeeRate;
  @JSONField(name: "k_extend_rate")
  int? kExtendRate;
  @JSONField(name: "l_min_pay")
  int? lMinPay;
  @JSONField(name: "m_can_part_pay")
  String? mCanPartPay;
  @JSONField(name: "n_can_extend")
  String? nCanExtend;
  @JSONField(name: "d_unit")
  String? dUnit;
  @JSONField(name: "z_period")
  int? zPeriod;

  BorrowDetailDataProduct();

  factory BorrowDetailDataProduct.fromJson(Map<String, dynamic> json) => $BorrowDetailDataProductFromJson(json);

  Map<String, dynamic> toJson() => $BorrowDetailDataProductToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BorrowDetailDataLoan {
  @JSONField(name: "e_amount")
  int? eAmount;
  @JSONField(name: "g_receiver_name")
  String? gReceiverName;
  @JSONField(name: "h_receiver_bankcard_number")
  String? hReceiverBankcardNumber;
  @JSONField(name: "i_receiver_bankcard_name")
  dynamic iReceiverBankcardName;
  @JSONField(name: "o_success_at")
  dynamic oSuccessAt;

  BorrowDetailDataLoan();

  factory BorrowDetailDataLoan.fromJson(Map<String, dynamic> json) => $BorrowDetailDataLoanFromJson(json);

  Map<String, dynamic> toJson() => $BorrowDetailDataLoanToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}