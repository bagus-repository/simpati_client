// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
    NewsModel({
        required this.status,
        required this.msg,
        required this.data,
    });

    String status;
    String msg;
    Data data;

    factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        status: json["status"],
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.currentPage,
        required this.data,
        required this.perPage,
        this.to,
    });

    int currentPage;
    List<News> data;
    int perPage;
    int? to;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<News>.from(json["data"].map((x) => News.fromJson(x))),
        perPage: json["per_page"],
        to: json["to"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "per_page": perPage,
        "to": to,
    };
}

class News {
    News({
        required this.id,
        required this.title,
        required this.desc,
        required this.imageUrl,
        required this.createdBy,
        required this.sts,
        required this.createdAt,
        required this.updatedAt,
        required this.thumbnail,
    });

    int id;
    String title;
    String desc;
    String imageUrl;
    int createdBy;
    int sts;
    DateTime createdAt;
    DateTime updatedAt;
    String thumbnail;

    factory News.fromJson(Map<String, dynamic> json) => News(
        id: json["id"],
        title: json["title"],
        desc: json["desc"],
        imageUrl: json["image_url"],
        createdBy: json["created_by"],
        sts: json["sts"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        thumbnail: json["thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "desc": desc,
        "image_url": imageUrl,
        "created_by": createdBy,
        "sts": sts,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "thumbnail": thumbnail,
    };
}
