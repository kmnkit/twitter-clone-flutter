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

  void setPrivacy(bool value) async {
    final currentSetting = _repository.getSetting();
    final updatedSetting = currentSetting.copyWith(isPrivate: value);
    await _repository.setSetting(updatedSetting);
    state = updatedSetting;
  }

  void setAllowMention(int value) async {
    final currentSetting = _repository.getSetting();
    final updatedSetting = currentSetting.copyWith(allowMention: value);
    await _repository.setSetting(updatedSetting);
    state = updatedSetting;
  }

  void setDarkMode(bool value) async {
    final currentSetting = _repository.getSetting();
    final updatedSetting = currentSetting.copyWith(isDarkMode: value);
    await _repository.setSetting(updatedSetting);
    state = updatedSetting;
  }

  bool isDarkMode() => _repository.getSetting().isDarkMode;

  bool isPrivate() => _repository.getSetting().isPrivate;

  int allowMention() => _repository.getSetting().allowMention;
}

final settingsProvider = NotifierProvider<SettingsViewModel, SettingModel>(
  () => SettingsViewModel(),
);
