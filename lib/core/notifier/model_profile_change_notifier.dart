import 'package:flutter/material.dart';
import 'package:bit_monitor_app/core/config/config_global.dart';
import 'package:bit_monitor_app/models/model_profile.dart';

class ModelProfileChangeNotifier extends ChangeNotifier {
  ModelProfile get modelProfile => ConfigGlobal.modelProfile;

  @override
  void notifyListeners() {
    ConfigGlobal.saveModelProfile();
    super.notifyListeners();
  }
}