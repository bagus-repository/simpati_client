// To parse this JSON data, do
//
//     final deviceModel = deviceModelFromJson(jsonString);

import 'dart:convert';

DeviceModel deviceModelFromJson(String str) => DeviceModel.fromJson(json.decode(str));

String deviceModelToJson(DeviceModel data) => json.encode(data.toJson());

class DeviceModel {
    DeviceModel({
        this.deviceId,
        this.deviceName,
        this.deviceOs,
        this.deviceOsVersion,
    });

    String? deviceId;
    String? deviceName;
    String? deviceOs;
    String? deviceOsVersion;

    factory DeviceModel.fromJson(Map<String, dynamic> json) => DeviceModel(
        deviceId: json["deviceId"],
        deviceName: json["deviceName"],
        deviceOs: json["deviceOS"],
        deviceOsVersion: json["deviceOSVersion"],
    );

    Map<String, dynamic> toJson() => {
        "deviceId": deviceId,
        "deviceName": deviceName,
        "deviceOS": deviceOs,
        "deviceOSVersion": deviceOsVersion,
    };
}
