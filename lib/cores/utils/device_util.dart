import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:simpati_client/cores/models/device_model.dart';

class Deviceutil {
  static Future<DeviceModel> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      var device = await deviceInfo.androidInfo;
      return DeviceModel(
        deviceId: device.androidId,
        deviceName: device.model,
        deviceOs: 'Android',
        deviceOsVersion:
            '${device.version.release} (${device.version.codename})',
      );
    } else if (Platform.isIOS) {
      var device = await deviceInfo.iosInfo;
      return DeviceModel(
        deviceId: device.identifierForVendor,
        deviceName: device.name,
        deviceOs: 'iOS',
        deviceOsVersion: '${device.systemVersion} (${device.systemName})',
      );
    }
    return DeviceModel();
  }
}