import 'dart:async';
import 'dart:io';

import 'package:assign_11/features/authentication/repos/authentication_repo.dart';
import 'package:assign_11/features/threads/models/thread.dart';
import 'package:assign_11/features/threads/repos/thread_repository.dart';
import 'package:assign_11/features/users/view_models/user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostThreadViewModel extends AsyncNotifier<void> {
  late final ThreadRepository _repository;

  // build method는 Notifier가 노출할 데이터를 제공하는 방법
  @override
  FutureOr<void> build() {
    _repository = ref.read(threadRepo);
  }

  Future<void> postNewThread(String? text, List<File> images) async {
    final user = ref.read(authRepo).user;
    final userProfile = ref.read(usersProvider).value;
    if (userProfile == null) return;

    state = const AsyncValue.loading();
    await AsyncValue.guard(() async {
      final thread = Thread(
        id: "",
        creator: userProfile.username,
        text: text ?? "",
        creatorUid: user!.uid,
        imageUrls: [],
        likes: 0,
        replies: 0,
        created: DateTime.now().millisecondsSinceEpoch,
      );
      await _repository.postNewThread(thread, images);
    });
  }
}

final postThreadProvider = AsyncNotifierProvider<PostThreadViewModel, void>(
  () => PostThreadViewModel(),
);
