import 'dart:async';

import 'package:assign_11/features/threads/models/thread.dart';
import 'package:assign_11/features/threads/repos/thread_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThreadViewModel extends AsyncNotifier<List<Thread>> {
  late final ThreadRepository _repository;
  List<Thread> _list = [];

  @override
  FutureOr<List<Thread>> build() async {
    _repository = ref.read(threadRepo);
    _list = await _fetchThreads();

    return _list;
  }

  Future<List<Thread>> _fetchThreads() async {
    final result = await _repository.fetchThreads();
    final threads = result.docs.map((thread) {
      var threadData = thread.data();
      threadData.addAll({'id': thread.id});
      return Thread.fromJson(threadData);
    });
    return threads.toList();
  }

  Future<void> refresh() async {
    final threads = await _fetchThreads();
    _list = threads;
    state = AsyncValue.data(threads);
  }
}

final threadProvider = AsyncNotifierProvider<ThreadViewModel, List<Thread>>(
  () => ThreadViewModel(),
);
