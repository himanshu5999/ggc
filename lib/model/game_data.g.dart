// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameData _$GameDataFromJson(Map<String, dynamic> json) => GameData()
  ..sunCurrency = json['sc'] as int? ?? 0
  ..dropletCurrency = json['dc'] as int? ?? 0
  ..currLevel = json['cl'] as int? ?? 0
  ..currStage = json['cs'] as int? ?? 0
  ..listData = (json['ld'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as bool),
      ) ??
      {}
  ..currTreeLevel = json['ctl'] as int? ?? 0;

Map<String, dynamic> _$GameDataToJson(GameData instance) => <String, dynamic>{
      'sc': instance.sunCurrency,
      'dc': instance.dropletCurrency,
      'cl': instance.currLevel,
      'cs': instance.currStage,
      'ld': instance.listData,
      'ctl': instance.currTreeLevel,
    };
