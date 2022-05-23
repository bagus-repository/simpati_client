// To parse this JSON data, do
//
//     final sliderModel = sliderModelFromJson(jsonString);

import 'dart:convert';

SliderModel sliderModelFromJson(String str) => SliderModel.fromJson(json.decode(str));

String sliderModelToJson(SliderModel data) => json.encode(data.toJson());

class SliderModel {
    SliderModel({
        required this.status,
        required this.msg,
        required this.data,
    });

    String status;
    String msg;
    List<Slider> data;

    factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        status: json["status"],
        msg: json["msg"],
        data: List<Slider>.from(json["data"].map((x) => Slider.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Slider {
    Slider({
        required this.id,
        required this.judul,
        required this.file,
        required this.sts,
        required this.createdAt,
        required this.updatedAt,
        required this.fileLink,
    });

    int id;
    String judul;
    String file;
    int sts;
    DateTime createdAt;
    DateTime updatedAt;
    String fileLink;

    factory Slider.fromJson(Map<String, dynamic> json) => Slider(
        id: json["id"],
        judul: json["judul"],
        file: json["file"],
        sts: json["sts"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        fileLink: json["file_link"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "judul": judul,
        "file": file,
        "sts": sts,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "file_link": fileLink,
    };
}
