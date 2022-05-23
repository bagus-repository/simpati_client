class PlatformModel {
  String appName;
  String packageName;
  String version;
  String buildNumber;

  PlatformModel({
    required this.appName,
    required this.packageName,
    required this.version,
    required this.buildNumber,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appName'] = appName;
    data['packageName'] = packageName;
    data['version'] = version;
    data['buildNumber'] = buildNumber;
    return data;
  }
}
