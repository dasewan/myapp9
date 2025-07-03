import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myapp9/config/constant.dart';
import 'package:myapp9/mvp/base_page_presenter.dart';
import 'package:myapp9/net/net.dart';
import 'package:myapp9/pages/verify/router/verify_router.dart';
import 'package:myapp9/providers/user_provider.dart';
import 'package:myapp9/util/other_utils.dart';
import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';

import '../../../config/index_action_constant.dart';
import '../../../models/g_verifies_show_entity.dart';
import '../../../models/g_verify_entity.dart';
import '../../../models/index_entity.dart';
import '../../../providers/index_new_provider.dart';
import '../../../util/cache.dart';
import '../../../util/helper.dart';
import '../iviews/index_new_i_mvp_view.dart';

class IndexNewPagePresenter extends BasePagePresenter<IndexNewIMvpView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      location2();
      int currentTimeInSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      int lastIndexFetchAt = SpUtil.getInt(Constant.lastIndexFetchAt, defValue: currentTimeInSeconds)!;
      if (currentTimeInSeconds == lastIndexFetchAt || currentTimeInSeconds - lastIndexFetchAt > 30) {
        indexNew(true);
      }
    });
  }

  Future<void> location2() async {
    // await MyPermission().myGeolocator(view: view);
  }

  /// 自定义排序
  void sortByCustomOrder(List<IndexDataBProducts> data, List<int> sortByIds) {
    // 参照sortByIds列表创建一个权重映射，其中id的索引作为权重
    final idToWeight = {for (var i = 0; i < sortByIds.length; i++) sortByIds[i]: i};
    print(idToWeight);
    // 排序data列表
    data.sort((a, b) {
      // 获取a和b的id权重，如果id不在sortByIds中，则使用一个较大的数字作为权重
      final weightA = idToWeight[a.id] ?? sortByIds.length;
      final weightB = idToWeight[b.id] ?? sortByIds.length;
      return weightA.compareTo(weightB);
    });
  }

  Future indexNew(bool isShowDialog) {
    String? bProductsNewestUpdatedAt = SpUtil.getString(Constant.bProductsNewestUpdatedAt);
    String? dBorrowsNewestUpdatedAt = SpUtil.getString(Constant.dBorrowsNewestUpdatedAt);
    String? rFNotificationsNewestUpdatedAt = SpUtil.getString(Constant.rFNotificationsNewestUpdatedAt);
    String? qDBannersNewestUpdatedAt = SpUtil.getString(Constant.qDBannersNewestUpdatedAt);
    String? backTipsUpdatedAt = SpUtil.getString(Constant.backTipsUpdatedAt);
    String? bCProductFeaturesUpdatedAt = SpUtil.getString(Constant.bCProductFeaturesUpdatedAt);
    // final Map<String, String> params = <String, String>{};
    Map<String, dynamic>? params = {
      "b_products_newest_updated_at": "",
      "d_borrows_newest_updated_at": dBorrowsNewestUpdatedAt,
      "r_f_notifications_newest_updated_at": rFNotificationsNewestUpdatedAt,
      "q_d_banners_newest_updated_at": qDBannersNewestUpdatedAt
    };
    final String accessToken = SpUtil.getString(Constant.accessToken).nullSafe;
    String url = '';
    if (accessToken.isNotEmpty) {
      url = HttpApi.indexNew;
    } else {
      url = HttpApi.indexNewNotLogin;
    }
    return requestNetwork<IndexEntity>(Method.get, url: url, queryParameters: params, isShow: isShowDialog, onSuccess: (reponse) async {
      if (reponse != null) {
        /// 产品
        if (bProductsNewestUpdatedAt == null || bProductsNewestUpdatedAt != reponse.data!.bProductsNewestUpdatedAt!) {
          SpUtil.putString(Constant.bProductsNewestUpdatedAt, reponse.data!.bProductsNewestUpdatedAt!);
          SpUtil.putObjectList(Constant.bProductsList, reponse.data!.bProducts!);
          //更新试算缓存
          for (IndexDataBProducts item in reponse.data!.bProducts!) {
            if (item.updatedAt != SpUtil.getString(Constant.lastFetchPreComputeTime + item.id.toString())) {
              SpUtil.remove(Constant.lastFetchPreComputeTime + item.id.toString());
              SpUtil.remove(Constant.preComputeInfo + item.id.toString());
            }
          }
        } else {
          //从缓存中补充
          List<Map>? dataList = SpUtil.getObjectList(Constant.bProductsList);

          if (dataList != null) {
            List<IndexDataBProducts> data = List<IndexDataBProducts>.from(dataList.map((value) {
              return $IndexDataBProductsFromJson(value);
            }));
            reponse.data?.bProducts = data;
          }
        }
        List<int> borrowIds = [];

        /// 订单
        if (reponse.data!.dBorrowsNewestUpdatedAt != null && reponse.data!.dBorrowsNewestUpdatedAt! != '') {
          if (dBorrowsNewestUpdatedAt == null || dBorrowsNewestUpdatedAt != reponse.data!.dBorrowsNewestUpdatedAt!) {
            SpUtil.putString(Constant.dBorrowsNewestUpdatedAt, reponse.data!.dBorrowsNewestUpdatedAt!);
            reponse.data!.dBorrows!.sort((a, b) {
              // 首先根据 aIOverdueDays 倒序排序
              int compareAIO = (b.aIOverdueDays ?? 0).compareTo(a.aIOverdueDays ?? 0);
              if (compareAIO != 0) {
                return compareAIO;
              } else {
                // 如果 aIOverdueDays 相同，则根据 jStatus 正序排序
                return (a.jStatus ?? 0).compareTo(b.jStatus ?? 0);
              }
            });
            SpUtil.putObjectList(Constant.dBorrowList, reponse.data!.dBorrows!);
          } else {
            //从缓存中补充
            List<Map>? borrowsList = SpUtil.getObjectList(Constant.dBorrowList);

            if (borrowsList != null) {
              List<IndexDataDBorrows> borrowsData = List<IndexDataDBorrows>.from(borrowsList.map((value) {
                return $IndexDataDBorrowsFromJson(value);
              }));
              reponse.data?.dBorrows = borrowsData;
            }
          }
          borrowIds = reponse.data!.dBorrows!.map((dBorrow) => dBorrow.id!).toList();
          // 排序
          sortByCustomOrder(reponse.data!.bProducts!, borrowIds);
        }
        // 删除禁用的产品
        reponse.data!.bProducts = reponse.data!.bProducts!.sublist(0, borrowIds.length) +
            reponse.data!.bProducts!.sublist(borrowIds.length).where((element) => element.uStatus == 'y').toList();

        /// banner
        if (reponse.data!.qDBannersNewestUpdatedAt != null && reponse.data!.qDBannersNewestUpdatedAt! != '') {
          if (qDBannersNewestUpdatedAt == null || qDBannersNewestUpdatedAt != reponse.data!.qDBannersNewestUpdatedAt!) {
            SpUtil.putString(Constant.qDBannersNewestUpdatedAt, reponse.data!.qDBannersNewestUpdatedAt!);
            SpUtil.putObjectList(Constant.qDBannerList, reponse.data!.qDBanners!);
          } else {
            //从缓存中补充
            List<Map>? bannerList = SpUtil.getObjectList(Constant.qDBannerList);

            if (bannerList != null) {
              List<IndexDataQDBanners> bannersData = List<IndexDataQDBanners>.from(bannerList.map((value) {
                return $IndexDataQDBannersFromJson(value);
              }));
              reponse.data?.qDBanners = bannersData;
            }
          }
        }

        /// notification
        if (reponse.data!.rFNotificationsNewestUpdatedAt != null && reponse.data!.rFNotificationsNewestUpdatedAt! != '') {
          if (rFNotificationsNewestUpdatedAt == null || rFNotificationsNewestUpdatedAt != reponse.data!.rFNotificationsNewestUpdatedAt!) {
            SpUtil.putString(Constant.rFNotificationsNewestUpdatedAt, reponse.data!.rFNotificationsNewestUpdatedAt!);
            SpUtil.putObjectList(Constant.rFNotificationList, reponse.data!.rFNotifications!);
          } else {
            //从缓存中补充
            List<Map>? notificationList = SpUtil.getObjectList(Constant.rFNotificationList);
            if (notificationList != null) {
              List<IndexDataRFNotifications> notificationsData = List<IndexDataRFNotifications>.from(notificationList.map((value) {
                return $IndexDataRFNotificationsFromJson(value);
              }));
              reponse.data?.rFNotifications = notificationsData;
            }
          }
        }
        List<ItemModel> itemList = [];
        //此处的provider存储原始的订单数据，作为全局原始的订单数据。首页会修改这个返回
        view.getContext().read<IndexNewProvider>().dBorrows = reponse.data!.dBorrows!;
        //逾期，待还，放款中，审核中，已拒绝，产品
        //去除结清订单和过期订单
        if (reponse.data!.dBorrows!.isNotEmpty) {
          reponse.data!.dBorrows!.sort((a, b) {
            if (a.kSubStatus == b.kSubStatus) {
              return b.aIOverdueDays!.compareTo(a.aIOverdueDays!);
            } else {
              return b.kSubStatus!.compareTo(a.kSubStatus!);
            }
          });
          Map<int, IndexDataDBorrows> borrowsMap = {};

          for (IndexDataDBorrows borrow in reponse.data!.dBorrows!) {
            if (borrow.jStatus == Constant.borrow_cleared || borrow.jStatus == Constant.borrow_closed) {
              continue;
            }
            if (Constant.yijujue.contains(borrow.kSubStatus!)) {
              // 是否已经过了冷静期
              String dateString = borrow.aUStatusTime!;
              DateTime coolDate = DateTime.parse(dateString);
              DateTime today = DateTime.now();
              DateTime todayStart = DateTime(today.year, today.month, today.day);
              if (todayStart.isAfter(coolDate)) {
                continue;
              }
            }
            borrowsMap[borrow.dProductId!] = borrow;
          }
          reponse.data!.dBorrows = borrowsMap.values.toList();
          for (int i = 0; i < reponse.data!.dBorrows!.length; i++) {
            if (i < reponse.data!.dBorrows!.length) {
              itemList.add(
                  ItemModel(reponse.data!.bProducts!.firstWhere((element) => element.id == reponse.data?.dBorrows?[i].dProductId), reponse.data?.dBorrows?[i]));
              reponse.data!.bProducts!.removeWhere((element) => element.id == reponse.data?.dBorrows?[i].dProductId);
            }
          }
        }
        reponse.data!.bProducts!.sort((a, b) => a.vSort!.compareTo(b.vSort!));
        List<String> userProducts = reponse.data!.aUser!.nProducts!.split(',');
        reponse.data!.bProducts!.sort((a, b) => userProducts.indexOf(b.id!.toString()) - userProducts.indexOf(a.id!.toString()));
        for (int i = 0; i < reponse.data!.bProducts!.length; i++) {
          itemList.add(ItemModel(reponse.data!.bProducts![i], null));
        }

        /// remind
        /// feature
        if (reponse.data!.bCProductFeaturesUpdatedAt != null && reponse.data!.bCProductFeaturesUpdatedAt! != '') {
          if (bCProductFeaturesUpdatedAt == null || bCProductFeaturesUpdatedAt != reponse.data!.bCProductFeaturesUpdatedAt!) {
            SpUtil.putString(Constant.bCProductFeaturesUpdatedAt, reponse.data!.bCProductFeaturesUpdatedAt!);
            SpUtil.putObjectList(Constant.bCProductFeatureList, reponse.data!.bCProductFeatures!);
          } else {
            //从缓存中补充
            List<Map>? bCProductFeatureList = SpUtil.getObjectList(Constant.bCProductFeatureList);
            if (bCProductFeatureList != null) {
              List<IndexDataBCProductFeatures> bCProductFeatureData = List<IndexDataBCProductFeatures>.from(bCProductFeatureList.map((value) {
                return $IndexDataBCProductFeaturesFromJson(value);
              }));
              reponse.data?.bCProductFeatures = bCProductFeatureData;
            }
          }
        }

        /// backTips
        if (reponse.data!.backTipsUpdatedAt != null && reponse.data!.backTipsUpdatedAt! != '') {
          if (backTipsUpdatedAt == null || backTipsUpdatedAt != reponse.data!.backTipsUpdatedAt!) {
            SpUtil.putString(Constant.backTipsUpdatedAt, reponse.data!.backTipsUpdatedAt!);
            SpUtil.putObjectList(Constant.backTipsList, reponse.data!.backTips!);
          } else {
            //从缓存中补充
            List<Map>? backTipsList = SpUtil.getObjectList(Constant.backTipsList);
            if (backTipsList != null) {
              List<IndexDataBackTips> backTipsData = List<IndexDataBackTips>.from(backTipsList.map((value) {
                return $IndexDataBackTipsFromJson(value);
              }));
              reponse.data?.backTips = backTipsData;
            }
          }
        }

        /// loginInfo
        if (reponse.data!.loginPageInfo != null ) {
            SpUtil.putObject(Constant.loginPageInfo, reponse.data!.loginPageInfo!);
        }

        String maxUpdatedAt = '';
        if (reponse.data!.dBorrowsNewestUpdatedAt != null && reponse.data!.dBorrowsNewestUpdatedAt!.compareTo(reponse.data!.bProductsNewestUpdatedAt!) > 0) {
          maxUpdatedAt = reponse.data!.dBorrowsNewestUpdatedAt!;
        } else {
          maxUpdatedAt = reponse.data!.bProductsNewestUpdatedAt!;
        }
        view.getContext().read<IndexNewProvider>().aUser = reponse.data!.aUser!;
        view.getContext().read<IndexNewProvider>().indexAction = reponse.data!.aUser!.iIndexAction!;
        view.getContext().read<IndexNewProvider>().itemModels = itemList;

        view.getContext().read<IndexNewProvider>().maxUpdatedAt = maxUpdatedAt;
        view.getContext().read<IndexNewProvider>().rFNotificationsNewestUpdatedAt = reponse.data!.rFNotificationsNewestUpdatedAt!;
        view.getContext().read<IndexNewProvider>().rFNotifications = reponse.data!.rFNotifications!;
        view.getContext().read<IndexNewProvider>().qDBannersNewestUpdatedAt = reponse.data!.qDBannersNewestUpdatedAt!;
        view.getContext().read<IndexNewProvider>().qDBanners = reponse.data!.qDBanners!;
        view.getContext().read<IndexNewProvider>().backTipsUpdatedAt = reponse.data!.backTipsUpdatedAt!;
        view.getContext().read<IndexNewProvider>().backTips = reponse.data!.backTips!;
        view.getContext().read<IndexNewProvider>().bCProductFeaturesUpdatedAt = reponse.data!.bCProductFeaturesUpdatedAt!;
        view.getContext().read<IndexNewProvider>().bCProductFeatures = reponse.data!.bCProductFeatures!;
        view.getContext().read<IndexNewProvider>().remind = reponse.data!.remind!;
        int currentTimeInSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        SpUtil.putInt(Constant.lastIndexFetchAt, currentTimeInSeconds);
        String? show = await Cache().checkCache('showPopupOverlay');
        if (show == null && reponse.data!.remind!.content!.isNotEmpty) {
          Cache().cacheData('showPopupOverlay', '1', 60);
          view.showPopupOverlay(reponse.data!.aUser!.iIndexAction!, reponse.data!.remind!);
        }
        view.getContext().read<UserProvider>().setIndexAction(reponse.data!.aUser!.iIndexAction!);
        view.scroll();
      }
    }, onError: (_, __) {
      /// 加载失败
    });
  }

  Future gVerifiesStore({bool isShowDialog = false}) {
    String lastFetchVerifyItemsTime = SpUtil.getString(Constant.lastFetchVerifyItemsTime, defValue: '')!;
    Map<String, dynamic>? params = {"last_fetch_time": lastFetchVerifyItemsTime};
    FormData formData = FormData.fromMap(params);
    return requestNetwork<GVerifiesShowEntity>(Method.post, url: HttpApi.gVerifiesStore, params: formData, isShow: isShowDialog, onSuccess: (data) {
      if (data != null) {
        GVerifyEntity gVerifyEntity = data.data!.gVerify!;
        int indexAction = data.data!.indexAction!;
        Helper.storeGVerifyEntity(gVerifyEntity: gVerifyEntity, view: view, qVerifyItems: data.data?.qVerifyItems, indexAction: indexAction);
        switch (IndexActionConst.named(indexAction)) {
          case IndexActionConst.verifyList:
            view.goVerifyList();
            // if (SpUtil.getBool(Constant.keySwipper, defValue: false)!) {
            //   view.goSwipper();
            // } else {
            //   view.goVerifyList();
            // }
            break;
          case IndexActionConst.reVerifyList:
            view.goVerifyList();
            break;
          default:
            //todo report
            print(2);
        }
      }
    }, onError: (_, __) {
      /// 加载失败
    });
  }
}

enum ActionRoute { create, verifyList, liveness, sign }

extension ActionExtension on ActionRoute {
  // String get value => ['/create', '/verifyList', '/liveness', '/sign'][index];
  String get value => [
        // BorrowRouter.createBorrow,
        // VerifyRouter.verifyList,
        // BorrowRouter.createBorrow,
        // BorrowRouter.createBorrow,
        VerifyRouter.swipper,
        VerifyRouter.swipper,
        VerifyRouter.swipper,
        '',
        '',
        '',
      ][index];
}
