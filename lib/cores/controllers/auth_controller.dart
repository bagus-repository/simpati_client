import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:simpati_client/cores/controllers/controller.dart';
import 'package:simpati_client/cores/data/providers/api_provider.dart';
import 'package:simpati_client/cores/data/providers/pref_provider.dart';
import 'package:simpati_client/cores/models/api_response_model.dart';
import 'package:simpati_client/cores/routes/routes.dart';
import 'package:simpati_client/cores/utils/alert_util.dart';
import 'package:simpati_client/cores/utils/device_util.dart';

class AuthController extends Controller {
  final txtNameCtrl = TextEditingController(),
      txtEmailCtrl = TextEditingController(),
      txtPasswordCtrl = TextEditingController();
  final httpClient = Get.find<APIProvider>();

  bool validateLoginForm() {
    bool valid = true;
    String msg = '';
    if (txtEmailCtrl.text.isEmpty || txtPasswordCtrl.text.isEmpty) {
      valid = false;
      msg = 'Lengkapi isian bertanda * (asterik)';
    } else {
      if (!txtEmailCtrl.text.isEmail) {
        valid = false;
        msg = 'Email tidak valid';
      }
      if (txtPasswordCtrl.text.length < 6) {
        valid = false;
        msg = 'Password minimal 6 karakter';
      }
    }
    if (!valid) {
      AlertUtil.showSnackbar('Validasi', msg, AlertStatus.info);
    }
    return valid;
  }

  bool validateRegisterForm() {
    bool valid = true;
    String msg = '';
    if (txtEmailCtrl.text.isEmpty ||
        txtPasswordCtrl.text.isEmpty ||
        txtNameCtrl.text.isEmpty) {
      valid = false;
      msg = 'Lengkapi isian bertanda * (asterik)';
    } else {
      if (!txtEmailCtrl.text.isEmail) {
        valid = false;
        msg = 'Email tidak valid';
      }
      if (txtPasswordCtrl.text.length < 6) {
        valid = false;
        msg = 'Password minimal 6 karakter';
      }
    }
    if (!valid) {
      AlertUtil.showSnackbar('Validasi', msg, AlertStatus.info);
    }
    return valid;
  }

  void doLogin() async {
    if (!validateLoginForm()) {
      return;
    }
    try {
      startSubmiting();
      var device = await Deviceutil.getDeviceInfo();
      var response = await httpClient.request(
          requestMethod: RequestMethod.raw,
          method: Method.post,
          urlPath: '/auth/login',
          params: {
            'email': txtEmailCtrl.text,
            'password': txtPasswordCtrl.text,
            'device': device.deviceName,
          });
      if (response is APIErrorResponse) {
        AlertUtil.showSnackbar('Error', response.msg, AlertStatus.error);
      } else {
        if (response['status'] == 'success') {
          resetForm();
          await PrefProvider.secureStorage.write(key: PrefProvider.TOKEN_KEY, value: response['data']['token']);
          Get.offNamed(Routes.HOME);
        } else {
          AlertUtil.showSnackbar('Error', response['msg'], AlertStatus.error);
        }
      }
    } catch (e) {
      AlertUtil.showSnackbar('Error', e.toString(), AlertStatus.error);
    } finally {
      stopSubmiting();
    }
  }

  void resetForm() {
    txtEmailCtrl.text = '';
    txtPasswordCtrl.text = '';
    txtNameCtrl.text = '';
  }

  void doRegister() async {
    if (!validateRegisterForm()) {
      return;
    }
    try {
      startSubmiting();
      var response = await httpClient.request(
          requestMethod: RequestMethod.raw,
          method: Method.post,
          urlPath: '/auth/register',
          params: {
            'name': txtNameCtrl.text,
            'email': txtEmailCtrl.text,
            'password': txtPasswordCtrl.text,
          });
      if (response is APIErrorResponse) {
        AlertUtil.showSnackbar('Error', response.msg, AlertStatus.error);
      } else {
        if (response['status'] == 'success') {
          resetForm();
          AlertUtil.showSnackbar(
              'Selamat',
              'Pendaftaran email ${txtEmailCtrl.text} berhasil, silahkan untuk masuk.',
              AlertStatus.success);
          Get.offNamed(Routes.LOGIN_PAGE);
        } else {
          AlertUtil.showSnackbar('Error', response['msg'], AlertStatus.error);
        }
      }
    } catch (e) {
      AlertUtil.showSnackbar('Error', e.toString(), AlertStatus.error);
    } finally {
      stopSubmiting();
    }
  }
}
