import 'package:flutter/material.dart';
import 'package:myapp9/util/helper.dart';
import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';

import '../../../config/constant.dart';
import '../../../providers/locale_provider.dart';
import '../../../providers/theme_provider.dart';
import '../../../res/raw/gaps.dart';
import '../../../routers/fluro_navigator.dart';
import '../../../util/device_utils.dart';
import '../../../widgets/click_item.dart';
import '../../../widgets/my_app_bar.dart';
import '../../login/router/login_router.dart';
import '../widgets/exit_dialog.dart';
import '../widgets/update_dialog.dart';

/// design/8设置/index.html
class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: 'Setting',
      ),
      body: Consumer2<ThemeProvider, LocaleProvider>(
        builder: (_, ThemeProvider provider, LocaleProvider localeProvider, __) {
          return Column(
            children: <Widget>[
              Gaps.vGap5,
              // if (Helper.isLoggedIn())
              //   ClickItem(
              //   title: 'Change Password',
              //   onTap: () => NavigatorUtils.push(context, LoginRouter.updatePasswordPage),
              // ),
              if (Device.isMobile)
                ClickItem(
                  title: 'Clear Cache',
                  content: '23.5MB',
                  onTap: () {},
                ),
              // if (Device.isMobile)
              //   ClickItem(
              //     title: 'Check for Updates',
              //     onTap: _showUpdateDialog,
              //   ),
              Helper.isLoggedIn()
                  ? ClickItem(
                      title: 'Log Out',
                onTap: _showExitDialog,
                    )
                  : ClickItem(
                      title: 'Log In',
                      onTap: () {
                        NavigatorUtils.push(context, LoginRouter.loginPage, clearStack: false);
                      },
                    ),
            ],
          );
        },
      ),
    );
  }

  String _getCurrentTheme() {
    final String? theme = SpUtil.getString(Constant.theme);
    String themeMode;
    switch (theme) {
      case 'Dark':
        themeMode = '开启';
        break;
      case 'Light':
        themeMode = '关闭';
        break;
      default:
        themeMode = '跟随系统';
        break;
    }
    return themeMode;
  }


  void _showExitDialog() {
    showDialog<void>(context: context, builder: (_) => const ExitDialog());
  }

  void _showUpdateDialog() {
    showDialog<void>(context: context, barrierDismissible: false, builder: (_) => const UpdateDialog());
  }
}
