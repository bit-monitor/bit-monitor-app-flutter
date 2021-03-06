import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:bit_monitor_app/core/consts/const_global.dart';
import 'package:bit_monitor_app/core/local/local_storage.dart';
import 'package:bit_monitor_app/models/model_profile.dart';

// 五套可选的主题色
const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];

class ConfigGlobal {
  static ModelProfile modelProfile = ModelProfile();

  /// 用于全局路由控制
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// 可选的主题列表
  static List<MaterialColor> get themes => _themes;

  /// 初始化全局信息，在APP启动时执行
  static Future init() async {
    var _modelProfile = await LocalStorage.get(ConstGlobal.MODEL_PROFILE_KEY);
    if (_modelProfile != null) {
      try {
        modelProfile = ModelProfile.fromJson(jsonDecode(_modelProfile));
      } catch (e) {
        print(e);
      }
    }
  }

  /// 保存Profile信息
  static Future<bool> saveModelProfile() async {
    return await LocalStorage.save(
        ConstGlobal.MODEL_PROFILE_KEY, jsonEncode(modelProfile.toJson()));
  }
}
