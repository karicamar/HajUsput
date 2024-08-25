// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      (json['paymentId'] as num?)?.toInt(),
      (json['rideId'] as num?)?.toInt(),
      (json['payerId'] as num?)?.toInt(),
      json['paymentStatus'] as String?,
      json['paymentDate'] == null
          ? null
          : DateTime.parse(json['paymentDate'] as String),
      (json['amount'] as num?)?.toDouble(),
      json['paymentMethod'] as String?,
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'paymentId': instance.paymentId,
      'rideId': instance.rideId,
      'payerId': instance.payerId,
      'amount': instance.amount,
      'paymentStatus': instance.paymentStatus,
      'paymentMethod': instance.paymentMethod,
      'paymentDate': instance.paymentDate?.toIso8601String(),
    };
