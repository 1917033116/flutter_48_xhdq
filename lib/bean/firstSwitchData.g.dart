// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firstSwitchData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirstSwitchData _$FirstSwitchDataFromJson(Map<String, dynamic> json) {
  return FirstSwitchData(
      json['id'] as int,
      json['api'] as String,
      json['url'] as String,
      json['sort'] as int,
      json['swi'] as int,
      json['is_online'] as int,
      json['create_time'] as int,
      json['update_time'] as int,
      json['cid'] as int,
      json['isupdata'] as String,
      json['updata_url'] as String,
      json['updatePackageName'] as String,
      json['shieldedArea'] as String,
      json['shieldedTime'] as String);
}

Map<String, dynamic> _$FirstSwitchDataToJson(FirstSwitchData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'api': instance.api,
      'url': instance.url,
      'sort': instance.sort,
      'swi': instance.swi,
      'is_online': instance.is_online,
      'create_time': instance.create_time,
      'update_time': instance.update_time,
      'cid': instance.cid,
      'isupdata': instance.isupdata,
      'updata_url': instance.updata_url,
      'updatePackageName': instance.updatePackageName,
      'shieldedArea': instance.shieldedArea,
      'shieldedTime': instance.shieldedTime
    };
