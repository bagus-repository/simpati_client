import 'package:package_info_plus/package_info_plus.dart';
import 'package:simpati_client/cores/models/platform_model.dart';

class PlatformService {
  PlatformModel? _platformModel;

  Future<PlatformModel> getPlatformInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _platformModel ??= PlatformModel(
          appName: packageInfo.appName,
          packageName: packageInfo.packageName,
          version: packageInfo.version,
          buildNumber: packageInfo.buildNumber);
    return _platformModel!;
  }
}