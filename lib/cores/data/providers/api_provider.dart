import 'dart:collection';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:simpati_client/cores/configs/configs.dart';
import 'package:simpati_client/cores/data/constants.dart';
import 'package:simpati_client/cores/data/providers/pref_provider.dart';
import 'package:simpati_client/cores/models/api_response_model.dart';

enum Method { get, post }
enum RequestMethod { raw, auth }

class APIProvider {
  late Dio _authClient;
  late Dio _unAuthClient;
  final BaseOptions baseOptions = BaseOptions(
      baseUrl: ConfigApp.apiUrl,
      connectTimeout: ConstantData.apiTimeout,
      receiveTimeout: 100000,
      followRedirects: true,
      headers: {
        "Accept": "application/json",
        "X-Requested-With": "XMLHttpRequest",
      });

  APIProvider() {
    _authClient = Dio(baseOptions);
    _unAuthClient = Dio(baseOptions);

    _authClient.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      options.headers.addAll(await getAuthorizedHeader());
      return handler.next(options);
    }));
  }

  Future<Map<String, String>> getAuthorizedHeader() async {
    Map<String, String> headers = {};

    String? token =
        await PrefProvider.secureStorage.read(key: PrefProvider.TOKEN_KEY);
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  Future<dynamic> request({
    required RequestMethod requestMethod,
    required Method method,
    required String urlPath,
    Map<String, dynamic>? params,
    FormData? formData,
  }) async {
    try {
      Response response;
      if (requestMethod == RequestMethod.auth) {
        response = await (method == Method.get
            ? _authClient.get(urlPath, queryParameters: params)
            : _authClient.post(urlPath, data: formData ?? params));
      } else {
        response = method == Method.get
            ? await _unAuthClient.get(urlPath, queryParameters: params)
            : await _unAuthClient.post(urlPath, data: formData ?? params);
      }
      return response.data;
    } on DioError catch (e) {
      var errorResponse = APIErrorResponse();
      errorResponse.code = e.response?.statusCode ?? 0;
      if (e.response != null) {
        if (e.response!.statusCode == 422) {
          var errors = <String>[];
          (e.response!.data['errors'] as Map<String, dynamic>)
              .forEach((key, value) {
            for (var item in value) {
              errors.add(item as String);
            }
          });
          errorResponse.msg = errors.join('\n');
        } else {
          errorResponse.msg = e.response!.statusMessage ?? 'Error Network';
        }
      } else {
        errorResponse.msg = e.message;
      }

      return errorResponse;
    }
  }
}
