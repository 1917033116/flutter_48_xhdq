import 'package:json_annotation/json_annotation.dart';

part 'firstSwitch.g.dart';

@JsonSerializable()
class FirstSwitch {
  int Code;
  var Data;

  FirstSwitch(this.Code, this.Data);

  factory FirstSwitch.fromJson(Map<String, dynamic> json) =>
      _$FirstSwitchFromJson(json);

  Map<String, dynamic> toJson() => _$FirstSwitchToJson(this);
}
