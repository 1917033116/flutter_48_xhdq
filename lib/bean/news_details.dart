class NewsDetails {
  int code;
  String message;
  Data data;

  NewsDetails({
    this.code,
    this.message,
    this.data,
  });

  factory NewsDetails.fromJson(Map<String, dynamic> json) => new NewsDetails(
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data.toJson(),
  };
}
class Data {
  int id;
  String title;
  int classId;
  String content;
  String author;
  String time;
  String thumb;
  int coin;

  Data({
    this.id,
    this.title,
    this.classId,
    this.content,
    this.author,
    this.time,
    this.thumb,
    this.coin,
  });

  factory Data.fromJson(Map<String, dynamic> json) => new Data(
    id: json["id"],
    title: json["title"],
    classId: json["class_id"],
    content: json["content"],
    author: json["author"],
    time: json["time"],
    thumb: json["thumb"],
    coin: json["coin"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "class_id": classId,
    "content": content,
    "author": author,
    "time": time,
    "thumb": thumb,
    "coin": coin,
  };
}