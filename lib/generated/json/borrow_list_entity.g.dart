import 'package:myapp9/generated/json/base/json_convert_content.dart';
import 'package:myapp9/models/borrow_list_entity.dart';

BorrowListEntity $BorrowListEntityFromJson(Map<String, dynamic> json) {
  final BorrowListEntity borrowListEntity = BorrowListEntity();
  final bool? success = jsonConvert.convert<bool>(json['success']);
  if (success != null) {
    borrowListEntity.success = success;
  }
  final String? errorMessage = jsonConvert.convert<String>(
      json['errorMessage']);
  if (errorMessage != null) {
    borrowListEntity.errorMessage = errorMessage;
  }
  final List<BorrowListData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<BorrowListData>(e) as BorrowListData)
      .toList();
  if (data != null) {
    borrowListEntity.data = data;
  }
  final BorrowListOther? other = jsonConvert.convert<BorrowListOther>(
      json['other']);
  if (other != null) {
    borrowListEntity.other = other;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    borrowListEntity.total = total;
  }
  final int? currentPage = jsonConvert.convert<int>(json['currentPage']);
  if (currentPage != null) {
    borrowListEntity.currentPage = currentPage;
  }
  final int? perPage = jsonConvert.convert<int>(json['perPage']);
  if (perPage != null) {
    borrowListEntity.perPage = perPage;
  }
  final bool? hasMorePages = jsonConvert.convert<bool>(json['hasMorePages']);
  if (hasMorePages != null) {
    borrowListEntity.hasMorePages = hasMorePages;
  }
  return borrowListEntity;
}

Map<String, dynamic> $BorrowListEntityToJson(BorrowListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['success'] = entity.success;
  data['errorMessage'] = entity.errorMessage;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  data['other'] = entity.other?.toJson();
  data['total'] = entity.total;
  data['currentPage'] = entity.currentPage;
  data['perPage'] = entity.perPage;
  data['hasMorePages'] = entity.hasMorePages;
  return data;
}

extension BorrowListEntityExtension on BorrowListEntity {
  BorrowListEntity copyWith({
    bool? success,
    String? errorMessage,
    List<BorrowListData>? data,
    BorrowListOther? other,
    int? total,
    int? currentPage,
    int? perPage,
    bool? hasMorePages,
  }) {
    return BorrowListEntity()
      ..success = success ?? this.success
      ..errorMessage = errorMessage ?? this.errorMessage
      ..data = data ?? this.data
      ..other = other ?? this.other
      ..total = total ?? this.total
      ..currentPage = currentPage ?? this.currentPage
      ..perPage = perPage ?? this.perPage
      ..hasMorePages = hasMorePages ?? this.hasMorePages;
  }
}

BorrowListData $BorrowListDataFromJson(Map<String, dynamic> json) {
  final BorrowListData borrowListData = BorrowListData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    borrowListData.id = id;
  }
  final String? hSn = jsonConvert.convert<String>(json['h_sn']);
  if (hSn != null) {
    borrowListData.hSn = hSn;
  }
  final int? jStatus = jsonConvert.convert<int>(json['j_status']);
  if (jStatus != null) {
    borrowListData.jStatus = jStatus;
  }
  final int? dProductId = jsonConvert.convert<int>(json['d_product_id']);
  if (dProductId != null) {
    borrowListData.dProductId = dProductId;
  }
  final int? kSubStatus = jsonConvert.convert<int>(json['k_sub_status']);
  if (kSubStatus != null) {
    borrowListData.kSubStatus = kSubStatus;
  }
  final int? mBorrowAmount = jsonConvert.convert<int>(json['m_borrow_amount']);
  if (mBorrowAmount != null) {
    borrowListData.mBorrowAmount = mBorrowAmount;
  }
  final String? qExpectRepayTime = jsonConvert.convert<String>(
      json['q_expect_repay_time']);
  if (qExpectRepayTime != null) {
    borrowListData.qExpectRepayTime = qExpectRepayTime;
  }
  final String? tSettledTime = jsonConvert.convert<String>(
      json['t_settled_time']);
  if (tSettledTime != null) {
    borrowListData.tSettledTime = tSettledTime;
  }
  final int? yShowExtendBtn = jsonConvert.convert<int>(
      json['y_show_extend_btn']);
  if (yShowExtendBtn != null) {
    borrowListData.yShowExtendBtn = yShowExtendBtn;
  }
  final int? aTMaxExtendDays = jsonConvert.convert<int>(
      json['a_t_max_extend_days']);
  if (aTMaxExtendDays != null) {
    borrowListData.aTMaxExtendDays = aTMaxExtendDays;
  }
  final int? aPPeriodCount = jsonConvert.convert<int>(json['a_p_period_count']);
  if (aPPeriodCount != null) {
    borrowListData.aPPeriodCount = aPPeriodCount;
  }
  final String? oLoanTime = jsonConvert.convert<String>(json['o_loan_time']);
  if (oLoanTime != null) {
    borrowListData.oLoanTime = oLoanTime;
  }
  final int? pLoanAmount = jsonConvert.convert<int>(json['p_loan_amount']);
  if (pLoanAmount != null) {
    borrowListData.pLoanAmount = pLoanAmount;
  }
  final String? aMBankcard = jsonConvert.convert<String>(json['a_m_bankcard']);
  if (aMBankcard != null) {
    borrowListData.aMBankcard = aMBankcard;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    borrowListData.createdAt = createdAt;
  }
  return borrowListData;
}

