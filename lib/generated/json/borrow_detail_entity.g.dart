import 'package:myapp9/generated/json/base/json_convert_content.dart';
import 'package:myapp9/models/borrow_detail_entity.dart';

BorrowDetailEntity $BorrowDetailEntityFromJson(Map<String, dynamic> json) {
  final BorrowDetailEntity borrowDetailEntity = BorrowDetailEntity();
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    borrowDetailEntity.success = success;
  }
  final BorrowDetailData? data = jsonConvert.convert<BorrowDetailData>(
      json['data']);
  if (data != null) {
    borrowDetailEntity.data = data;
  }
  final List<dynamic>? other = (json['other'] as List<dynamic>?)?.map(
          (e) => e).toList();
  if (other != null) {
    borrowDetailEntity.other = other;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    borrowDetailEntity.message = message;
  }
  return borrowDetailEntity;
}

Map<String, dynamic> $BorrowDetailEntityToJson(BorrowDetailEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['success'] = entity.success;
  data['data'] = entity.data?.toJson();
  data['other'] = entity.other;
  data['message'] = entity.message;
  return data;
}

extension BorrowDetailEntityExtension on BorrowDetailEntity {
  BorrowDetailEntity copyWith({
    bool? success,
    BorrowDetailData? data,
    List<dynamic>? other,
    String? message,
  }) {
    return BorrowDetailEntity()
      ..success = success ?? this.success
      ..data = data ?? this.data
      ..other = other ?? this.other
      ..message = message ?? this.message;
  }
}

