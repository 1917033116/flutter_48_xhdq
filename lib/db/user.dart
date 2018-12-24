import 'dart:convert';

User userFromJson(String str) {
    final jsonData = json.decode(str);
    return User.fromJson(jsonData);
}

String userToJson(User data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class User {
    int id;
    String userName;
    String pwd;
    String nickName;

    User({
        this.id,
        this.userName,
        this.pwd,
        this.nickName
    });

    factory User.fromJson(Map<String, dynamic> json) => new User(
        id: json["id"],
        userName: json["userName"],
        pwd: json["pwd"],
        nickName:json["nickName"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "pwd": pwd,
        'nickName':nickName
    };
}