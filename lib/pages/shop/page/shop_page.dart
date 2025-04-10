import 'package:flutter/material.dart';
import 'package:myapp9/pages/html/router/html_router.dart';
import 'package:myapp9/providers/center_provider.dart';
import 'package:myapp9/util/helper.dart';
import 'package:provider/provider.dart';

import '../../../mvp/base_page.dart';
import '../../../res/raw/dimens.dart';
import '../../../res/raw/gaps.dart';
import '../../../res/raw/styles.dart';
import '../../../routers/fluro_navigator.dart';
import '../../../util/device_utils.dart';
import '../../../util/other_utils.dart';
import '../../../util/theme_utils.dart';
import '../../../widgets/load_image.dart';
import '../../login/router/login_router.dart';
import '../../setting/router/setting_router.dart';
import '../iview/shop_iview.dart';
import '../presenter/shop_presenter.dart';
import '../router/shop_router.dart';
import '../widgets/level_bar.dart';

/// design/6店铺-账户/index.html#artboard0
class ShopPage extends StatefulWidget {
  const ShopPage({
    super.key,
    this.isAccessibilityTest = false,
  });

  final bool isAccessibilityTest;

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> with BasePageMixin<ShopPage, ShopPagePresenter>, AutomaticKeepAliveClientMixin<ShopPage> implements ShopIMvpView {
  // final List<String> _menuTitle = ['All Applications', 'Repayment', 'Credit Score', 'Invite History'];
  final List<String> _menuTitle = ['All Applications', 'Repayment', 'Credit Score'];
  final List<String> _menuImage = ['zhls', 'zjgl', 'credit_score', 'invite'];
  final List<double> _menuImageWidth = [34.0, 34.0, 28.0, 26.0];
  final List<String> _menuDarkImage = ['dark_zhls', 'dark_zjgl', 'dark_txzh', 'dark_txzh'];
  late ShopPagePresenter _shopPagePresenter;

  @override
  bool get wantKeepAlive => false;

  @override
  void initState() {
    super.initState();
  }

  @override
  // TODO: implement provider
  CenterProvider provider = CenterProvider();

  @override
  ShopPagePresenter createPresenter() {
    _shopPagePresenter = ShopPagePresenter();
    return _shopPagePresenter;
  }

  void _launchWebURL(String title, String url) {
    if (Device.isMobile) {
      NavigatorUtils.goWebViewPage(context, title, url);
    } else {
      Utils.launchWebURL(url);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Color? iconColor = ThemeUtils.getIconColor(context);
    final Widget line = Container(
      height: 0.6,
      width: double.infinity,
      margin: const EdgeInsets.only(left: 16.0),
      child: Gaps.line,
    );
    final TextStyle? textTextStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: Dimens.font_sp12);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigoAccent, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: kToolbarHeight),
            child: ChangeNotifierProvider<CenterProvider>(
              create: (_) => provider,
              child: Consumer<CenterProvider>(builder: (_, provider, __) {
                return SingleChildScrollView(
                  child: Container(
                    height: 720,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Stack(
                            children: <Widget>[
                              const SizedBox(width: double.infinity, height: 48.0),
                              Text(
                                provider.centerData.bName!,
                                style: TextStyles.textBold18,
                              ),
                              Positioned(
                                top: 28.0,
                                left: 0.0,
                                child: Text('phone: ${provider.centerData.aPhone}', style: TextStyles.textSize12),
                              ),
                            ],
                          ),
                        ),
                        Gaps.vGap8,
                        Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          letterSpacing: -0.2,
                                          color: Color(0xFF253840),
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(text: provider.centerData.gCreditFraction!.toString()),
                                          TextSpan(text: ' Grade ${provider.centerData.currentLevel}', style: Theme.of(context).textTheme.titleSmall),
                                        ],
                                      ),
                                    ),
                                    // Gaps.line,
                                    Padding(
                                      padding: EdgeInsets.only(top: 6),
                                      child: Text(
                                        'My Current Credit Grade',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Gaps.vLine,
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          letterSpacing: -0.2,
                                          color: Color(0xFF253840),
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(text: Utils.formatPrice2(provider.centerData.fCreditAmount!)),
                                          TextSpan(text: ' next ${Utils.formatPrice2(provider.centerData.nextAmount!)}', style: Theme.of(context).textTheme.titleSmall),
                                        ],
                                      ),
                                    ),
                                    // Gaps.line,
                                    Padding(
                                      padding: EdgeInsets.only(top: 6),
                                      child: Text(
                                        'My Current Credit Limit',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _launchWebURL('Increase Credit Limit', provider.centerData.creditUrl!);
                          },
                          child: Container(
                              padding: const EdgeInsets.only(left: 4, right: 4),
                              child: LevelBar(
                                amountProgress: provider.centerData.amountProgress!,
                                levelProgress: provider.centerData.levelProgress!,
                                points: provider.centerData.point!,
                                tips: provider.centerData.processTip!,
                                progress: double.parse((provider.centerData.gCreditFraction!/1000).toStringAsFixed(2)),
                              )),
                        ),
                        Gaps.vGap10,
                        line,
                        Gaps.vGap5,
                        const MergeSemantics(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'My Service',
                              style: TextStyles.textBold14,
                            ),
                          ),
                        ),
                        _ShopFunctionModule(
                          data: _menuTitle,
                          image: _menuImage,
                          imageWidth: _menuImageWidth,
                          darkImage: _menuDarkImage,
                          onItemClick: (index) {
                            if (Helper.isLoggedIn()) {
                              if (index == 0) {
                                NavigatorUtils.push(context, ShopRouter.orderPage);
                              } else if (index == 1) {
                                NavigatorUtils.push(context, ShopRouter.accountRecordListPage);
                              } else if (index == 2) {
                                NavigatorUtils.push(context, ShopRouter.creditRecordListPage);
                              } else if (index == 3) {
                                NavigatorUtils.push(context, ShopRouter.creditRecordListPage);
                              }
                            } else {
                              NavigatorUtils.push(context, LoginRouter.loginPage, clearStack: false);
                            }
                          },
                        ),
                        line,
                        Gaps.vGap5,
                        const MergeSemantics(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'More Service',
                              style: TextStyles.textBold14,
                            ),
                          ),
                        ),

                        /// 使用Flexible防止溢出
                        Flexible(
                          child: _ShopFunctionModule(
                            data: const ['Increase Amount', 'Help Center', 'About Us', 'Privacy Policy'],
                            image: const ['increase_money', 'help_center', 'about_us', 'privacy'],
                            imageWidth: const [30.0, 27.0, 26.0, 25.0],
                            darkImage: const ['dark_dpsz', 'dark_dpsz', 'dark_dpsz'],
                            onItemClick: (index) {
                              if (index == 0) {
                                _launchWebURL('Increase Amount', 'https://api.dasewan.cn/credit.html');
                                // NavigatorUtils.push(context, HtmlRouter.creditScorePage);
                              } else if (index == 1) {
                                _launchWebURL('Help Center', 'https://api.dasewan.cn/help.html');
                                // NavigatorUtils.push(context, HtmlRouter.helpPage);
                              } else if (index == 2)  {
                                _launchWebURL('About Us', 'https://api.dasewan.cn/about.html');
                                // NavigatorUtils.push(context, HtmlRouter.aboutUsPage);
                              }else{
                                _launchWebURL('Privacy Policy', 'https://api.dasewan.cn/privacy.html');
                              }
                            },
                          ),
                        ),
                        // Gaps.vGap4,
                        // LoadAssetImage('shop/share4'),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: <Widget>[
                Stack(
                  fit: StackFit.passthrough,
                  children: [
                    IconButton(
                      tooltip: 'contact',
                      onPressed: () {
                        Utils.launchWebURL(provider.centerData.whatsapp!);
                        // NavigatorUtils.push(context, SettingRouter.settingPage);
                      },
                      icon: LoadAssetImage(
                        'shop/contact2',
                        key: const Key('contact'),
                        width: 22.0,
                        height: 22.0,
                        color: iconColor,
                      ),
                    ),
                    Positioned(
                      right: 6,
                      top: 6,
                      child: provider.centerData.aOServiceCount != null && (provider.centerData.aOServiceCount!) > 0
                          ? Container(
                              width: 16,
                              height: 16,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.redAccent,
                              ),
                              child: Center(
                                  child: Text(
                                provider.centerData.aOServiceCount.toString(),
                                style: const TextStyle(fontSize: 10),
                              )),
                            )
                          : const Center(),
                    )
                  ],
                ),
                //todo 消息
                /*Stack(
                  fit: StackFit.passthrough,
                  children: [
                    IconButton(
                      tooltip: 'message',
                      onPressed: () {
                        NavigatorUtils.push(context, ShopRouter.messagePage);
                      },
                      icon: LoadAssetImage(
                        'shop/message',
                        key: const Key('message'),
                        width: 24.0,
                        height: 24.0,
                        color: iconColor,
                      ),
                    ),
                    Positioned(
                      right: 6,
                      top: 6,
                      child: provider.centerData.aEMessage != null && (provider.centerData.aEMessage!) > 0
                          ? Container(
                              width: 16,
                              height: 16,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.redAccent,
                              ),
                              child: Center(
                                  child: Text(
                                provider.centerData.aEMessage.toString(),
                                style: const TextStyle(fontSize: 10),
                              )),
                            )
                          : const Center(),
                    )
                  ],
                ),*/
                IconButton(
                  tooltip: 'setting',
                  onPressed: () {
                    NavigatorUtils.push(context, SettingRouter.settingPage);
                  },
                  icon: LoadAssetImage(
                    'shop/setting',
                    key: const Key('setting'),
                    width: 24.0,
                    height: 24.0,
                    color: iconColor,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ShopFunctionModule extends StatelessWidget {
  const _ShopFunctionModule({
    required this.onItemClick,
    required this.data,
    required this.image,
    required this.imageWidth,
    required this.darkImage,
  });

  final Function(int index) onItemClick;
  final List<String> data;
  final List<String> image;
  final List<double> imageWidth;
  final List<String> darkImage;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: data.length,
        childAspectRatio: 1.18,
      ),
      itemCount: data.length,
      itemBuilder: (_, index) {
        return InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LoadAssetImage('shop/${image[index]}', width: imageWidth[index]),
              Gaps.vGap4,
              Text(
                data[index],
                style: TextStyles.textSize12,
              )
            ],
          ),
          onTap: () {
            onItemClick(index);
          },
        );
      },
    );
  }
}
