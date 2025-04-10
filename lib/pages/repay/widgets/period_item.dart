import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp9/res/resources.dart';
import 'package:myapp9/util/other_utils.dart';
import 'package:myapp9/util/theme_utils.dart';
import 'package:myapp9/widgets/my_card.dart';

import '../../../models/borrow_detail_entity.dart';
import '../../../util/toast_utils.dart';
import '../../../widgets/load_image.dart';

class PeriodItem extends StatelessWidget {
  final int index;
  final int type;
  final int totalCount;
  final bool isSelected;
  final ValueChanged<bool> onSelect;
  final BorrowDetailDataPeriods period;

  const PeriodItem({
    Key? key,
    required this.index,
    required this.type,
    required this.totalCount,
    required this.isSelected,
    required this.onSelect,
    required this.period,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: MyCard(
          color: isSelected ? Colors.blue[50] : Colors.white,
          // shadowColor: Colors.black38,
          shadowColor: isSelected ? Colors.blueAccent : Colors.black38,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: () {
                if (index == 0) {
                  Toast.show("Select at least one period");
                  onSelect(!isSelected);
                } else {
                  onSelect(!isSelected);
                }
              },
              child: _buildContent(context),
            ),
          ),
        ));
  }

  Widget _buildContent(BuildContext context) {
    final TextStyle? textTextStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: Dimens.font_sp12);
    final bool isDark = context.isDark;
    int days = DateTime.parse(period.aPExpectRepayTime!).difference(DateTime.now()).inDays;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: textTextStyle,
                  children: <TextSpan>[
                    TextSpan(text: '${period.dIndex}/$totalCount ', style: TextStyle(fontSize: Dimens.font_sp16)),
                    TextSpan(text: 'Installments', style: Theme.of(context).textTheme.titleSmall),
                  ],
                ),
              ),
            ),
            LoadAssetImage(isSelected ? 'txxz' : 'txwxz', width: 21.0),
            Gaps.hGap4,
          ],
        ),
        Gaps.vGap8,
        Gaps.line,
        Gaps.vGap8,
        Row(
          children: <Widget>[
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: textTextStyle,
                  children: <TextSpan>[
                    TextSpan(text: "Due Date", style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
            ),
            Text(
              DateFormat('yyyy-MM-dd').format(DateTime.parse(period.aPExpectRepayTime.nullSafe)),
              style: TextStyles.textBold14,
            ),
          ],
        ),
        Gaps.vGap4,
        Row(
          children: <Widget>[
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: textTextStyle,
                  children: <TextSpan>[
                    TextSpan(text: "Loan Amount", style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
            ),
            Text(
              Utils.formatPrice2(period.gExpectBorrowAmount! + period.oPaidBorrowAmount!),
              style: TextStyles.textBold14,
            ),
          ],
        ),
        Gaps.vGap4,
        Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      style: textTextStyle,
                      children: <TextSpan>[
                        TextSpan(text: "Interest ", style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                  type == 1 ? _buildGoodsTag(Theme.of(context).primaryColor, 'Pay Upfront') : Gaps.empty,
                ],
              ),
            ),
            Text(
              Utils.formatPrice2(period.aWInterest!),
              style: TextStyles.textBold14,
            ),
          ],
        ),
        Gaps.vGap4,
        Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      style: textTextStyle,
                      children: <TextSpan>[
                        TextSpan(text: "Service Fee ", style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                  type == 1 ? _buildGoodsTag(Theme.of(context).primaryColor, 'Pay Upfront') : Gaps.empty,
                ],
              ),
            ),
            Text(
              Utils.formatPrice2(period.aXServiceFee!),
              style: TextStyles.textBold14,
            ),
          ],
        ),
