// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ride _$RideFromJson(Map<String, dynamic> json) => Ride(
      (json['rideId'] as num?)?.toInt(),
      (json['driverId'] as num?)?.toInt(),
      (json['departureLocationId'] as num).toInt(),
      (json['destinationLocationId'] as num).toInt(),
      json['departureDate'] == null
          ? null
          : DateTime.parse(json['departureDate'] as String),
      (json['distance'] as num?)?.toDouble(),
      (json['duration'] as num?)?.toDouble(),
      (json['availableSeats'] as num?)?.toInt(),
      json['rideStatus'] as String?,
      (json['price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RideToJson(Ride instance) => <String, dynamic>{
      'rideId': instance.rideId,
      'driverId': instance.driverId,
      'departureLocationId': instance.departureLocationId,
      'destinationLocationId': instance.destinationLocationId,
      'departureDate': instance.departureDate?.toIso8601String(),
      'distance': instance.distance,
      'duration': instance.duration,
      'availableSeats': instance.availableSeats,
      'rideStatus': instance.rideStatus,
      'price': instance.price,
    };
