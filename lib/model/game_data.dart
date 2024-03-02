import 'package:json_annotation/json_annotation.dart';

part 'game_data.g.dart';

@JsonSerializable()
class GameData {
  @JsonKey(name: 'ct')
  int createdTime = 0;

  GameData();

  factory GameData.fromJson(Map<String, dynamic> json) => _$GameDataFromJson(json);

  Map<String, dynamic> toJson() => _$GameDataToJson(this);
}
