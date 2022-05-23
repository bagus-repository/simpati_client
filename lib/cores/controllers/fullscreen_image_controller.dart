import 'package:get/get.dart';
import 'package:simpati_client/cores/data/providers/api_provider.dart';

class FullscreenImageController extends GetxController {
  final apiProvider = Get.find<APIProvider>();
  Map<String, String> headers = Map<String, String>().obs;
  var counterIndex = 1.obs;
  var isPageLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  onPageChanged(int index) {
      counterIndex.value = index + 1;
  }

  loadHeaderImage() async {
    isPageLoading.value = true;
    headers.assignAll(await apiProvider.getAuthorizedHeader());
    isPageLoading.value = false;
  }
}