Map<String, dynamic> $BorrowListDataToJson(BorrowListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['h_sn'] = entity.hSn;
  data['j_status'] = entity.jStatus;
  data['d_product_id'] = entity.dProductId;
  data['k_sub_status'] = entity.kSubStatus;
  data['m_borrow_amount'] = entity.mBorrowAmount;
  data['q_expect_repay_time'] = entity.qExpectRepayTime;
  data['t_settled_time'] = entity.tSettledTime;
  data['y_show_extend_btn'] = entity.yShowExtendBtn;
  data['a_t_max_extend_days'] = entity.aTMaxExtendDays;
  data['a_p_period_count'] = entity.aPPeriodCount;
  data['o_loan_time'] = entity.oLoanTime;
  data['p_loan_amount'] = entity.pLoanAmount;
  data['a_m_bankcard'] = entity.aMBankcard;
  data['created_at'] = entity.createdAt;
  return data;
}

extension BorrowListDataExtension on BorrowListData {
  BorrowListData copyWith({
    int? id,
    String? hSn,
    int? jStatus,
    int? dProductId,
    int? kSubStatus,
    int? mBorrowAmount,
    String? qExpectRepayTime,
    String? tSettledTime,
    int? yShowExtendBtn,
    int? aTMaxExtendDays,
    int? aPPeriodCount,
    String? oLoanTime,
    int? pLoanAmount,
    String? aMBankcard,
    String? createdAt,
  }) {
    return BorrowListData()
      ..id = id ?? this.id
      ..hSn = hSn ?? this.hSn
      ..jStatus = jStatus ?? this.jStatus
      ..dProductId = dProductId ?? this.dProductId
      ..kSubStatus = kSubStatus ?? this.kSubStatus
      ..mBorrowAmount = mBorrowAmount ?? this.mBorrowAmount
      ..qExpectRepayTime = qExpectRepayTime ?? this.qExpectRepayTime
      ..tSettledTime = tSettledTime ?? this.tSettledTime
      ..yShowExtendBtn = yShowExtendBtn ?? this.yShowExtendBtn
      ..aTMaxExtendDays = aTMaxExtendDays ?? this.aTMaxExtendDays
      ..aPPeriodCount = aPPeriodCount ?? this.aPPeriodCount
      ..oLoanTime = oLoanTime ?? this.oLoanTime
      ..pLoanAmount = pLoanAmount ?? this.pLoanAmount
      ..aMBankcard = aMBankcard ?? this.aMBankcard
      ..createdAt = createdAt ?? this.createdAt;
  }
}

BorrowListOther $BorrowListOtherFromJson(Map<String, dynamic> json) {
  final BorrowListOther borrowListOther = BorrowListOther();
  final int? all = jsonConvert.convert<int>(json['all']);
  if (all != null) {
    borrowListOther.all = all;
  }
  final int? review = jsonConvert.convert<int>(json['review']);
  if (review != null) {
    borrowListOther.review = review;
  }
  final int? rejected = jsonConvert.convert<int>(json['rejected']);
  if (rejected != null) {
    borrowListOther.rejected = rejected;
  }
  final int? disbursing = jsonConvert.convert<int>(json['disbursing']);
  if (disbursing != null) {
    borrowListOther.disbursing = disbursing;
  }
  final int? outstanding = jsonConvert.convert<int>(json['outstanding']);
  if (outstanding != null) {
    borrowListOther.outstanding = outstanding;
  }
  final int? overdue = jsonConvert.convert<int>(json['overdue']);
  if (overdue != null) {
    borrowListOther.overdue = overdue;
  }
  final int? closed = jsonConvert.convert<int>(json['closed']);
  if (closed != null) {
    borrowListOther.closed = closed;
  }
  final int? cleared = jsonConvert.convert<int>(json['cleared']);
  if (cleared != null) {
    borrowListOther.cleared = cleared;
  }
  return borrowListOther;
}

Map<String, dynamic> $BorrowListOtherToJson(BorrowListOther entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['all'] = entity.all;
  data['review'] = entity.review;
  data['rejected'] = entity.rejected;
  data['disbursing'] = entity.disbursing;
  data['outstanding'] = entity.outstanding;
  data['overdue'] = entity.overdue;
  data['closed'] = entity.closed;
  data['cleared'] = entity.cleared;
  return data;
}

extension BorrowListOtherExtension on BorrowListOther {
  BorrowListOther copyWith({
    int? all,
    int? review,
    int? rejected,
    int? disbursing,
    int? outstanding,
    int? overdue,
    int? closed,
    int? cleared,
  }) {
    return BorrowListOther()
      ..all = all ?? this.all
      ..review = review ?? this.review
      ..rejected = rejected ?? this.rejected
      ..disbursing = disbursing ?? this.disbursing
      ..outstanding = outstanding ?? this.outstanding
      ..overdue = overdue ?? this.overdue
      ..closed = closed ?? this.closed
      ..cleared = cleared ?? this.cleared;
  }
}