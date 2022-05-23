import 'package:get/get.dart';
import 'package:simpati_client/cores/models/api_response_model.dart';

class Controller extends GetxController {
  var isPageLoading = false.obs;
  var errorPageLoading = APIErrorResponse().obs;
  var isPageSubmitting = false.obs;
  
  void startLoader() {
    isPageLoading.value = true;
    errorPageLoading.value = APIErrorResponse();
  }

  void endLoader() {
    isPageLoading.value = false;
  }

  void startSubmiting(){
    isPageSubmitting.value = true;
  }

  void stopSubmiting(){
    isPageSubmitting.value = false;
  }
}