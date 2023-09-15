import 'dart:async';

import 'package:assign_11/constants/routes.dart';
import 'package:assign_11/features/authentication/repos/authentication_repo.dart';
import 'package:assign_11/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignInViewModel extends AsyncNotifier<void> {
  // SignInViewModel에서는 아무것도 expose 하지 않는다.
  // 계정을 만들 때 로딩 화면을 보여주고,
  // 계정 생성을 트리거할 뿐임.
  // 로딩 여부 외에 필요한 value가 없음

  late final AuthenticationRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepo);
  }

  Future<void> signIn(String email, String password, BuildContext context) async {
    state = const AsyncValue.loading();
    // final form = ref.read(signInForm);

    state = await AsyncValue.guard(
      () async => await _repository.signIn(
        email,
        password,
      ),
    );
    if (state.hasError) {
      showFirebaseErrorSnack(
        context,
        state.error,
      );
    } else {
      context.go(RoutePath.threads);
    }
  }
}

final signInForm = StateProvider((ref) => {});

final signInProvider = AsyncNotifierProvider<SignInViewModel, void>(
  () => SignInViewModel(),
);
