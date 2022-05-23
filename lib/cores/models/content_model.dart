// To parse this JSON data, do
//
//     final contentModel = contentModelFromJson(jsonString);

import 'dart:convert';

ContentModel contentModelFromJson(String str) => ContentModel.fromJson(json.decode(str));

String contentModelToJson(ContentModel data) => json.encode(data.toJson());

class ContentModel {
    ContentModel({
        required this.status,
        required this.msg,
        required this.data,
    });

    String status;
    String msg;
    List<Datum> data;

    factory ContentModel.fromJson(Map<String, dynamic> json) => ContentModel(
        status: json["status"],
        msg: json["msg"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        required this.categoryId,
        required this.lookupId,
        required this.lookupValue,
        required this.lookupDesc,
        required this.sts,
        required this.lcontent,
    });

    String categoryId;
    int lookupId;
    String lookupValue;
    String lookupDesc;
    int sts;
    Lcontent? lcontent;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        categoryId: json["category_id"],
        lookupId: json["lookup_id"],
        lookupValue: json["lookup_value"],
        lookupDesc: json["lookup_desc"],
        sts: json["sts"],
        lcontent: json["lcontent"] == null ? null : Lcontent.fromJson(json["lcontent"]),
    );

    Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "lookup_id": lookupId,
        "lookup_value": lookupValue,
        "lookup_desc": lookupDesc,
        "sts": sts,
        "lcontent": lcontent?.toJson(),
    };
}

class Lcontent {
    Lcontent({
        required this.id,
        required this.type,
        required this.name,
        required this.content,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String type;
    String name;
    String content;
    DateTime createdAt;
    DateTime updatedAt;

    factory Lcontent.fromJson(Map<String, dynamic> json) => Lcontent(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "content": content,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
