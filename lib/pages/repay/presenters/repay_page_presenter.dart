import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp9/mvp/base_page_presenter.dart';
import 'package:myapp9/net/net.dart';
import 'package:myapp9/pages/repay/iviews/repay_i_mvp_view.dart';

import '../../../models/borrow_detail_entity.dart';

class RepayPagePresenter extends BasePagePresenter<RepayIMvpView> {
  RepayPagePresenter(this.productId);

  final String productId;
  static const platform = MethodChannel('samples.flutter.io/battery');
  late Map<String, dynamic> allDeviceInfo;
  late Map<String, dynamic> dynamicInfo;

  @override
  void initState() {
    print('borrow_id:');
    print(productId);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // allDeviceInfo = await Device().getAllDeviceInfo();
      // dynamicInfo = await Device().getDeviceDynamicInfo('1');
      // int id = Provider.of<ProductProvider>(view.getContext(), listen: false).bProductEntity.id!;
      // Provider.of<ProductProvider>(view.getContext(), listen:false).bProductEntity.id!;
      index(true, productId);
    });
  }

  Future index(bool isShowDialog, String id) {
    Map<String, dynamic>? params = {};
    return requestNetwork<BorrowDetailEntity>(Method.get, url: '${HttpApi.dBorrowsShow}/$id', queryParameters: params, isShow: isShowDialog, onSuccess: (data) {
      if (data != null) {
        if (data.data!.borrow != null) {
          view.provider.setBorrow(data.data!.borrow!);
        }
        if (data.data!.periods != null) {
          List<BorrowDetailDataPeriods> duePeriods = data.data!.periods!.where((element) => element.eStatus != 80).toList();
          late List<bool> initialSelected = List.generate(duePeriods.length, (_) => false);
          late int initialSelectedCount = 0;
          late int initialSelectedAmount = 0;
          late List<int> initialSelectedIds = [];

          view.provider.setPeriods(duePeriods);
          for (var i = 0; i < duePeriods.length; i++) {
            if (duePeriods[i].lOverdueDays! > 0) {
              initialSelected[i] = true;
              initialSelectedCount++;
              final int periodShouldRepayAmount = duePeriods[i].fExpectRepayTotalAmount! - duePeriods[i].pPaidInterest! - duePeriods[i].qPaidServiceFee! - duePeriods[i].sPaidOverdueAmount! - duePeriods[i].oPaidBorrowAmount!;
              initialSelectedAmount += periodShouldRepayAmount;
              initialSelectedIds.add(duePeriods[i].id!);
            }
          }
          if (initialSelectedCount == 0) {
            initialSelected[0] = true;
            initialSelectedCount = 1;
            final int periodShouldRepayAmount = duePeriods[0].fExpectRepayTotalAmount! - duePeriods[0].pPaidInterest! - duePeriods[0].qPaidServiceFee! - duePeriods[0].sPaidOverdueAmount! - duePeriods[0].oPaidBorrowAmount!;
            initialSelectedAmount += periodShouldRepayAmount;
            initialSelectedIds.add(duePeriods[0].id!);
          }
          view.setInitial(initialSelected, initialSelectedCount, initialSelectedAmount, initialSelectedIds, data.data!.borrow!.hSn!);
        }
        if (data.data!.product != null) {
          view.provider.setProduct(data.data!.product!);
        }
        if (data.data!.loan != null) {
          view.provider.setLoan(data.data!.loan!);
        }
        if (data.data!.tips != null) {
          view.provider.setTips(data.data!.tips!);
        }
      }
    }, onError: (_, __) {
      /// 加载失败
      print(123);
    });
  }

}
