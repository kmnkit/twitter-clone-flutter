import 'dart:async';

import 'package:assign_11/features/authentication/repos/authentication_repo.dart';
import 'package:assign_11/features/users/view_models/user_view_model.dart';
import 'package:assign_11/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  // SignUpViewModel에서는 아무것도 expose 하지 않는다.
  // 계정을 만들 때 로딩 화면을 보여주고,
  // 계정 생성을 트리거할 뿐임.
  // 로딩 여부 외에 필요한 value가 없음

  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp(BuildContext context) async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm);
    final users = ref.read(usersProvider.notifier);

    state = await AsyncValue.guard(() async {
      final userCredential = await _authRepo.signUp(
        form["email"],
        form["password"],
      );
      await users.createProfile(userCredential);
    });
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    }
  }
}

final signUpForm = StateProvider((ref) => {});

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
