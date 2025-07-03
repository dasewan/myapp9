import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../config/constant.dart';
import '../../../models/borrow_list_entity.dart';
import '../../../res/raw/dimens.dart';
import '../../../res/raw/gaps.dart';
import '../../../routers/fluro_navigator.dart';
import '../../../util/other_utils.dart';
import '../../../widgets/my_button.dart';
import '../../repay/router/repay_router.dart';

/// design/4商品/index.html#artboard1
class OrderItem extends StatelessWidget {
  const OrderItem({
    super.key,
    required this.item,
    required this.index,
    required this.selectIndex,
    required this.onTapMenu,
    required this.onTapEdit,
    required this.onTapOperation,
    required this.onTapMenuClose,
    required this.animation,
    // required this.heroTag,
  });

  final BorrowListData item;
  final int index;
  final int selectIndex;
  final VoidCallback onTapMenu;
  final VoidCallback onTapEdit;
  final VoidCallback onTapOperation;
  final VoidCallback onTapMenuClose;
  final Animation<double> animation;

  // final String heroTag;

  @override
  Widget build(BuildContext context) {
    final TextStyle? textTextStyle3 = Theme.of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(fontSize: Dimens.font_sp14, color: Colors.grey[500]);
    Map<int, Color> statusColor = {
      //审核中 1
      Constant.MACHINE_WAIT: Colors.grey,
      Constant.MACHINE_ING: Colors.grey,
      Constant.MACHINE_SUCCESS: Colors.grey,
      Constant.REVIEW_WAIT: Colors.grey,
      Constant.REVIEW_SUCCESS: Colors.grey,
      Constant.REVIEW_ING: Colors.grey,
      Constant.LOAN_WAIT: Colors.grey,
      Constant.LOAN_ING: Colors.grey,
      Constant.LOAN_FAIL: Colors.grey,
      Constant.LOAN_REFUSE: Colors.grey,
      Constant.LOAN_INTERCEPT: Colors.grey,
      //已拒绝 2
      Constant.MACHINE_REFUSE: Colors.redAccent,
      Constant.REVIEW_REFUSE: Colors.redAccent,
      // 待还款3
      Constant.REPAY_WAIT: Colors.blue,
      Constant.REPAY_ING: Colors.blue,
      Constant.REPAY_FAIL: Colors.blue,
      // 逾期 4
      Constant.borrow_overdue: Colors.red,
      Constant.OVERDUE_SLIGHT: Colors.red,
      Constant.OVERDUE_MEDIUM: Colors.red,
      Constant.OVERDUE_SERIOUS: Colors.red,
      // 结清5
      Constant.borrow_cleared: Colors.green,
      //关闭6
      Constant.borrow_closed: Colors.blueGrey,
    };
    Map<int, String> statusText = {
      Constant.borrow_verify: "Pending Certification",
      Constant.borrow_sign: "Pending Signing",
      Constant.borrow_machine: "Under Review",
      Constant.borrow_review: "Under Review",
      Constant.borrow_loan: "Under Review",
      Constant.borrow_outstanding: "Pending Repayment",
      Constant.borrow_cleared: "Settled",
      Constant.borrow_overdue: "Overdue",
      Constant.borrow_closed: "Closed",
      // Under Review 1
      Constant.MACHINE_WAIT: "Under Review",
      Constant.MACHINE_ING: "Under Review",
      Constant.MACHINE_SUCCESS: "Under Review",
      Constant.REVIEW_WAIT: "Under Review",
      Constant.REVIEW_SUCCESS: "Under Review",
      Constant.REVIEW_ING: "Under Review",
      Constant.LOAN_WAIT: "Under Review",
      Constant.LOAN_ING: "Under Review",
      Constant.LOAN_FAIL: "Under Review",
      Constant.LOAN_REFUSE: "Under Review",
      Constant.LOAN_INTERCEPT: "Under Review",
      // Rejected 2
      Constant.MACHINE_REFUSE: "Rejected",
      Constant.REVIEW_REFUSE: "Rejected",
      // Pending Repayment 3
      Constant.REPAY_WAIT: "Pending Repayment",
      Constant.REPAY_ING: "Pending Repayment",
      Constant.REPAY_FAIL: "Pending Repayment",
      // Overdue 4
      Constant.OVERDUE_SLIGHT: "Overdue",
      Constant.OVERDUE_MEDIUM: "Overdue",
      Constant.OVERDUE_SERIOUS: "Overdue",
    };
    final Row child = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
/*        ExcludeSemantics(
          child: Hero(
            tag: heroTag,
            child: LoadImage(item.icon, width: 72.0, height: 72.0),
          ),
        ),*/
        Gaps.hGap8,
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (item.jStatus == 90 || item.jStatus == 60)
                Row(
                  children: [
                    SizedBox(
                      // width: 120,
                      child: Text(
                        'Due Date',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTextStyle3,
                      ),
                    ),
                    Text(
                      DateFormat('yyyy-MM-dd HH:mm').format(
                          DateTime.parse(item.qExpectRepayTime.nullSafe)),
                    )
                  ],
                )
              else
                Gaps.empty,
              Gaps.vGap4,
              Row(
                children: [
                  SizedBox(
                    // width: 120,
                    child: Text(
                      'SN：',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTextStyle3,
                    ),
                  ),
                  Text(
                    item.hSn!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Gaps.vGap4,
              Row(
                children: [
                  SizedBox(
                    // width: 120,
                    child: Text(
                      'Loan Amount：',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTextStyle3,
                    ),
                  ),
                  Text(Utils.formatPrice2(item.mBorrowAmount!))
                ],
              ),
              // Gaps.vGap4,
              // Row(
              //   children: [
              //     SizedBox(
              //       // width: 120,
              //       child: Text(
              //         'Application Date：',
              //         maxLines: 1,
              //         overflow: TextOverflow.ellipsis,
              //         style: textTextStyle3,
              //       ),
              //     ),
              //     Text(
              //       DateFormat('yyyy-MM-dd HH:mm')
              //           .format(DateTime.parse(item.createdAt.nullSafe)),
              //     )
              //   ],
              // ),

              if (item.jStatus == 90 || item.jStatus == 60)
                Gaps.vGap4
              else
                Gaps.empty,
              if (item.jStatus == 60 || item.jStatus == 90)
                Row(
                  children: [
                    SizedBox(
                      // width: 120,
                      child: Text(
                        'Received Amount: ',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTextStyle3,
                      ),
                    ),
                    Text(Utils.formatPrice2(item.pLoanAmount!))
                  ],
                )
              else
                Gaps.empty,
              if (item.jStatus == 90 || item.jStatus == 60)
                Gaps.vGap4
              else
                Gaps.empty,
              if (item.jStatus == 60 || item.jStatus == 90)
                Row(
                  children: [
                    SizedBox(
                      // width: 120,
                      child: Text(
                        'Mobile Money Number: ',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTextStyle3,
                      ),
                    ),
                    Text(item.aMBankcard!)
                  ],
                )
              else
                Gaps.empty,
              if (item.jStatus == 80 ||
                  item.jStatus == 90 ||
                  item.jStatus == 60)
                Gaps.vGap4
              else
                Gaps.empty,
              if (item.jStatus == 80)
                Row(
                  children: [
                    SizedBox(
                      // width: 120,
                      child: Text(
                        'Settled Time：',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTextStyle3,
                      ),
                    ),
                    Text(
                      DateFormat('yyyy-MM-dd HH:mm')
                          .format(DateTime.parse(item.tSettledTime.nullSafe)),
                    )
                  ],
                )
              else
                Gaps.empty,

              if (item.jStatus == 60 || item.jStatus == 90)
                Row(
                  children: [
                    SizedBox(
                      // width: 120,
                      child: Text(
                        'Disbursement Date: ',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTextStyle3,
                      ),
                    ),
                    Text(
                      DateFormat('yyyy-MM-dd HH:mm')
                          .format(DateTime.parse(item.oLoanTime.nullSafe)),
                    )
                  ],
                )
              else
                Gaps.empty,
            ],
          ),
        ),
        if (item.jStatus == Constant.borrow_overdue ||
                item.jStatus == Constant.borrow_outstanding) SizedBox(
                height: 124,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      statusText[item.jStatus]!,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: statusColor[item.jStatus]),
                    ),
                    const Expanded(child: Gaps.empty),
                    SizedBox(
                      height: 34,
                      child: MyButton(
                        minWidth: 1,
                        minHeight: 1,
                        radius: 2.0,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        fontSize: Dimens.font_sp14,
                        backgroundColor: Colors.redAccent[700],
                        onPressed: () {
                          NavigatorUtils.push(context,
                              '${RepayRouter.repay}?productId=${item.dProductId}');
                        },
                        text: 'Repay',
                      ),
                    )
                  ],
                ),
              ) else Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.jStatus == Constant.borrow_cleared ||
                            item.jStatus == Constant.borrow_closed
                        ? statusText[item.jStatus]!
                        : statusText[item.kSubStatus]!,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: item.jStatus == Constant.borrow_cleared ||
                                item.jStatus == Constant.borrow_closed
                            ? statusColor[item.jStatus]!
                            : statusColor[item.kSubStatus]!),
                  ),
                ],
              )
      ],
    );

    return Stack(
      children: <Widget>[
        // item间的分隔线
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                bottom: Divider.createBorderSide(context, width: 0.8),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
