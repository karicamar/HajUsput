// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Messages _$MessagesFromJson(Map<String, dynamic> json) => Messages(
      (json['messageId'] as num?)?.toInt(),
      (json['senderId'] as num?)?.toInt(),
      (json['receiverId'] as num?)?.toInt(),
      json['messageContent'] as String,
      DateTime.parse(json['messageDate'] as String),
    );

Map<String, dynamic> _$MessagesToJson(Messages instance) => <String, dynamic>{
      'messageId': instance.messageId,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'messageContent': instance.messageContent,
      'messageDate': instance.messageDate.toIso8601String(),
    };
