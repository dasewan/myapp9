import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp9/config/constant.dart';
import 'package:myapp9/mvp/base_page.dart';
import 'package:myapp9/pages/index/presenters/index_new_page_presenter.dart';
import 'package:myapp9/pages/index/widgets/product_new_widget.dart';
import 'package:myapp9/pages/index/widgets/repay_dialog.dart';
import 'package:myapp9/pages/index/widgets/text_scroll.dart';
import 'package:myapp9/pages/repay/router/repay_router.dart';
import 'package:myapp9/pages/sign/router/sign_router.dart';
import 'package:myapp9/res/raw/gaps.dart';
import 'package:myapp9/util/helper.dart';
import 'package:myapp9/util/other_utils.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sp_util/sp_util.dart';

import '../../models/index_entity.dart';
import '../../providers/index_new_provider.dart';
import '../../routers/fluro_navigator.dart';
import '../../util/toast_utils.dart';
import '../login/router/login_router.dart';
import '../verify/fitness_app_theme.dart';
import '../verify/router/verify_router.dart';
import 'iviews/index_new_i_mvp_view.dart';

class IndexNewPage extends StatefulWidget {
  const IndexNewPage({Key? key}) : super(key: key);

  @override
  _IndexNewPageState createState() => _IndexNewPageState();
}

class _IndexNewPageState extends State<IndexNewPage> with BasePageMixin<IndexNewPage, IndexNewPagePresenter> implements IndexNewIMvpView {
  late IndexNewPagePresenter _indexNewPagePresenter;
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  bool _showTitle = false;

  int scrollingTextIndex = 0;
  List<String> news = [
    // '1. Your repayment date is 2024-01-05, which is already 3 days overdue. Please make repayment. ',
    '1. Please use the app to repay, or choose the repayment page to repay. Please do not transfer money to strangers.',
    '2. Maintaining good repayment behavior can increase your limit and more loanable products.',
    // '4. Maintaining good repayment behavior can increase your limit and more loanable products.',
    // '5. Maintaining good repayment behavior can increase your limit and more loanable products.',
  ];

  Map<String, IconData> notificationIcon = {
    'access_alarms': Icons.access_alarms,
    'account_balance_wallet_outlined': Icons.account_balance_wallet_outlined,
    'add_moderator_outlined': Icons.add_moderator_outlined,
    'assignment_late_outlined': Icons.assignment_late_outlined,
    'do_disturb': Icons.do_disturb,
    'event_available_outlined': Icons.event_available_outlined,
    'gavel_rounded': Icons.gavel_rounded,
    'gpp_good_outlined': Icons.gpp_good_outlined,
    'group_off_outlined': Icons.group_off_outlined,
    'https_outlined': Icons.https_outlined,
    'info_outlined': Icons.info_outlined,
    'lightbulb_outline_rounded': Icons.lightbulb_outline_rounded,
    'not_listed_location_outlined': Icons.not_listed_location_outlined,
    'notifications_active_outlined': Icons.notifications_active_outlined,
    'phone_callback_outlined': Icons.phone_callback_outlined,
    'phone_in_talk_rounded': Icons.phone_in_talk_rounded,
    'portrait_outlined': Icons.portrait_outlined,
    'privacy_tip_outlined': Icons.privacy_tip_outlined,
    'report_outlined': Icons.report_outlined,
    'sentiment_very_dissatisfied_outlined': Icons.sentiment_very_dissatisfied_outlined,
    'share_outlined': Icons.share_outlined,
    'swap_horizontal_circle_outlined': Icons.swap_horizontal_circle_outlined,
    'task_alt_sharp': Icons.task_alt_sharp,
    'thumb_up_off_alt': Icons.thumb_up_off_alt,
    'thumb_down_off_alt': Icons.thumb_down_off_alt,
    'verified_user_outlined': Icons.verified_user_outlined,
    'warning_amber_rounded': Icons.warning_amber_rounded,
  };
  List<Color> notificationColor = [Colors.green, Colors.purple, Colors.amber, Colors.red];
  List<CarouselItem> itemList = [
    CarouselItem(
      image: Image.asset('assets/images/index/banner1.png', fit: BoxFit.fill).image,
      // image:LoadAssetImage('assets/images/index/banner1.png',),

      boxDecoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          colors: [
            Colors.blueAccent.withOpacity(1),
            Colors.black.withOpacity(.3),
          ],
          stops: const [0.0, 1.0],
        ),
      ),
      title: 'Push your creativity to its limits by reimagining this classic puzzle!',
      titleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      leftSubtitle: '\$51,046 in prizes',
      rightSubtitle: '4882 participants',
      rightSubtitleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.black,
      ),
      onImageTap: (i) {
        Toast.show('image1');
      },
    ),
    CarouselItem(
      image: Image.asset('assets/images/index/banner2.png', fit: BoxFit.fill).image,
      title: '@coskuncay published flutter_custom_carousel_slider!',
      titleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      leftSubtitle: '11 Feb 2022',
      rightSubtitle: 'v1.0.0',
      onImageTap: (i) {
        Toast.show('image2');
      },
    ),
    CarouselItem(
      image: Image.asset('assets/images/index/banner3.png', fit: BoxFit.fill).image,
      title: '@coskuncay published flutter_custom_carousel_slider!',
      titleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      leftSubtitle: '11 Feb 2022',
      rightSubtitle: 'v1.0.0',
      onImageTap: (i) {
        Toast.show('image3');
      },
    ),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > kToolbarHeight && !_showTitle) {
        setState(() {
          _showTitle = true;
        });
      } else if (_scrollController.offset <= kToolbarHeight && _showTitle) {
        setState(() {
          _showTitle = false;
        });
      }
    });

    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   _indexNewPagePresenter.index(false);
    // });
  }

