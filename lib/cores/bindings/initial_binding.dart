import 'package:get/get.dart';
import 'package:simpati_client/cores/data/providers/api_provider.dart';
import 'package:simpati_client/cores/data/providers/store_provider.dart';
import 'package:simpati_client/cores/services/platform_service.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<PlatformService>(PlatformService(), permanent: true);
    Get.put<APIProvider>(APIProvider(), permanent: true);
    Get.put<StoreProvider>(StoreProvider(), permanent: true);
  }
  
}