import 'package:assign_11/features/settings/models/settings.dart';
import 'package:assign_11/features/settings/repos/settings_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsViewModel extends Notifier<SettingModel> {
  late final SettingsRepository _repository;

  @override
  SettingModel build() {
    _repository = ref.read(settingsRepo);
    return _repository.getSetting();
  }

  Future<void> _updateSetting(
      SettingModel Function(SettingModel current) updateFn) async {
    final currentSetting = _repository.getSetting();
    final updatedSetting = updateFn(currentSetting);
    await _repository.setSetting(updatedSetting);
    state = updatedSetting;
  }

  void setPrivacy(bool value) async =>
      await _updateSetting((current) => current.copyWith(isPrivate: value));

  void setAllowMention(int value) async =>
      await _updateSetting((current) => current.copyWith(allowMention: value));

  void setDarkMode(bool value) async =>
      await _updateSetting((current) => current.copyWith(isDarkMode: value));

  bool isDarkMode() => _repository.getSetting().isDarkMode;
  bool isPrivate() => _repository.getSetting().isPrivate;
  int allowMention() => _repository.getSetting().allowMention;
}

final settingsProvider = NotifierProvider<SettingsViewModel, SettingModel>(
  () => SettingsViewModel(),
);
