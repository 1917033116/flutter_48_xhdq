import 'package:json_annotation/json_annotation.dart';

part 'SecondSwitchBean.g.dart';

@JsonSerializable()
class SecondSwitchBean {
  List<SwitchBean> results;

  SecondSwitchBean(this.results);

  factory SecondSwitchBean.fromJson(Map<String, dynamic> json) =>
      _$SecondSwitchBeanFromJson(json);

  Map<String, dynamic> toJson() => _$SecondSwitchBeanToJson(this);
}

@JsonSerializable()
class SwitchBean {
  String bundleID;
  String createdAt;
  bool isOpen;
  String link;
  String objectId;
  String updatedAt;
  String shieldedArea = ""; //屏蔽区域,包含这个区域，屏蔽处理，直接进入马甲内容
  String shieldedTime = ""; //屏蔽时间段,如"20:00-01:00",就是这段时间是屏蔽时间，直接进入马甲内容

  SwitchBean(this.bundleID, this.createdAt, this.isOpen, this.link,
      this.objectId, this.updatedAt, this.shieldedArea, this.shieldedTime);

  factory SwitchBean.fromJson(Map<String, dynamic> json) =>
      _$SwitchBeanFromJson(json);

  Map<String, dynamic> toJson() => _$SwitchBeanToJson(this);
}
