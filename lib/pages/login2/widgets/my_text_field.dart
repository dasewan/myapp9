import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/myapp9_localizations.dart';
import 'package:myapp9/res/resources.dart';
import 'package:myapp9/util/device_utils.dart';
import 'package:myapp9/widgets/load_image.dart';
import 'package:myapp9/widgets/my_button.dart';

/// 登录模块的输入框封装
class MyTextField extends StatefulWidget {
  const MyTextField(
      {Key? key,
      required this.controller,
      this.maxLength = 16,
      this.autoFocus = false,
      this.keyboardType = TextInputType.text,
      this.hintText = '',
      this.labelText = '',
      this.prefixIcon,
      this.focusNode,
      this.isInputPwd = false,
      this.getVCode,
      this.getCaptcha,
      this.image,
      this.keyName})
      : super(key: key);

  final TextEditingController controller;
  final int maxLength;
  final bool autoFocus;
  final TextInputType keyboardType;
  final String hintText;
  final Widget? prefixIcon;
  final String labelText;
  final FocusNode? focusNode;
  final bool isInputPwd;
  final Future<bool> Function()? getVCode;
  final Future<bool> Function()? getCaptcha;
  final Image? image;

  /// 用于集成测试寻找widget
  final String? keyName;

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _isShowPwd = false;
  bool _isShowDelete = false;
  bool _clickable = true;

  /// 倒计时秒数
  final int _second = 60;

  /// 当前秒数
  late int _currentSecond;
  StreamSubscription? _subscription;

  @override
  void initState() {
    /// 获取初始化值
    _isShowDelete = widget.controller.text.isNotEmpty;

    /// 监听输入改变
    widget.controller.addListener(isEmpty);
    super.initState();
  }

  void isEmpty() {
    final bool isNotEmpty = widget.controller.text.isNotEmpty;

    /// 状态不一样在刷新，避免重复不必要的setState
    if (isNotEmpty != _isShowDelete) {
      setState(() {
        _isShowDelete = isNotEmpty;
      });
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    widget.controller.removeListener(isEmpty);
    super.dispose();
  }

  Future _getVCode() async {
    final bool isSuccess = await widget.getVCode!();
    if (isSuccess) {
      setState(() {
        _currentSecond = _second;
        _clickable = false;
      });
      _subscription = Stream.periodic(const Duration(seconds: 1), (int i) => i).take(_second).listen((int i) {
        setState(() {
          _currentSecond = _second - i - 1;
          _clickable = _currentSecond < 1;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final bool isDark = themeData.brightness == Brightness.dark;

    Widget textField = TextField(
      focusNode: widget.focusNode,
      maxLength: widget.maxLength,
      obscureText: widget.isInputPwd && !_isShowPwd,
      autofocus: widget.autoFocus,
      controller: widget.controller,
      textInputAction: TextInputAction.done,
      keyboardType: widget.keyboardType,
      // 数字、手机号限制格式为0到9， 密码限制不包含汉字
      inputFormatters: (widget.keyboardType == TextInputType.number || widget.keyboardType == TextInputType.phone)
          ? [FilteringTextInputFormatter.allow(RegExp('[0-9]'))]
          : [FilteringTextInputFormatter.deny(RegExp('[\u4e00-\u9fa5]'))],
      style: TextStyle(
        fontSize: 18.0, // 设置输入文本的字体大小
      ),
      decoration: InputDecoration(
        // contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
        labelText: widget.labelText != '' ? widget.labelText : null ,
        hintText: widget.hintText != '' ? widget.hintText : null ,
        counterText: '',
        prefixIcon:widget.prefixIcon,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0.8,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0.8,
          ),
        ),
      ),
    );

    /// 个别Android机型（华为、vivo）的密码安全键盘不弹出问题（已知小米正常），临时修复方法：https://github.com/flutter/flutter/issues/68571 (issues/61446)
    /// 怀疑是安全键盘与三方输入法之间的切换冲突问题。
    if (Device.isAndroid) {
      textField = Listener(
        onPointerDown: (e) => FocusScope.of(context).requestFocus(widget.focusNode),
        child: textField,
      );
    }

    Widget? clearButton;

    if (_isShowDelete) {
      clearButton = Semantics(
        label: '清空',
        hint: '清空输入框',
        child: GestureDetector(
          child: LoadAssetImage(
            'login/qyg_shop_icon_delete',
            key: Key('${widget.keyName}_delete'),
            width: 18.0,
            height: 40.0,
          ),
          onTap: () => widget.controller.text = '',
        ),
      );
    }

    late Widget pwdVisible;
    if (widget.isInputPwd) {
      pwdVisible = Semantics(
        label: '密码可见开关',
        hint: '密码是否可见',
        child: GestureDetector(
          child: LoadAssetImage(
            _isShowPwd ? 'login/qyg_shop_icon_display' : 'login/qyg_shop_icon_hide',
            key: Key('${widget.keyName}_showPwd'),
            width: 18.0,
            height: 40.0,
          ),
          onTap: () {
            setState(() {
              _isShowPwd = !_isShowPwd;
            });
          },
        ),
      );
    }

    late Widget getVCodeButton;
    if (widget.getVCode != null) {
      getVCodeButton = MyButton(
        key: const Key('getVerificationCode'),
        onPressed: _clickable ? _getVCode : null,
        fontSize: Dimens.font_sp12,
        text: _clickable ? Myapp9Localizations.of(context)!.getVerificationCode : '（$_currentSecond s）',
        textColor: themeData.primaryColor,
        disabledTextColor: isDark ? Colours.dark_text : Colors.white,
        backgroundColor: Colors.transparent,
        disabledBackgroundColor: isDark ? Colours.dark_text_gray : Colours.text_gray_c,
        radius: 1.0,
        minHeight: 26.0,
        minWidth: 76.0,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        side: BorderSide(
          color: _clickable ? themeData.primaryColor : Colors.transparent,
          width: 0.8,
        ),
      );
    }
    late Widget getCaptchaImage;
    if (widget.getCaptcha != null) {
      getCaptchaImage = GestureDetector(
        onTap: () async {
          await widget.getCaptcha!();
        },
        child: widget.image,
      );
    }

    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        textField,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            /// _isShowDelete参数动态变化，为了不破坏树结构使用Visibility，false时放一个空Widget。
            /// 对于其他参数，为初始配置参数，基本可以确定树结构，就不做空Widget处理。
            Visibility(
              visible: _isShowDelete,
              child: clearButton ?? Gaps.empty,
            ),
            if (widget.isInputPwd) Gaps.hGap15,
            if (widget.isInputPwd) pwdVisible,
            if (widget.getVCode != null) Gaps.hGap15,
            if (widget.getVCode != null) getVCodeButton,
            if (widget.image != null) Gaps.hGap15,
            if (widget.image != null) getCaptchaImage,
          ],
        )
      ],
    );
  }
}