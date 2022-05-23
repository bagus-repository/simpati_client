import 'dart:developer';

import 'package:get/get.dart';
import 'package:simpati_client/cores/data/providers/api_provider.dart';
import 'package:simpati_client/cores/data/providers/pref_provider.dart';
import 'package:simpati_client/cores/models/api_response_model.dart';
import 'package:simpati_client/cores/models/screen_argument_model.dart';
import 'package:simpati_client/cores/models/version_model.dart';
import 'package:simpati_client/cores/routes/routes.dart';
import 'package:simpati_client/cores/services/platform_service.dart';
import 'package:simpati_client/cores/utils/alert_util.dart';

import 'controller.dart';

class SplashController extends Controller {
  final platformService = Get.find<PlatformService>();
  final httpClient = Get.find<APIProvider>();

  @override
  void onInit() {
    super.onInit();
    checkUpdate();
  }

  void checkUpdate() async {
    try {
      var response = await httpClient.request(
          requestMethod: RequestMethod.raw,
          method: Method.get,
          urlPath: '/auth/getVersion');
      if (response is APIErrorResponse) {
        AlertUtil.showSnackbar('Error', response.msg, AlertStatus.error);
      }
      var version = VersionModel.fromJson(response);
      var platform = await platformService.getPlatformInfo();
      if (int.parse(platform.buildNumber) < int.parse(version.data.minAndroid)) {
        Get.offAllNamed(Routes.NEWUPDATE_PAGE,
            arguments: ScreenArgument(stringPayload: version.data.storeUrl));
      } else {
        checkApp();
      }
    } catch (e) {
      AlertUtil.showSnackbar('Error', e.toString(), AlertStatus.error);
    }
  }

  void checkApp() async {
    var isDone = await PrefProvider.secureStorage
        .read(key: PrefProvider.IS_DONE_INTRO_KEY);
    if (isDone != 'true') {
      await Get.toNamed(Routes.ONBOARDING_PAGE);
    }

    var token =
        await PrefProvider.secureStorage.read(key: PrefProvider.TOKEN_KEY);
    if (token != null) {
      Get.offNamed(Routes.HOME);
    } else {
      Get.offNamed(Routes.LOGIN_PAGE);
    }
  }
}
