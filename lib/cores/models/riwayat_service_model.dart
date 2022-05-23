// To parse this JSON data, do
//
//     final riwayatServiceModel = riwayatServiceModelFromJson(jsonString);

import 'dart:convert';

RiwayatServiceModel riwayatServiceModelFromJson(String str) => RiwayatServiceModel.fromJson(json.decode(str));

String riwayatServiceModelToJson(RiwayatServiceModel data) => json.encode(data.toJson());

class RiwayatServiceModel {
    RiwayatServiceModel({
        required this.status,
        required this.msg,
        required this.data,
    });

    String status;
    String msg;
    List<RiwayatService> data;

    factory RiwayatServiceModel.fromJson(Map<String, dynamic> json) => RiwayatServiceModel(
        status: json["status"],
        msg: json["msg"],
        data: List<RiwayatService>.from(json["data"].map((x) => RiwayatService.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class RiwayatService {
    RiwayatService({
        required this.serviceNo,
        required this.requestor,
        this.apvBy,
        required this.createdDate,
        this.apvDate,
        required this.serviceCode,
        required this.sts,
        this.apvnote,
        required this.file,
        required this.fileLink,
        required this.fillingType,
        required this.requestBy,
        this.approvalBy,
    });

    String serviceNo;
    int requestor;
    int? apvBy;
    DateTime createdDate;
    DateTime? apvDate;
    String serviceCode;
    int sts;
    String? apvnote;
    String file;
    String fileLink;
    FillingType fillingType;
    By requestBy;
    By? approvalBy;

    factory RiwayatService.fromJson(Map<String, dynamic> json) => RiwayatService(
        serviceNo: json["service_no"],
        requestor: json["requestor"],
        apvBy: json["apv_by"],
        createdDate: DateTime.parse(json["created_date"]),
        apvDate: json["apv_date"] == null ? null : DateTime.parse(json["apv_date"]),
        serviceCode: json["service_code"],
        sts: json["sts"],
        apvnote: json["apvnote"],
        file: json["file"],
        fileLink: json["file_link"],
        fillingType: FillingType.fromJson(json["filling_type"]),
        requestBy: By.fromJson(json["request_by"]),
        approvalBy: json["approval_by"] == null ? null : By.fromJson(json["approval_by"]),
    );

    Map<String, dynamic> toJson() => {
        "service_no": serviceNo,
        "requestor": requestor,
        "apv_by": apvBy,
        "created_date": "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
        "apv_date": apvDate == null ? null : "${apvDate!.year.toString().padLeft(4, '0')}-${apvDate!.month.toString().padLeft(2, '0')}-${apvDate?.day.toString().padLeft(2, '0')}",
        "service_code": serviceCode,
        "sts": sts,
        "apvnote": apvnote,
        "file": file,
        "file_link": fileLink,
        "filling_type": fillingType.toJson(),
        "request_by": requestBy.toJson(),
        "approval_by": approvalBy?.toJson(),
    };
}

class By {
    By({
        required this.id,
        required this.name,
        required this.email,
        required this.role,
        required this.sts,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String name;
    String email;
    String role;
    int sts;
    DateTime createdAt;
    DateTime updatedAt;

    factory By.fromJson(Map<String, dynamic> json) => By(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        sts: json["sts"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "role": role,
        "sts": sts,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class FillingType {
    FillingType({
        required this.categoryId,
        required this.lookupId,
        required this.lookupValue,
        required this.lookupDesc,
        required this.sts,
    });

    String categoryId;
    int lookupId;
    String lookupValue;
    String lookupDesc;
    int sts;

    factory FillingType.fromJson(Map<String, dynamic> json) => FillingType(
        categoryId: json["category_id"],
        lookupId: json["lookup_id"],
        lookupValue: json["lookup_value"],
        lookupDesc: json["lookup_desc"],
        sts: json["sts"],
    );

    Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "lookup_id": lookupId,
        "lookup_value": lookupValue,
        "lookup_desc": lookupDesc,
        "sts": sts,
    };
}