/*        if (period.lOverdueDays! == 0)
          Gaps.empty
        else
          Column(
            children: [
              Gaps.vGap4,
              Row(
                children: <Widget>[
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: textTextStyle,
                        children: <TextSpan>[
                          TextSpan(text: "Violate Amount", style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    '\$${period.jExpectViolateFee! - period.rPaidViolateFee!}',
                    style: TextStyles.textBold14,
                  ),
                ],
              ),
            ],
          ),*/
        if (period.lOverdueDays! <= 0)
          Gaps.empty
        else
          Column(
            children: [
              Gaps.vGap4,
              Row(
                children: <Widget>[
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: textTextStyle,
                        children: <TextSpan>[
                          TextSpan(text: "Penalty Fee", style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    Utils.formatPrice2(period.kExpectOverdueAmount! - period.sPaidOverdueAmount!),
                    style: TextStyles.textBold14,
                  ),
                ],
              ),
            ],
          ),
        if (period.nPaidAmount! == 0)
          Gaps.empty
        else
          Column(
            children: [
              Gaps.vGap4,
              Row(
                children: <Widget>[
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: textTextStyle,
                        children: <TextSpan>[
                          TextSpan(text: "Paid Amount", style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    '-${Utils.formatPrice2(period.nPaidAmount!)}',
                    style: const TextStyle(
                      fontSize: Dimens.font_sp14,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        if (period.aUCurrentDeductionFee! == 0)
          Gaps.empty
        else
          Column(
            children: [
              Gaps.vGap4,
              Row(
                children: <Widget>[
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: textTextStyle,
                        children: <TextSpan>[
                          TextSpan(text: "Reduce Amount", style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    '- ${Utils.formatPrice2(period.aUCurrentDeductionFee!)}',
                    style: const TextStyle(
                      fontSize: Dimens.font_sp14,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        Column(
          children: [
            Gaps.vGap4,
            Row(
              children: <Widget>[
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: textTextStyle,
                      children: <TextSpan>[
                        TextSpan(text: "Repayment Amount", style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                ),
                Text(
                  Utils.formatPrice2(period.fExpectRepayTotalAmount! - period.pPaidInterest! - period.qPaidServiceFee! - period.sPaidOverdueAmount! - period.oPaidBorrowAmount!),
                  style: TextStyles.textBold14,
                ),
              ],
            ),
          ],
        ),
        Gaps.vGap8,
        Gaps.line,
        Gaps.vGap8,
        Row(
          children: <Widget>[
            if (period.lOverdueDays! > 0)
              Container(
                decoration: BoxDecoration(
                  color: Colors.pink[100],
                  borderRadius: BorderRadius.circular(4.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                child: RichText(
                  text: TextSpan(
                    style: textTextStyle,
                    children: <TextSpan>[
                      // TextSpan(text: 'Overdue ', style: Theme.of(context).textTheme.bodySmall),
                      TextSpan(
                          text: 'Overdue for ${period.lOverdueDays} Days',
                          style: TextStyle(
                            fontSize: Dimens.font_sp14,
                            color: Theme.of(context).colorScheme.error,
                          )),
                    ],
                  ),
                ),
              )
            else
              if (days == 0)
              RichText(
                text: TextSpan(
                  style: textTextStyle,
                  children: const <TextSpan>[
                    // TextSpan(text: 'Overdue ', style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(
                        text: 'Your loan is due today',
                        style: TextStyle(
                          fontSize: Dimens.font_sp14,
                          color: Colors.green,
                        )),
                  ],
                ),
              )
            else
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(4.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                child: RichText(
                  text: TextSpan(
                    style: textTextStyle,
                    children: <TextSpan>[
                      // TextSpan(text: 'Overdue ', style: Theme.of(context).textTheme.bodySmall),
                      TextSpan(
                          text: 'Will be due in $days Days',
                          style: const TextStyle(
                            fontSize: Dimens.font_sp14,
                            color: Colors.grey,
                          )),
                    ],
                  ),
                ),
              ),
            const Expanded(child: Gaps.empty),
            OrderItemButton(
              key: const Key('order_button_3_'),
              text: isSelected ? "Cancel" : "Select",
              textColor: isDark ? Colours.dark_button_text : Colors.white,
              bgColor: isDark ? Colours.dark_app_main : Colours.app_main,
              onTap: () {
                onSelect(!isSelected);
              },
            ),
          ],
        )
      ],
    );
  }

  Widget _buildGoodsTag(Color color, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        color: Colors.blue[200],
        borderRadius: BorderRadius.circular(2.0),
      ),
      height: 12.0,
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 7.0,
          height: 1.1,
        ),
      ),
    );
  }
}

class OrderItemButton extends StatelessWidget {
  const OrderItemButton({super.key, this.bgColor, this.textColor, required this.text, this.onTap});

  final Color? bgColor;
  final Color? textColor;
  final GestureTapCallback? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(4.0),
        ),
        constraints: const BoxConstraints(
          minWidth: 64.0,
          maxHeight: 28.0,
          minHeight: 28.0,
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: Dimens.font_sp14, color: textColor),
        ),
      ),
    );
  }
}
