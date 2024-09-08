// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Car _$CarFromJson(Map<String, dynamic> json) => Car(
      (json['carId'] as num?)?.toInt(),
      (json['driverId'] as num?)?.toInt(),
      json['make'] as String,
      json['carType'] as String,
      json['color'] as String,
      (json['yearOfManufacture'] as num?)?.toInt(),
      json['licensePlateNumber'] as String?,
    );

Map<String, dynamic> _$CarToJson(Car instance) => <String, dynamic>{
      'carId': instance.carId,
      'driverId': instance.driverId,
      'make': instance.make,
      'carType': instance.carType,
      'color': instance.color,
      'yearOfManufacture': instance.yearOfManufacture,
      'licensePlateNumber': instance.licensePlateNumber,
    };
