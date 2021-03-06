import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bit_monitor_app/core/auth/auth_manager.dart';
import 'package:bit_monitor_app/core/net/api.dart';
import 'package:bit_monitor_app/core/net/url_address.dart';
import 'package:bit_monitor_app/core/notifier/model_login_user_change_notifier.dart';
import 'package:bit_monitor_app/models/model_login_user.dart';
import 'package:bit_monitor_app/modules/module_mine/services/service_mine.dart';
import 'package:bit_monitor_app/routes/routes.dart';

class ServiceLogin {
  /// 登录
  static Future<bool> login(
    BuildContext context,
    String username,
    String password,
  ) async {
    var _params = {
      "username": username,
      "password": password,
    };
    var res = await httpManager.bizHttpPost(
      UrlAddress.login,
      params: _params,
      defaultErrorTip: "登录失败",
    );
    if (res.success) {
      var _loginUser = ModelLoginUser.fromJson(res.data);
      Provider.of<ModelLoginUserChangeNotifier>(context, listen: false)
          .loginUser = _loginUser;

      // 保存到本地缓存
      String token = _loginUser.token;
      await AuthManager.saveToken(token);

      // 登录成功后，获取用户详情信息
      ServiceMine.getUserInfo(context);

      Navigator.pushReplacementNamed(context, moduleHome);

      return true;
    } else {
      return false;
    }
  }
}
