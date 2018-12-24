// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SecondSwitchBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SecondSwitchBean _$SecondSwitchBeanFromJson(Map<String, dynamic> json) {
  return SecondSwitchBean((json['results'] as List)
      ?.map((e) =>
          e == null ? null : SwitchBean.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$SecondSwitchBeanToJson(SecondSwitchBean instance) =>
    <String, dynamic>{'results': instance.results};

SwitchBean _$SwitchBeanFromJson(Map<String, dynamic> json) {
  return SwitchBean(
      json['bundleID'] as String,
      json['createdAt'] as String,
      json['isOpen'] as bool,
      json['link'] as String,
      json['objectId'] as String,
      json['updatedAt'] as String,
      json['shieldedArea'] as String,
      json['shieldedTime'] as String);
}

Map<String, dynamic> _$SwitchBeanToJson(SwitchBean instance) =>
    <String, dynamic>{
      'bundleID': instance.bundleID,
      'createdAt': instance.createdAt,
      'isOpen': instance.isOpen,
      'link': instance.link,
      'objectId': instance.objectId,
      'updatedAt': instance.updatedAt,
      'shieldedArea': instance.shieldedArea,
      'shieldedTime': instance.shieldedTime
    };
