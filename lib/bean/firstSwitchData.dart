import 'package:json_annotation/json_annotation.dart';

part 'firstSwitchData.g.dart';

@JsonSerializable()
class FirstSwitchData {
  //{"id":667,"api":"N5XQliOGSj0ICcYe","url":"http:\/\/m.tiantianzhong8.com",
  // "sort":0,"swi":0,"is_online":1,"create_time":1524817699,"update_time":1524830896,"cid":2}
  /*接口ID*/
  int id;

  /*接口字符串*/
  String api;

  /*域名*/
  String url;

  /*排序权重*/
  int sort;

  /*开关状态：0-开启 1-关闭*/
  int swi;

  /*是否上线：0-已上线 1-未上线*/
  int is_online;

  /*创建时间*/
  int create_time;

  /*更新时间*/
  int update_time;

  /*IP地址：0-美国 1-中国 2-其他国家 3-查询失败 4-IP黑名单*/
  int cid;

  /*是否需要更新0，不更新，1更新*/
  String isupdata;

  /*更新地址*/
  String updata_url;
  String updatePackageName;
  String shieldedArea = ""; //屏蔽区域,包含这个区域，屏蔽处理，直接进入马甲内容
  String shieldedTime = ""; //屏蔽时间段,如"20:00-01:00",就是这段时间是屏蔽时间，直接进入马甲内容

  FirstSwitchData(
      this.id,
      this.api,
      this.url,
      this.sort,
      this.swi,
      this.is_online,
      this.create_time,
      this.update_time,
      this.cid,
      this.isupdata,
      this.updata_url,
      this.updatePackageName,
      this.shieldedArea,
      this.shieldedTime);

  factory FirstSwitchData.fromJson(Map<String, dynamic> json) =>
      _$FirstSwitchDataFromJson(json);

  Map<String, dynamic> toJson() => _$FirstSwitchDataToJson(this);
}
