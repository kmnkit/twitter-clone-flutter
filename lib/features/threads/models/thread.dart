import 'package:freezed_annotation/freezed_annotation.dart';

part 'thread.freezed.dart';
part 'thread.g.dart';

@unfreezed
class Thread with _$Thread {
  factory Thread({
    required String id,
    required String text,
    required List<String> imageUrls,
    required int likes,
    required int replies,
    required final int created,
    required final String creator,
    required final String creatorUid,
  }) = _Thread;

  factory Thread.fromJson(Map<String, Object?> json) => _$ThreadFromJson(json);
}
