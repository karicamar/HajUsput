// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carMake.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarMake _$CarMakeFromJson(Map<String, dynamic> json) => CarMake(
      (json['carMakeId'] as num?)?.toInt(),
      json['name'] as String,
    );

Map<String, dynamic> _$CarMakeToJson(CarMake instance) => <String, dynamic>{
      'carMakeId': instance.carMakeId,
      'name': instance.carMakeName,
    };
