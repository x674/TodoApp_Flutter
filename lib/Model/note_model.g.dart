// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) => Note(
      json['titleNote'] as String,
      json['textNote'] as String,
    )..deleted = json['deleted'] as bool;

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'titleNote': instance.titleNote,
      'textNote': instance.textNote,
      'deleted': instance.deleted,
    };
