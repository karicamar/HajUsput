// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      (json['reviewId'] as num?)?.toInt(),
      (json['rideId'] as num?)?.toInt(),
      (json['driverId'] as num?)?.toInt(),
      (json['reviewerId'] as num?)?.toInt(),
      (json['rating'] as num?)?.toInt(),
      json['comments'] as String,
      DateTime.parse(json['reviewDate'] as String),
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'reviewId': instance.reviewId,
      'rideId': instance.rideId,
      'driverId': instance.driverId,
      'reviewerId': instance.reviewerId,
      'rating': instance.rating,
      'comments': instance.comments,
      'reviewDate': instance.reviewDate.toIso8601String(),
    };
