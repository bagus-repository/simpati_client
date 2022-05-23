import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:simpati_client/cores/controllers/controller.dart';
import 'package:get/get.dart';
import 'package:simpati_client/cores/data/providers/api_provider.dart';
import 'package:simpati_client/cores/data/providers/store_provider.dart';
import 'package:simpati_client/cores/models/api_response_model.dart';
import 'package:simpati_client/cores/models/content_model.dart' as content;
import 'package:simpati_client/cores/models/riwayat_service_model.dart';
import 'package:simpati_client/cores/utils/alert_util.dart';

class EfillingController extends Controller {
  final storeProvider = Get.find<StoreProvider>();
  var services = <content.Datum>[].obs;
  final txtServiceCtrl = TextEditingController();
  var filePath = ''.obs;
  var fileName = ''.obs;
  String? serviceCode;
  final _httpClient = Get.find<APIProvider>();
  var riwayatList = <RiwayatService>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadPelayanan();
  }

  void loadPelayanan() {
    if (storeProvider.serviceModel != null) {
      services.assignAll(storeProvider.serviceModel!.data.toList());
    }
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['rar', 'pdf', 'zip']);
    if (result != null) {
      PlatformFile file = result.files.first;
      if (file.path != null) {
        filePath.value = file.path!;
        fileName.value = file.name;
      }
    }
  }

  bool validateForm(){
    var valid = true;
    var msg = '';
    if (serviceCode == null) {
      valid = false;
      msg = 'Silahkan pilih kategori';
    }
    if (filePath.isEmpty) {
      valid = false;
      msg = 'Silahkan pilih berkas';
    }
    if (!valid) {
      AlertUtil.showSnackbar('Validasi', msg, AlertStatus.info);
    }
    return valid;
  }

  void submitFilling() async {
    if (!validateForm()) {
      return;
    }
    try {
      startSubmiting();
      var response = await _httpClient.request(
        requestMethod: RequestMethod.auth,
        method: Method.post,
        urlPath: '/efilling/SubmitEfilling',
        formData: dio.FormData.fromMap({
          'service_code': serviceCode,
          'file': await dio.MultipartFile.fromFile(filePath.value),
        }),
      );
      if (response is APIErrorResponse) {
        AlertUtil.showSnackbar('Error', response.msg, AlertStatus.error);
      } else {
        if (response['status'] == 'success') {
          Get.back();
          AlertUtil.showSnackbar('Berhasil', response['msg'], AlertStatus.success);
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

  Future<void> loadRiwayat() async {
    try {
      var response = await _httpClient.request(
          requestMethod: RequestMethod.auth,
          method: Method.get,
          urlPath: '/efilling/GetPermohonan');
      if (response is APIErrorResponse) {
        AlertUtil.showSnackbar('Error', response.msg, AlertStatus.error);
      } else {
        if (response['status'] == 'success') {
          var model = RiwayatServiceModel.fromJson(response);
          riwayatList.assignAll(model.data);
        } else {
          AlertUtil.showSnackbar('Error', response['msg'], AlertStatus.error);
        }
      }
    } catch (e) {
      AlertUtil.showSnackbar('Error', e.toString(), AlertStatus.error);
    }
  }
}
