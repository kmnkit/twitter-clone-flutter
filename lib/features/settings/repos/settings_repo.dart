import 'package:assign_11/features/settings/models/settings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsRepository {
  static const String _settingKey = "setting";

  final Box<SettingModel> _settingsBox = Hive.box<SettingModel>("settings");

  Future<void> setSetting(SettingModel setting) async =>
      await _settingsBox.put(_settingKey, setting);

  SettingModel getSetting() {
    final setting = _settingsBox.get(
      _settingKey,
      defaultValue: SettingModel(
        isDarkMode: false,
        isPrivate: false,
        allowMention: 0,
      ),
    )!;
    return setting;
  }
}

final settingsRepo = Provider((ref) => SettingsRepository());
