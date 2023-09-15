// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'thread.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Thread _$ThreadFromJson(Map<String, dynamic> json) {
  return _Thread.fromJson(json);
}

/// @nodoc
mixin _$Thread {
  String get id => throw _privateConstructorUsedError;
  set id(String value) => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  set text(String value) => throw _privateConstructorUsedError;
  List<String> get imageUrls => throw _privateConstructorUsedError;
  set imageUrls(List<String> value) => throw _privateConstructorUsedError;
  int get likes => throw _privateConstructorUsedError;
  set likes(int value) => throw _privateConstructorUsedError;
  int get replies => throw _privateConstructorUsedError;
  set replies(int value) => throw _privateConstructorUsedError;
  int get created => throw _privateConstructorUsedError;
  String get creator => throw _privateConstructorUsedError;
  String get creatorUid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ThreadCopyWith<Thread> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThreadCopyWith<$Res> {
  factory $ThreadCopyWith(Thread value, $Res Function(Thread) then) =
      _$ThreadCopyWithImpl<$Res, Thread>;
  @useResult
  $Res call(
      {String id,
      String text,
      List<String> imageUrls,
      int likes,
      int replies,
      int created,
      String creator,
      String creatorUid});
}

/// @nodoc
class _$ThreadCopyWithImpl<$Res, $Val extends Thread>
    implements $ThreadCopyWith<$Res> {
  _$ThreadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? imageUrls = null,
    Object? likes = null,
    Object? replies = null,
    Object? created = null,
    Object? creator = null,
    Object? creatorUid = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrls: null == imageUrls
          ? _value.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      replies: null == replies
          ? _value.replies
          : replies // ignore: cast_nullable_to_non_nullable
              as int,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as int,
      creator: null == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as String,
      creatorUid: null == creatorUid
          ? _value.creatorUid
          : creatorUid // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ThreadCopyWith<$Res> implements $ThreadCopyWith<$Res> {
  factory _$$_ThreadCopyWith(_$_Thread value, $Res Function(_$_Thread) then) =
      __$$_ThreadCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String text,
      List<String> imageUrls,
      int likes,
      int replies,
      int created,
      String creator,
      String creatorUid});
}

/// @nodoc
class __$$_ThreadCopyWithImpl<$Res>
    extends _$ThreadCopyWithImpl<$Res, _$_Thread>
    implements _$$_ThreadCopyWith<$Res> {
  __$$_ThreadCopyWithImpl(_$_Thread _value, $Res Function(_$_Thread) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? imageUrls = null,
    Object? likes = null,
    Object? replies = null,
    Object? created = null,
    Object? creator = null,
    Object? creatorUid = null,
  }) {
    return _then(_$_Thread(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrls: null == imageUrls
          ? _value.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      replies: null == replies
          ? _value.replies
          : replies // ignore: cast_nullable_to_non_nullable
              as int,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as int,
      creator: null == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as String,
      creatorUid: null == creatorUid
          ? _value.creatorUid
          : creatorUid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Thread implements _Thread {
  _$_Thread(
      {required this.id,
      required this.text,
      required this.imageUrls,
      required this.likes,
      required this.replies,
      required this.created,
      required this.creator,
      required this.creatorUid});

  factory _$_Thread.fromJson(Map<String, dynamic> json) =>
      _$$_ThreadFromJson(json);

  @override
  String id;
  @override
  String text;
  @override
  List<String> imageUrls;
  @override
  int likes;
  @override
  int replies;
  @override
  final int created;
  @override
  final String creator;
  @override
  final String creatorUid;

  @override
  String toString() {
    return 'Thread(id: $id, text: $text, imageUrls: $imageUrls, likes: $likes, replies: $replies, created: $created, creator: $creator, creatorUid: $creatorUid)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ThreadCopyWith<_$_Thread> get copyWith =>
      __$$_ThreadCopyWithImpl<_$_Thread>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ThreadToJson(
      this,
    );
  }
}

abstract class _Thread implements Thread {
  factory _Thread(
      {required String id,
      required String text,
      required List<String> imageUrls,
      required int likes,
      required int replies,
      required final int created,
      required final String creator,
      required final String creatorUid}) = _$_Thread;

  factory _Thread.fromJson(Map<String, dynamic> json) = _$_Thread.fromJson;

  @override
  String get id;
  set id(String value);
  @override
  String get text;
  set text(String value);
  @override
  List<String> get imageUrls;
  set imageUrls(List<String> value);
  @override
  int get likes;
  set likes(int value);
  @override
  int get replies;
  set replies(int value);
  @override
  int get created;
  @override
  String get creator;
  @override
  String get creatorUid;
  @override
  @JsonKey(ignore: true)
  _$$_ThreadCopyWith<_$_Thread> get copyWith =>
      throw _privateConstructorUsedError;
}
