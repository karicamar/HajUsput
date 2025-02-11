// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userRole.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRole _$UserRoleFromJson(Map<String, dynamic> json) => UserRole(
      (json['userRoleId'] as num?)?.toInt(),
      (json['userId'] as num?)?.toInt(),
      (json['roleId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserRoleToJson(UserRole instance) => <String, dynamic>{
      'userRoleId': instance.userRoleId,
      'userId': instance.userId,
      'roleId': instance.roleId,
    };
