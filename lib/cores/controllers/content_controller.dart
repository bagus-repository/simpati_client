import 'package:simpati_client/cores/controllers/controller.dart';
import 'package:simpati_client/cores/data/providers/store_provider.dart';
import 'package:simpati_client/cores/models/content_model.dart';
import 'package:get/get.dart';
import 'package:simpati_client/cores/models/screen_argument_model.dart';

class ContentController extends Controller {
  var content = Lcontent(
          id: 0,
          type: 'type',
          name: 'name',
          content: 'content',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now())
      .obs;
  final storeProvider = Get.find<StoreProvider>();
  final argument = Get.arguments as ScreenArgument;

  @override
  void onInit() {
    super.onInit();
    loadContent();
  }

  void loadContent() {
    if (argument.link == 'content') {
      if (storeProvider.contentModel != null) {
        content.value = storeProvider.contentModel!.data
            .firstWhere((element) => element.lookupValue == argument.id)
            .lcontent!;
      }
    }
    if (argument.link == 'service') {
      if (storeProvider.serviceModel != null) {
        content.value = storeProvider.serviceModel!.data
            .firstWhere((element) => element.lookupValue == argument.id)
            .lcontent!;
      }
    }
  }
}
