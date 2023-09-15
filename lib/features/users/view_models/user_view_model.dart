import 'dart:async';

import 'package:assign_11/features/authentication/repos/authentication_repo.dart';
import 'package:assign_11/features/users/models/user.dart';
import 'package:assign_11/features/users/repos/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _userRepository;
  late final AuthenticationRepository _authRepository;

  @override
  FutureOr<UserProfileModel> build() async {
    _userRepository = ref.read(userRepo);
    _authRepository = ref.read(authRepo);

    if (_authRepository.isLoggedIn) {
      final profile = await _userRepository.findProfile(_authRepository.user!.uid);
      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }
    return UserProfileModel.empty();
  }

  Future<UserProfileModel> getUser(String uid) async {
    final user = await _userRepository.findProfile(uid);
    if (user != null) {
      return UserProfileModel.fromJson(user);
    }
    return UserProfileModel.empty();
  }

  Future<void> createProfile(UserCredential credential) async {
    if (credential.user == null) {
      throw Exception("Account not created");
    }

    state = const AsyncValue.loading();

    final profile = UserProfileModel(
      bio: "",
      hasAvatar: false,
      uid: credential.user!.uid,
      nickname: credential.user!.displayName ?? "Anonymous",
      username: credential.user!.displayName ?? "Anonymous",
    );
    await _userRepository.createProfile(profile);
    state = AsyncValue.data(profile);
  }

  Future<void> onAvatarUpload() async {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(hasAvatar: true));
    await _userRepository.updateUser(state.value!.uid, {"hasAvatar": true});
  }
}

final usersProvider = AsyncNotifierProvider<UserViewModel, UserProfileModel>(
  () => UserViewModel(),
);
