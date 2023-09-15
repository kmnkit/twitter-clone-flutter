import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@unfreezed
class UserProfileModel with _$UserProfileModel {
  factory UserProfileModel({
    required bool hasAvatar,
    required String username,
    required String nickname,
    required String bio,
    required final String uid,
  }) = _UserProfileModel;

  factory UserProfileModel.empty() => UserProfileModel(
        hasAvatar: false,
        username: "",
        nickname: "",
        bio: "",
        uid: "",
      );
  factory UserProfileModel.fromJson(Map<String, Object?> json) =>
      _$UserProfileModelFromJson(json);
}
