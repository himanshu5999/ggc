import 'package:json_annotation/json_annotation.dart';

part 'game_data.g.dart';

@JsonSerializable()
class GameData {
  @JsonKey(name: 'sc', defaultValue: 0)
  int sunCurrency = 0;

  @JsonKey(name: 'dc', defaultValue: 0)
  int dropletCurrency = 0;

  @JsonKey(name: 'cl', defaultValue: 0)
  int currLevel = 0;

  @JsonKey(name: 'cs', defaultValue: 0)
  int currStage = 0;

  @JsonKey(name: 'ld', defaultValue: {})
  Map<String, bool> listData = {};

  GameData();

  factory GameData.fromJson(Map<String, dynamic> json) =>
      _$GameDataFromJson(json);

  Map<String, dynamic> toJson() => _$GameDataToJson(this);
}
