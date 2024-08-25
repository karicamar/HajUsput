// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) => Booking(
      (json['bookingId'] as num?)?.toInt(),
      (json['rideId'] as num?)?.toInt(),
      (json['passengerId'] as num?)?.toInt(),
      json['bookingStatus'] as String?,
      json['bookingDate'] == null
          ? null
          : DateTime.parse(json['bookingDate'] as String),
      (json['paymentId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
      'bookingId': instance.bookingId,
      'rideId': instance.rideId,
      'passengerId': instance.passengerId,
      'bookingStatus': instance.bookingStatus,
      'bookingDate': instance.bookingDate?.toIso8601String(),
      'paymentId': instance.paymentId,
    };