/*  @override
  // TODO: implement provider
  // IndexNewProvider get provider => IndexNewProvider();
  IndexNewProvider provider = IndexNewProvider();*/

  @override
  IndexNewPagePresenter createPresenter() {
    _indexNewPagePresenter = IndexNewPagePresenter();
    return _indexNewPagePresenter;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollController2.dispose();

    super.dispose();
  }

  @override
  void showPopupOverlay(int indexAction, IndexDataRemind remind) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => RepayDialog(indexAction: indexAction, remind: remind, onPressed: (id) => print(id)),
    );
  }

  void _next(int productId, int indexAction, int borrowId, int borrowStatus) {
    print('repay');
    NavigatorUtils.push(context, '${RepayRouter.repay}?borrowId=$borrowId');
  }

  void _goLogin() {
    NavigatorUtils.push(context, LoginRouter.loginPage);
  }

  @override
  void goSwipper() {
    NavigatorUtils.push(context, VerifyRouter.swipper);
  }

  @override
  void createVerify() {
    _indexNewPagePresenter.gVerifiesStore(isShowDialog: true);
  }

  @override
  void goVerifyList() {
    if (SpUtil.getBool(Constant.keySwipper, defValue: true)!) {
      goSwipper();
    } else {
      NavigatorUtils.push(context, VerifyRouter.verifyList);
    }
  }

  @override
  void goLiveness() {
    NavigatorUtils.push(context, LoginRouter.loginPage);
  }

  @override
  void goSign(int productId) {
    NavigatorUtils.push(context, '${SignRouter.sign}?productId=$productId');
  }

  @override
  void goRepay(int productId) {
    NavigatorUtils.push(context, '${RepayRouter.repay}?productId=$productId');
  }

  /// 滑动一屏的方法
  void _scrollOnePage() {
    // 获取当前滚动位置
    double currentScrollPosition = _scrollController2.position.pixels;
    // 获取最大滚动距离
    double maxScrollExtent = _scrollController2.position.maxScrollExtent;
    // 获取屏幕的高度（viewport 的高度）
    double viewportHeight = _scrollController2.position.viewportDimension;

    // 判断是否到底部
    if (currentScrollPosition >= maxScrollExtent) {
      // 如果到底部，向上滑动一屏
      _scrollController2.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // 如果未到底部，向下滑动一屏
      double targetScrollPosition = currentScrollPosition + viewportHeight;
      _scrollController2.animateTo(
        targetScrollPosition > maxScrollExtent ? maxScrollExtent : targetScrollPosition,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  final Widget front = AspectRatio(
    aspectRatio: 1.48,
    child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0.0),
        padding: const EdgeInsets.all(1.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Gaps.vGap12,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Gaps.hGap8,
                ClipOval(
                  child: Image.asset(
                    'assets/images/placeholder1.png',
                    width: 60,
                    height: 60,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Gaps.hGap10,
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "waiting",
                        style: TextStyle(color: Colors.black, fontSize: 36),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Gaps.vGap12,
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Gaps.hGap8,
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(50),
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.6, color: Colors.white),
                        borderRadius: BorderRadius.circular(6.0),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/repay.png'), // 替换为你的背景图路径
                          fit: BoxFit.fitWidth, // 调整图片适应容器大小
                          opacity: 0.7,
                          // repeat: ImageRepeat.repeat,
                        ),
                      ),
                      child: Gaps.empty,
                    ),
                  ),
                  Gaps.hGap8,
                ],
              ),
            ),
            Gaps.vGap12,
          ],
        )),
  );

  List<Widget> _sliverBuilder(BuildContext context, innerBoxIsScrolled) {
    return <Widget>[
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        sliver: SliverAppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: Colors.indigoAccent[700],
          elevation: 0.0,
          centerTitle: true,
          expandedHeight: 180.0,
          // 不随着滑动隐藏标题
          pinned: true,
          forceElevated: true,
          // 固定在顶部
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
                decoration: const BoxDecoration(
                  // color: Colors.blueAccent,
                  gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF0000FF), Color(0xFFFFFFFF)]),
                ),
                child: Selector<IndexNewProvider, String>(selector: (_, provider) {
                  return provider.qDBannersNewestUpdatedAt;
                }, shouldRebuild: (previous, next) {
                  return previous != next;
                }, builder: (_, qDBannersNewestUpdatedAt, __) {
                  return qDBannersNewestUpdatedAt == ''
                      ? Image.asset('assets/images/loading.webp', fit: BoxFit.fill)
                      : CustomCarouselSlider(
                          items: Provider.of<IndexNewProvider>(context).qDBanners.map((banner) {
                            return CarouselItem(
                              image: CachedNetworkImageProvider("${banner.bPic}"),
                              onImageTap: (i) {
                                // Toast.show('image2');
                                Helper.launchWebURL(banner.aTitle!, banner.eUrl!, banner!.gType!, context);
                              },
                            );
                          }).toList(),
                          height: 160,
                          subHeight: 50,
                          width: MediaQuery.of(context).size.width,
                          autoplay: true,
                          showSubBackground: false,
                          showText: false,
                        );
                })),
            centerTitle: true,
            titlePadding: const EdgeInsetsDirectional.only(start: 16.0, bottom: 14.0),
            collapseMode: CollapseMode.pin,
            title: _showTitle
                ? const Text(
                    "Best Loan Market",
                    style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600),
                  )
                : null,
          ),
        ),
      ),
      SliverPersistentHeader(
        pinned: true,
        floating: false,
        delegate: SliverAppBarDelegate(
          DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: FitnessAppTheme.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0), bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: FitnessAppTheme.grey.withOpacity(0.4), offset: const Offset(1.1, 1.1), blurRadius: 10.0),
                  ],
                ),
                child: Selector<IndexNewProvider, String>(selector: (_, provider) {
                  return provider.rFNotificationsNewestUpdatedAt;
                }, shouldRebuild: (previous, next) {
                  return previous != next;
                }, builder: (_, notifications, __) {
                  return CarouselSlider(
                    options: CarouselOptions(
                        height: 180.0,
                        enlargeCenterPage: false,
                        viewportFraction: 1.1,
                        autoPlay: true,
                        scrollDirection: Axis.vertical,
                        autoPlayInterval: const Duration(seconds: 6),
                        autoPlayAnimationDuration: const Duration(milliseconds: 200)),
                    items: Provider.of<IndexNewProvider>(context).rFNotifications.map((notification) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Row(
                            children: [
                              Gaps.hGap4,
                              Icon(
                                notificationIcon[notification.aIcon],
                                color: notificationColor[notification.bColor!],
                              ),
                              Gaps.hGap4,
                              // Container(child: Text("123")),
                              Expanded(
                                  child: TextScroll2(
                                notification.cContent!,
                                velocity: const Velocity(pixelsPerSecond: Offset(150, 0)),
                                delayBefore: const Duration(seconds: 2),
                                numberOfReps: 2,
                                pauseBetween: const Duration(seconds: 1),
                                style: TextStyle(color: notificationColor[notification.bColor!]),
                                textAlign: TextAlign.right,
                                selectable: true,
                              )),
                            ],
                          );
                        },
                      );
                    }).toList(),
                  );
                }),
              )),
          30.0,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.grey[300],
      child: Stack(
        children: <Widget>[
          NestedScrollView(
            key: const Key('order_list'),
            physics: const ClampingScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) => _sliverBuilder(context, innerBoxIsScrolled),
            controller: _scrollController,
            body: Builder(builder: (context) {
              return CustomScrollView(
                key: const PageStorageKey<String>("hello2"),
                controller: _scrollController2,
                slivers: <Widget>[
                  SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
                  Selector<IndexNewProvider, String>(
                      selector: (_, provider) {
                        return provider.maxUpdatedAt;
                      },
                      /// 精准判断刷新条件（provider 4.0新属性）
                      shouldRebuild: (previous, next) => previous != next,
                      builder: (_, maxUpdatedAt, __) {
                        if (Provider.of<IndexNewProvider>(context).itemModels.isNotEmpty) {
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (content, index) {
                                // return ListTile(title: Text("$index"));
                                IndexDataBProducts bProduct = Provider.of<IndexNewProvider>(context).itemModels[index].bProduct;
                                IndexDataDBorrows? dBorrow = Provider.of<IndexNewProvider>(context).itemModels[index].dBorrow;
                                List<IndexDataBCProductFeatures> bCProductFeatures = Provider.of<IndexNewProvider>(context).bCProductFeatures;
                                List<IndexDataBackTips> backTips = Provider.of<IndexNewProvider>(context).backTips;
                                bProduct.cAmount = bProduct.cAmount! > 0 ? bProduct.cAmount : Provider.of<IndexNewProvider>(context).aUser.fCreditAmount!;

                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
                                  child: ProductNewWidget(
                                    key: Key(bProduct.id.toString()),
                                    bProduct: bProduct,
                                    dBorrow: dBorrow,
                                    backTips: backTips,
                                    features: bCProductFeatures,
                                    onPressed: (productId, action) {
                                      final String accessToken = SpUtil.getString(Constant.accessToken).nullSafe;
                                      if (accessToken.isNotEmpty) {
                                        switch (action) {
                                          case 'create_verify':
                                            createVerify();
                                          case 'verify_list':
                                            goVerifyList();
                                          case 'liveness':
                                            goLiveness();
                                          case 'sign':
                                            goSign(productId);
                                          case 'repay':
                                            goRepay(productId);
                                        }
                                      } else {
                                        _goLogin();
                                      }
                                      // _next(id, indexAction, borrowId, borrowStatus);
                                    },
                                  ),
                                );
                              },
                              childCount: Provider.of<IndexNewProvider>(context).itemModels.length,
                            ),
                          );
                        } else {
                          return SliverToBoxAdapter(
                              child: Skeletonizer(
                            enabled: true,
                            // containersColor: Colors.grey,
                            child: SizedBox(
                              height: 1000,
                              child: ListView.separated(
                                itemCount: 6,
                                padding: const EdgeInsets.all(9),
                                separatorBuilder: (BuildContext context, int index) {
                                  return const SizedBox(height: 10); // 用SizedBox来定义间距
                                },
                                itemBuilder: (context, index) {
                                  return front;
                                },
                              ),
                            ),
                          ));
                        }
                      }),
                ],
              );
            }),
          ),
        ],
      ),
    ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white70,
        onPressed: _scrollOnePage,
        child: Lottie.asset(
          'assets/lottie/scroll.json',
          animate: true,
          repeat: true,
          reverse: false,
          // fit: BoxFit.contain,
        ),
      ),

    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate(this.widget, this.height);

  final Widget widget;
  final double height;

  // minHeight 和 maxHeight 的值设置为相同时，header就不会收缩了
  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

/*  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }*/
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return true;
  }
}
