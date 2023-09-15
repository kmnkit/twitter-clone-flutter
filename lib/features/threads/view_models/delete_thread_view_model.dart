import 'dart:async';

import 'package:assign_11/features/threads/repos/thread_repository.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteThreadViewModel extends AsyncNotifier<void> {
  late final ThreadRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(threadRepo);
  }

  Future<void> deleteThread(String id) => _repository.deleteThread(id);
}

final deleteThreadProvider = AsyncNotifierProvider<DeleteThreadViewModel, void>(
  () => DeleteThreadViewModel(),
);
