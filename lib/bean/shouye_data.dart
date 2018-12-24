
class GridDataOfShouYe {
  String imgPath;
  String title;
  int id;

  GridDataOfShouYe(this.imgPath, this.title,this.id);
}

class ShouYeNewsItemBean {
  String page;
  String limit;
  int total;
  int totalPage;
  int code;
  String message;
  List<Datum> data;

  ShouYeNewsItemBean({
    this.page,
    this.limit,
    this.total,
    this.totalPage,
    this.code,
    this.message,
    this.data,
  });

  factory ShouYeNewsItemBean.fromJson(Map<String, dynamic> json) => new ShouYeNewsItemBean(
    page: json["page"],
    limit: json["limit"],
    total: json["total"],
    totalPage: json["totalPage"],
    code: json["code"],
    message: json["message"],
    data: new List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "total": total,
    "totalPage": totalPage,
    "code": code,
    "message": message,
    "data": new List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
class Datum {
  int id;
  String title;
  int classId;
  String author;
  String time;
  String thumb;

  Datum({
    this.id,
    this.title,
    this.classId,
    this.author,
    this.time,
    this.thumb,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => new Datum(
    id: json["id"],
    title: json["title"],
    classId: json["class_id"],
    author: json["author"],
    time: json["time"],
    thumb: json["thumb"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "class_id": classId,
    "author": author,
    "time": time,
    "thumb": thumb,
  };
}