BorrowDetailData $BorrowDetailDataFromJson(Map<String, dynamic> json) {
  final BorrowDetailData borrowDetailData = BorrowDetailData();
  final BorrowDetailDataBorrow? borrow = jsonConvert.convert<
      BorrowDetailDataBorrow>(json['borrow']);
  if (borrow != null) {
    borrowDetailData.borrow = borrow;
  }
  final List<BorrowDetailDataPeriods>? periods = (json['periods'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<BorrowDetailDataPeriods>(
          e) as BorrowDetailDataPeriods).toList();
  if (periods != null) {
    borrowDetailData.periods = periods;
  }
  final BorrowDetailDataProduct? product = jsonConvert.convert<
      BorrowDetailDataProduct>(json['product']);
  if (product != null) {
    borrowDetailData.product = product;
  }
  final BorrowDetailDataLoan? loan = jsonConvert.convert<BorrowDetailDataLoan>(
      json['loan']);
  if (loan != null) {
    borrowDetailData.loan = loan;
  }
  final List<String>? tips = (json['tips'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (tips != null) {
    borrowDetailData.tips = tips;
  }
  return borrowDetailData;
}

Map<String, dynamic> $BorrowDetailDataToJson(BorrowDetailData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['borrow'] = entity.borrow?.toJson();
  data['periods'] = entity.periods?.map((v) => v.toJson()).toList();
  data['product'] = entity.product?.toJson();
  data['loan'] = entity.loan?.toJson();
  data['tips'] = entity.tips;
  return data;
}

extension BorrowDetailDataExtension on BorrowDetailData {
  BorrowDetailData copyWith({
    BorrowDetailDataBorrow? borrow,
    List<BorrowDetailDataPeriods>? periods,
    BorrowDetailDataProduct? product,
    BorrowDetailDataLoan? loan,
    List<String>? tips,
  }) {
    return BorrowDetailData()
      ..borrow = borrow ?? this.borrow
      ..periods = periods ?? this.periods
      ..product = product ?? this.product
      ..loan = loan ?? this.loan
      ..tips = tips ?? this.tips;
  }
}

BorrowDetailDataBorrow $BorrowDetailDataBorrowFromJson(
    Map<String, dynamic> json) {
  final BorrowDetailDataBorrow borrowDetailDataBorrow = BorrowDetailDataBorrow();
  final String? hSn = jsonConvert.convert<String>(json['h_sn']);
  if (hSn != null) {
    borrowDetailDataBorrow.hSn = hSn;
  }
  final int? jStatus = jsonConvert.convert<int>(json['j_status']);
  if (jStatus != null) {
    borrowDetailDataBorrow.jStatus = jStatus;
  }
  final int? kSubStatus = jsonConvert.convert<int>(json['k_sub_status']);
  if (kSubStatus != null) {
    borrowDetailDataBorrow.kSubStatus = kSubStatus;
  }
  final String? qExpectRepayTime = jsonConvert.convert<String>(
      json['q_expect_repay_time']);
  if (qExpectRepayTime != null) {
    borrowDetailDataBorrow.qExpectRepayTime = qExpectRepayTime;
  }
  final int? mBorrowAmount = jsonConvert.convert<int>(json['m_borrow_amount']);
  if (mBorrowAmount != null) {
    borrowDetailDataBorrow.mBorrowAmount = mBorrowAmount;
  }
  final int? uSettledPeriod = jsonConvert.convert<int>(
      json['u_settled_period']);
  if (uSettledPeriod != null) {
    borrowDetailDataBorrow.uSettledPeriod = uSettledPeriod;
  }
  final String? tSettledTime = jsonConvert.convert<String>(
      json['t_settled_time']);
  if (tSettledTime != null) {
    borrowDetailDataBorrow.tSettledTime = tSettledTime;
  }
  final int? yShowExtendBtn = jsonConvert.convert<int>(
      json['y_show_extend_btn']);
  if (yShowExtendBtn != null) {
    borrowDetailDataBorrow.yShowExtendBtn = yShowExtendBtn;
  }
  final int? aTMaxExtendDays = jsonConvert.convert<int>(
      json['a_t_max_extend_days']);
  if (aTMaxExtendDays != null) {
    borrowDetailDataBorrow.aTMaxExtendDays = aTMaxExtendDays;
  }
  final int? aPPeriodCount = jsonConvert.convert<int>(json['a_p_period_count']);
  if (aPPeriodCount != null) {
    borrowDetailDataBorrow.aPPeriodCount = aPPeriodCount;
  }
  return borrowDetailDataBorrow;
}

Map<String, dynamic> $BorrowDetailDataBorrowToJson(
    BorrowDetailDataBorrow entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['h_sn'] = entity.hSn;
  data['j_status'] = entity.jStatus;
  data['k_sub_status'] = entity.kSubStatus;
  data['q_expect_repay_time'] = entity.qExpectRepayTime;
  data['m_borrow_amount'] = entity.mBorrowAmount;
  data['u_settled_period'] = entity.uSettledPeriod;
  data['t_settled_time'] = entity.tSettledTime;
  data['y_show_extend_btn'] = entity.yShowExtendBtn;
  data['a_t_max_extend_days'] = entity.aTMaxExtendDays;
  data['a_p_period_count'] = entity.aPPeriodCount;
  return data;
}

extension BorrowDetailDataBorrowExtension on BorrowDetailDataBorrow {
  BorrowDetailDataBorrow copyWith({
    String? hSn,
    int? jStatus,
    int? kSubStatus,
    String? qExpectRepayTime,
    int? mBorrowAmount,
    int? uSettledPeriod,
    String? tSettledTime,
    int? yShowExtendBtn,
    int? aTMaxExtendDays,
    int? aPPeriodCount,
  }) {
    return BorrowDetailDataBorrow()
      ..hSn = hSn ?? this.hSn
      ..jStatus = jStatus ?? this.jStatus
      ..kSubStatus = kSubStatus ?? this.kSubStatus
      ..qExpectRepayTime = qExpectRepayTime ?? this.qExpectRepayTime
      ..mBorrowAmount = mBorrowAmount ?? this.mBorrowAmount
      ..uSettledPeriod = uSettledPeriod ?? this.uSettledPeriod
      ..tSettledTime = tSettledTime ?? this.tSettledTime
      ..yShowExtendBtn = yShowExtendBtn ?? this.yShowExtendBtn
      ..aTMaxExtendDays = aTMaxExtendDays ?? this.aTMaxExtendDays
      ..aPPeriodCount = aPPeriodCount ?? this.aPPeriodCount;
  }
}

BorrowDetailDataPeriods $BorrowDetailDataPeriodsFromJson(
    Map<String, dynamic> json) {
  final BorrowDetailDataPeriods borrowDetailDataPeriods = BorrowDetailDataPeriods();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    borrowDetailDataPeriods.id = id;
  }
  final int? dIndex = jsonConvert.convert<int>(json['d_index']);
  if (dIndex != null) {
    borrowDetailDataPeriods.dIndex = dIndex;
  }
  final int? eStatus = jsonConvert.convert<int>(json['e_status']);
  if (eStatus != null) {
    borrowDetailDataPeriods.eStatus = eStatus;
  }
  final String? aPExpectRepayTime = jsonConvert.convert<String>(
      json['a_p_expect_repay_time']);
  if (aPExpectRepayTime != null) {
    borrowDetailDataPeriods.aPExpectRepayTime = aPExpectRepayTime;
  }
  final int? fExpectRepayTotalAmount = jsonConvert.convert<int>(
      json['f_expect_repay_total_amount']);
  if (fExpectRepayTotalAmount != null) {
    borrowDetailDataPeriods.fExpectRepayTotalAmount = fExpectRepayTotalAmount;
  }
  final int? lOverdueDays = jsonConvert.convert<int>(json['l_overdue_days']);
  if (lOverdueDays != null) {
    borrowDetailDataPeriods.lOverdueDays = lOverdueDays;
  }
  final int? gExpectBorrowAmount = jsonConvert.convert<int>(
      json['g_expect_borrow_amount']);
  if (gExpectBorrowAmount != null) {
    borrowDetailDataPeriods.gExpectBorrowAmount = gExpectBorrowAmount;
  }
  final int? hExpectInterest = jsonConvert.convert<int>(
      json['h_expect_interest']);
  if (hExpectInterest != null) {
    borrowDetailDataPeriods.hExpectInterest = hExpectInterest;
  }
  final int? iExpectServiceFee = jsonConvert.convert<int>(
      json['i_expect_service_fee']);
  if (iExpectServiceFee != null) {
    borrowDetailDataPeriods.iExpectServiceFee = iExpectServiceFee;
  }
  final int? jExpectViolateFee = jsonConvert.convert<int>(
      json['j_expect_violate_fee']);
  if (jExpectViolateFee != null) {
    borrowDetailDataPeriods.jExpectViolateFee = jExpectViolateFee;
  }
  final int? kExpectOverdueAmount = jsonConvert.convert<int>(
      json['k_expect_overdue_amount']);
  if (kExpectOverdueAmount != null) {
    borrowDetailDataPeriods.kExpectOverdueAmount = kExpectOverdueAmount;
  }
  final int? nPaidAmount = jsonConvert.convert<int>(json['n_paid_amount']);
  if (nPaidAmount != null) {
    borrowDetailDataPeriods.nPaidAmount = nPaidAmount;
  }
  final int? oPaidBorrowAmount = jsonConvert.convert<int>(
      json['o_paid_borrow_amount']);
  if (oPaidBorrowAmount != null) {
    borrowDetailDataPeriods.oPaidBorrowAmount = oPaidBorrowAmount;
  }
  final int? pPaidInterest = jsonConvert.convert<int>(json['p_paid_interest']);
  if (pPaidInterest != null) {
    borrowDetailDataPeriods.pPaidInterest = pPaidInterest;
  }
  final int? qPaidServiceFee = jsonConvert.convert<int>(
      json['q_paid_service_fee']);
  if (qPaidServiceFee != null) {
    borrowDetailDataPeriods.qPaidServiceFee = qPaidServiceFee;
  }
  final int? rPaidViolateFee = jsonConvert.convert<int>(
      json['r_paid_violate_fee']);
  if (rPaidViolateFee != null) {
    borrowDetailDataPeriods.rPaidViolateFee = rPaidViolateFee;
  }
  final int? sPaidOverdueAmount = jsonConvert.convert<int>(
      json['s_paid_overdue_amount']);
  if (sPaidOverdueAmount != null) {
    borrowDetailDataPeriods.sPaidOverdueAmount = sPaidOverdueAmount;
  }
  final int? aUCurrentDeductionFee = jsonConvert.convert<int>(
      json['a_u_current_deduction_fee']);
  if (aUCurrentDeductionFee != null) {
    borrowDetailDataPeriods.aUCurrentDeductionFee = aUCurrentDeductionFee;
  }
  final int? aVBorrowAmount = jsonConvert.convert<int>(
      json['a_v_borrow_amount']);
  if (aVBorrowAmount != null) {
    borrowDetailDataPeriods.aVBorrowAmount = aVBorrowAmount;
  }
  final int? aWInterest = jsonConvert.convert<int>(json['a_w_interest']);
  if (aWInterest != null) {
    borrowDetailDataPeriods.aWInterest = aWInterest;
  }
  final int? aXServiceFee = jsonConvert.convert<int>(json['a_x_service_fee']);
  if (aXServiceFee != null) {
    borrowDetailDataPeriods.aXServiceFee = aXServiceFee;
  }
  final String? aYSettledTime = jsonConvert.convert<String>(
      json['a_y_settled_time']);
  if (aYSettledTime != null) {
    borrowDetailDataPeriods.aYSettledTime = aYSettledTime;
  }
  return borrowDetailDataPeriods;
}

Map<String, dynamic> $BorrowDetailDataPeriodsToJson(
    BorrowDetailDataPeriods entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['d_index'] = entity.dIndex;
  data['e_status'] = entity.eStatus;
  data['a_p_expect_repay_time'] = entity.aPExpectRepayTime;
  data['f_expect_repay_total_amount'] = entity.fExpectRepayTotalAmount;
  data['l_overdue_days'] = entity.lOverdueDays;
  data['g_expect_borrow_amount'] = entity.gExpectBorrowAmount;
  data['h_expect_interest'] = entity.hExpectInterest;
  data['i_expect_service_fee'] = entity.iExpectServiceFee;
  data['j_expect_violate_fee'] = entity.jExpectViolateFee;
  data['k_expect_overdue_amount'] = entity.kExpectOverdueAmount;
  data['n_paid_amount'] = entity.nPaidAmount;
  data['o_paid_borrow_amount'] = entity.oPaidBorrowAmount;
  data['p_paid_interest'] = entity.pPaidInterest;
  data['q_paid_service_fee'] = entity.qPaidServiceFee;
  data['r_paid_violate_fee'] = entity.rPaidViolateFee;
  data['s_paid_overdue_amount'] = entity.sPaidOverdueAmount;
  data['a_u_current_deduction_fee'] = entity.aUCurrentDeductionFee;
  data['a_v_borrow_amount'] = entity.aVBorrowAmount;
  data['a_w_interest'] = entity.aWInterest;
  data['a_x_service_fee'] = entity.aXServiceFee;
  data['a_y_settled_time'] = entity.aYSettledTime;
  return data;
}

extension BorrowDetailDataPeriodsExtension on BorrowDetailDataPeriods {
  BorrowDetailDataPeriods copyWith({
    int? id,
    int? dIndex,
    int? eStatus,
    String? aPExpectRepayTime,
    int? fExpectRepayTotalAmount,
    int? lOverdueDays,
    int? gExpectBorrowAmount,
    int? hExpectInterest,
    int? iExpectServiceFee,
    int? jExpectViolateFee,
    int? kExpectOverdueAmount,
    int? nPaidAmount,
    int? oPaidBorrowAmount,
    int? pPaidInterest,
    int? qPaidServiceFee,
    int? rPaidViolateFee,
    int? sPaidOverdueAmount,
    int? aUCurrentDeductionFee,
    int? aVBorrowAmount,
    int? aWInterest,
    int? aXServiceFee,
    String? aYSettledTime,
  }) {
    return BorrowDetailDataPeriods()
      ..id = id ?? this.id
      ..dIndex = dIndex ?? this.dIndex
      ..eStatus = eStatus ?? this.eStatus
      ..aPExpectRepayTime = aPExpectRepayTime ?? this.aPExpectRepayTime
      ..fExpectRepayTotalAmount = fExpectRepayTotalAmount ??
          this.fExpectRepayTotalAmount
      ..lOverdueDays = lOverdueDays ?? this.lOverdueDays
      ..gExpectBorrowAmount = gExpectBorrowAmount ?? this.gExpectBorrowAmount
      ..hExpectInterest = hExpectInterest ?? this.hExpectInterest
      ..iExpectServiceFee = iExpectServiceFee ?? this.iExpectServiceFee
      ..jExpectViolateFee = jExpectViolateFee ?? this.jExpectViolateFee
      ..kExpectOverdueAmount = kExpectOverdueAmount ?? this.kExpectOverdueAmount
      ..nPaidAmount = nPaidAmount ?? this.nPaidAmount
      ..oPaidBorrowAmount = oPaidBorrowAmount ?? this.oPaidBorrowAmount
      ..pPaidInterest = pPaidInterest ?? this.pPaidInterest
      ..qPaidServiceFee = qPaidServiceFee ?? this.qPaidServiceFee
      ..rPaidViolateFee = rPaidViolateFee ?? this.rPaidViolateFee
      ..sPaidOverdueAmount = sPaidOverdueAmount ?? this.sPaidOverdueAmount
      ..aUCurrentDeductionFee = aUCurrentDeductionFee ??
          this.aUCurrentDeductionFee
      ..aVBorrowAmount = aVBorrowAmount ?? this.aVBorrowAmount
      ..aWInterest = aWInterest ?? this.aWInterest
      ..aXServiceFee = aXServiceFee ?? this.aXServiceFee
      ..aYSettledTime = aYSettledTime ?? this.aYSettledTime;
  }
}

BorrowDetailDataProduct $BorrowDetailDataProductFromJson(
    Map<String, dynamic> json) {
  final BorrowDetailDataProduct borrowDetailDataProduct = BorrowDetailDataProduct();
  final int? eLife = jsonConvert.convert<int>(json['e_life']);
  if (eLife != null) {
    borrowDetailDataProduct.eLife = eLife;
  }
  final int? fSettlementType = jsonConvert.convert<int>(
      json['f_settlement_type']);
  if (fSettlementType != null) {
    borrowDetailDataProduct.fSettlementType = fSettlementType;
  }
  final int? gInterest = jsonConvert.convert<int>(json['g_interest']);
  if (gInterest != null) {
    borrowDetailDataProduct.gInterest = gInterest;
  }
  final int? iOverdueRate = jsonConvert.convert<int>(json['i_overdue_rate']);
  if (iOverdueRate != null) {
    borrowDetailDataProduct.iOverdueRate = iOverdueRate;
  }
  final int? jViolateFeeRate = jsonConvert.convert<int>(
      json['j_violate_fee_rate']);
  if (jViolateFeeRate != null) {
    borrowDetailDataProduct.jViolateFeeRate = jViolateFeeRate;
  }
  final int? kExtendRate = jsonConvert.convert<int>(json['k_extend_rate']);
  if (kExtendRate != null) {
    borrowDetailDataProduct.kExtendRate = kExtendRate;
  }
  final int? lMinPay = jsonConvert.convert<int>(json['l_min_pay']);
  if (lMinPay != null) {
    borrowDetailDataProduct.lMinPay = lMinPay;
  }
  final String? mCanPartPay = jsonConvert.convert<String>(
      json['m_can_part_pay']);
  if (mCanPartPay != null) {
    borrowDetailDataProduct.mCanPartPay = mCanPartPay;
  }
  final String? nCanExtend = jsonConvert.convert<String>(json['n_can_extend']);
  if (nCanExtend != null) {
    borrowDetailDataProduct.nCanExtend = nCanExtend;
  }
  final String? dUnit = jsonConvert.convert<String>(json['d_unit']);
  if (dUnit != null) {
    borrowDetailDataProduct.dUnit = dUnit;
  }
  final int? zPeriod = jsonConvert.convert<int>(json['z_period']);
  if (zPeriod != null) {
    borrowDetailDataProduct.zPeriod = zPeriod;
  }
  return borrowDetailDataProduct;
}

Map<String, dynamic> $BorrowDetailDataProductToJson(
    BorrowDetailDataProduct entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['e_life'] = entity.eLife;
  data['f_settlement_type'] = entity.fSettlementType;
  data['g_interest'] = entity.gInterest;
  data['i_overdue_rate'] = entity.iOverdueRate;
  data['j_violate_fee_rate'] = entity.jViolateFeeRate;
  data['k_extend_rate'] = entity.kExtendRate;
  data['l_min_pay'] = entity.lMinPay;
  data['m_can_part_pay'] = entity.mCanPartPay;
  data['n_can_extend'] = entity.nCanExtend;
  data['d_unit'] = entity.dUnit;
  data['z_period'] = entity.zPeriod;
  return data;
}

extension BorrowDetailDataProductExtension on BorrowDetailDataProduct {
  BorrowDetailDataProduct copyWith({
    int? eLife,
    int? fSettlementType,
    int? gInterest,
    int? iOverdueRate,
    int? jViolateFeeRate,
    int? kExtendRate,
    int? lMinPay,
    String? mCanPartPay,
    String? nCanExtend,
    String? dUnit,
    int? zPeriod,
  }) {
    return BorrowDetailDataProduct()
      ..eLife = eLife ?? this.eLife
      ..fSettlementType = fSettlementType ?? this.fSettlementType
      ..gInterest = gInterest ?? this.gInterest
      ..iOverdueRate = iOverdueRate ?? this.iOverdueRate
      ..jViolateFeeRate = jViolateFeeRate ?? this.jViolateFeeRate
      ..kExtendRate = kExtendRate ?? this.kExtendRate
      ..lMinPay = lMinPay ?? this.lMinPay
      ..mCanPartPay = mCanPartPay ?? this.mCanPartPay
      ..nCanExtend = nCanExtend ?? this.nCanExtend
      ..dUnit = dUnit ?? this.dUnit
      ..zPeriod = zPeriod ?? this.zPeriod;
  }
}

BorrowDetailDataLoan $BorrowDetailDataLoanFromJson(Map<String, dynamic> json) {
  final BorrowDetailDataLoan borrowDetailDataLoan = BorrowDetailDataLoan();
  final int? eAmount = jsonConvert.convert<int>(json['e_amount']);
  if (eAmount != null) {
    borrowDetailDataLoan.eAmount = eAmount;
  }
  final String? gReceiverName = jsonConvert.convert<String>(
      json['g_receiver_name']);
  if (gReceiverName != null) {
    borrowDetailDataLoan.gReceiverName = gReceiverName;
  }
  final String? hReceiverBankcardNumber = jsonConvert.convert<String>(
      json['h_receiver_bankcard_number']);
  if (hReceiverBankcardNumber != null) {
    borrowDetailDataLoan.hReceiverBankcardNumber = hReceiverBankcardNumber;
  }
  final dynamic iReceiverBankcardName = json['i_receiver_bankcard_name'];
  if (iReceiverBankcardName != null) {
    borrowDetailDataLoan.iReceiverBankcardName = iReceiverBankcardName;
  }
  final dynamic oSuccessAt = json['o_success_at'];
  if (oSuccessAt != null) {
    borrowDetailDataLoan.oSuccessAt = oSuccessAt;
  }
  return borrowDetailDataLoan;
}

Map<String, dynamic> $BorrowDetailDataLoanToJson(BorrowDetailDataLoan entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['e_amount'] = entity.eAmount;
  data['g_receiver_name'] = entity.gReceiverName;
  data['h_receiver_bankcard_number'] = entity.hReceiverBankcardNumber;
  data['i_receiver_bankcard_name'] = entity.iReceiverBankcardName;
  data['o_success_at'] = entity.oSuccessAt;
  return data;
}

extension BorrowDetailDataLoanExtension on BorrowDetailDataLoan {
  BorrowDetailDataLoan copyWith({
    int? eAmount,
    String? gReceiverName,
    String? hReceiverBankcardNumber,
    dynamic iReceiverBankcardName,
    dynamic oSuccessAt,
  }) {
    return BorrowDetailDataLoan()
      ..eAmount = eAmount ?? this.eAmount
      ..gReceiverName = gReceiverName ?? this.gReceiverName
      ..hReceiverBankcardNumber = hReceiverBankcardNumber ??
          this.hReceiverBankcardNumber
      ..iReceiverBankcardName = iReceiverBankcardName ??
          this.iReceiverBankcardName
      ..oSuccessAt = oSuccessAt ?? this.oSuccessAt;
  }
}