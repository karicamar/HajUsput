// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gender.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gender _$GenderFromJson(Map<String, dynamic> json) => Gender(
      (json['genderId'] as num?)?.toInt(),
      json['genderName'] as String,
    );

Map<String, dynamic> _$GenderToJson(Gender instance) => <String, dynamic>{
      'genderId': instance.genderId,
      'genderName': instance.genderName,
    };
