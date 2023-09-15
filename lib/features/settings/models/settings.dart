import 'package:hive/hive.dart';

part 'settings.g.dart';

@HiveType(typeId: 0)
class SettingModel extends HiveObject {
  @HiveField(0)
  bool isDarkMode;
  @HiveField(1)
  bool isPrivate;
  @HiveField(2)
  int allowMention;

  SettingModel({
    required this.isDarkMode,
    required this.isPrivate,
    required this.allowMention,
  });

  SettingModel copyWith({
    bool? isDarkMode,
    bool? isPrivate,
    int? allowMention,
  }) {
    return SettingModel(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isPrivate: isPrivate ?? this.isPrivate,
      allowMention: allowMention ?? this.allowMention,
    );
  }
}
