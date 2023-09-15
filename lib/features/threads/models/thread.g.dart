// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Thread _$$_ThreadFromJson(Map<String, dynamic> json) => _$_Thread(
      id: json['id'] as String,
      text: json['text'] as String,
      imageUrls:
          (json['imageUrls'] as List<dynamic>).map((e) => e as String).toList(),
      likes: json['likes'] as int,
      replies: json['replies'] as int,
      created: json['created'] as int,
      creator: json['creator'] as String,
      creatorUid: json['creatorUid'] as String,
    );

Map<String, dynamic> _$$_ThreadToJson(_$_Thread instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'imageUrls': instance.imageUrls,
      'likes': instance.likes,
      'replies': instance.replies,
      'created': instance.created,
      'creator': instance.creator,
      'creatorUid': instance.creatorUid,
    };
