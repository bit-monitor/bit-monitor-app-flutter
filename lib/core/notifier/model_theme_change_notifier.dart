import 'package:flutter/material.dart';
import 'package:bit_monitor_app/core/config/config_global.dart';
import 'package:bit_monitor_app/core/notifier/model_profile_change_notifier.dart';

class ModelThemeChangeNotifier extends ModelProfileChangeNotifier {
  // 获取当前主题，如果未设置主题，则默认使用蓝色主题
  ColorSwatch get theme => ConfigGlobal.themes.firstWhere(
      (element) => element.value == modelProfile.theme,
      orElse: () => Colors.blue);

  // 主题改变后，通知其依赖项，新主题会立即生效
  set theme(ColorSwatch colorSwatch) {
    if (colorSwatch != theme) {
      modelProfile.theme = colorSwatch[500].value;
      notifyListeners();
    }
  }
}
