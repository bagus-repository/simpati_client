// To parse this JSON data, do
//
//     final versionModel = versionModelFromJson(jsonString);

import 'dart:convert';

VersionModel versionModelFromJson(String str) => VersionModel.fromJson(json.decode(str));

String versionModelToJson(VersionModel data) => json.encode(data.toJson());

class VersionModel {
    VersionModel({
        required this.status,
        required this.msg,
        required this.data,
    });

    String status;
    String msg;
    Data data;

    factory VersionModel.fromJson(Map<String, dynamic> json) => VersionModel(
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
        required this.minAndroid,
        required this.curAndroid,
        required this.storeUrl,
    });

    String minAndroid;
    String curAndroid;
    String storeUrl;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        minAndroid: json["min_android"],
        curAndroid: json["cur_android"],
        storeUrl: json["store_url"],
    );

    Map<String, dynamic> toJson() => {
        "min_android": minAndroid,
        "cur_android": curAndroid,
        "store_url": storeUrl,
    };
}
