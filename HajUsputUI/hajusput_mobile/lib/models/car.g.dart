// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Car _$CarFromJson(Map<String, dynamic> json) => Car(
      (json['carId'] as num?)?.toInt(),
      (json['driverId'] as num?)?.toInt(),
      (json['carMakeId'] as num).toInt(),
      json['color'] as String,
      (json['yearOfManufacture'] as num?)?.toInt(),
      json['licensePlateNumber'] as String?,
      json['carMake'] == null
          ? null
          : CarMake.fromJson(json['carMake'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CarToJson(Car instance) => <String, dynamic>{
      'carId': instance.carId,
      'driverId': instance.driverId,
      'carMakeId': instance.carMakeId,
      'color': instance.color,
      'yearOfManufacture': instance.yearOfManufacture,
      'licensePlateNumber': instance.licensePlateNumber,
      'carMake': instance.carMake,
    };
