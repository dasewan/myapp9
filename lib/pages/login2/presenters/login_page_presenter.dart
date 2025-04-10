import 'package:dio/dio.dart';
import 'package:flustars_flutter3/flustars_flutter3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/myapp9_localizations.dart';
import 'package:myapp9/config/constant.dart';
import 'package:myapp9/generated/captcha_entity.dart';
import 'package:myapp9/models/authorizations_store_entity.dart';
import 'package:myapp9/models/index_entity.dart';
import 'package:myapp9/mvp/base_page_presenter.dart';
import 'package:myapp9/net/dio_utils.dart';
import 'package:myapp9/net/http_api.dart';
import 'package:myapp9/pages/login2/iviews/login_i_mvp_view.dart';
import 'package:provider/provider.dart';

import '../../../config/app.dart';
import '../../../generated/verification_code_entity.dart';
import '../../../providers/user_provider.dart';
import '../../../util/helper.dart';
import '../../../util/my_permission.dart';

class LoginPagePresenter extends BasePagePresenter<LoginIMvpView> {
  late Map<String, dynamic> deviceDynamicInfo;
  late Map<String, dynamic> deviceStaticInfo;
  late Map<String, dynamic> deviceInfo;
  late IndexDataLoginPageInfo loginPageInfo;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loginPageInfo = SpUtil.getObj(Constant.loginPageInfo,(v) => IndexDataLoginPageInfo.fromJson(v as Map<String, dynamic>))!;
      view.setLoginPageInfo(loginPageInfo);
/*      await MyPermission().myGeolocator(view: view);

      deviceDynamicInfo = await Helper.getDeviceInfo(view, fetchDynamic: true, fetchStatic: false);
      deviceStaticInfo = await Helper.getDeviceInfo(view, fetchDynamic: false, fetchStatic: true);*/
    });
  }

  void login(String phone, String verificationKey, String verificationCode, bool isShowDialog) async {
    // Map<String, dynamic> allDeviceInfo = await Device().getAllDeviceInfo();
    // Map<String, dynamic> dynamicInfo = await Device().getDeviceDynamicInfo('1');
/*    bool permission = await MyPermission().myGeolocator(view: view);
    if (!permission) {
      return;
    }*/
/*    deviceDynamicInfo = await Helper.getDeviceInfo(view,fetchDynamic: true, fetchStatic: false);
    deviceStaticInfo = await Helper.getDeviceInfo(view,fetchDynamic: false, fetchStatic: true);*/
    verificationKey = SpUtil.getString(Constant.verificationKey, defValue: '')!;
    Map<String, dynamic> loginInfo = {
      "a_phone": phone,
      "verification_key": verificationKey,
      "verification_code": verificationCode,
      "username": phone,
      "password": phone,
      "grant_type": App.grantType,
      "client_id": App.clientId,
      "client_secret": App.clientSecret,
      "scope": App.scope,
      "channel_id": App.channelId,
      "app_version": App.appVersion,
      "allPhones": phone,
    };
    List<String> allPhones = SpUtil.getStringList(Constant.allPhones) ?? [];
    List<String> allPhonesTmp = List<String>.from(allPhones);
    if (!allPhonesTmp.contains(phone)) {
      allPhonesTmp.add(phone);
      SpUtil.putStringList(Constant.allPhones, allPhonesTmp);
    }
    loginInfo['allPhones'] = allPhonesTmp.join(',');

    // loginInfo.addAll({...deviceStaticInfo, ...deviceDynamicInfo});
    FormData formData = FormData.fromMap(loginInfo);
    requestNetwork<AuthorizationsStoreEntity>(Method.post, url: HttpApi.authorizations, params: formData, onSuccess: (data) async {
      // Map<String, dynamic> allDeviceInfo = {};
      // Map<String, dynamic> dynamicInfo = {};
      if (data != null) {
        int lastFetchAt = SpUtil.getInt(Constant.lastDeviceInfoFetchAt, defValue: 0)!;
        // allDeviceInfo = SpUtil.getObject(Constant.allDeviceInfo) as Map<String, dynamic> ?? {};
        // dynamicInfo = SpUtil.getObject(Constant.dynamicInfo) as Map<String, dynamic> ?? {};

        SpUtil.clear();
        SpUtil.putInt(Constant.lastDeviceInfoFetchAt, lastFetchAt);
        // SpUtil.putObject(Constant.allDeviceInfo, allDeviceInfo);
        // SpUtil.putObject(Constant.dynamicInfo, dynamicInfo);
        SpUtil.putString(Constant.accessToken, data.passport!.accessToken!);
        SpUtil.putString(Constant.refreshToken, data.passport!.refreshToken!);
        SpUtil.putString(Constant.phone, data.data!.aPhone!);
        SpUtil.putStringList(Constant.allPhones, allPhonesTmp);
        Helper.cacheProfile(data.profile!);
        //todo 如果登出需要清除数据
        SpUtil.putInt(Constant.deviceId, data.deviceId!);
        print(SpUtil.getInt(Constant.deviceId));
        //todo 执行时间太长了
        // await Device().getDeviceDynamicInfo('1');
        //  Provider.of<ThemeProvider>(context, listen: false).setTheme(themeMode);
        /// 与上方等价，provider 4.1.0添加的拓展方法
        // view.getContext().read<UserProvider>().setUserEntity(data.data!);
        // view.provider.setUserEntity(data.data!);
        view.getContext().read<UserProvider>().setUserEntity(data.data!);
        view.loginSuccess(data.data!);
      }
    }, onError: (_, __) async {
      if (_ == 200006) {
        await captchas(phone, false);
      } else {
        view.showToast(__);
      }
    });
  }

  Future<bool> verificationCodes(String phone, bool isShowDialog, {String? captchaKey, String? captchaCode}) async {
    Map<String, dynamic> loginInfo = {
      "phone": phone,
      "captcha_key": captchaKey,
      "captcha_code": captchaCode,
    };
    bool sendResult = false;
    FormData formData = FormData.fromMap(loginInfo);
    await requestNetwork<VerificationCodeEntity>(Method.post, url: HttpApi.verificationCodes, params: formData, onSuccess: (data) async {
      SpUtil.putString(Constant.phone, phone);
      // deviceDynamicInfo = await Helper.getDeviceInfo(view, fetchDynamic: true, fetchStatic: false);
      sendResult = true;
      view.getContext();
      view.verificationCodesSuccess(data!.key!);
      view.showToast(Myapp9Localizations.of(view.getContext())!.otpSented);
      SpUtil.putString(Constant.verificationKey, data!.key!);
    }, onError: (_, __) async {
      //todo ,如果验证码输入次数过多，则直接返回图片验证码，不需要再次请求
      if (_ == 200001 || _ == 200002 || _ == 200006) {
        await captchas(phone, false);
      } else {
        view.showToast(__);
      }
    });
    return sendResult;
  }

  Future<bool> captchas(String phone, bool isShowDialog) async {
    Map<String, dynamic> loginInfo = {
      "phone": phone,
    };
    bool sendResult = false;
    FormData formData = FormData.fromMap(loginInfo);
    await requestNetwork<CaptchaEntity>(Method.post, url: HttpApi.captchas, params: formData, onSuccess: (data) async {
      sendResult = true;
      view.showCaptcha(data!.captchaKey!, data.captchaImageContent!);
    }, onError: (_, __) {
      view.showToast(__);
      sendResult = false;
    });
    return sendResult;
  }
}
