import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simpati_client/cores/configs/configs.dart';
import 'package:simpati_client/cores/controllers/fullscreen_image_controller.dart';
import 'package:simpati_client/cores/models/api_response_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:simpati_client/ui/widgets/widgets.dart';

class FullscreenImagePage extends StatelessWidget {
final List<String> imgUrl;
  final bool isOutSide;
  final controller =
      Get.put(FullscreenImageController());

  FullscreenImagePage({Key? key, required this.imgUrl, this.isOutSide = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isOutSide) {
      controller.loadHeaderImage();
    }
    return Scaffold(
      backgroundColor: ConfigColor.backgroundColor,
      appBar: defaultAppBar(title: 'Lihat Foto'),
      body: Obx(() {
        if (controller.isPageLoading.value) {
          return pageLoader();
        }
        if (controller.headers.isNotEmpty || isOutSide == true) {
          return Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              PhotoViewGallery.builder(
                builder: (context, index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(
                      imgUrl[index],
                      headers:
                          isOutSide == true ? controller.headers : null,
                    ),
                    minScale: PhotoViewComputedScale.contained * 0.8,
                  );
                },
                loadingBuilder: (context, _progress) => Center(
                  child: SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: pageLoader(),
                  ),
                ),
                itemCount: imgUrl.length,
                onPageChanged: controller.onPageChanged,
                scrollDirection: Axis.horizontal,
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Foto ke ' +
                      controller.counterIndex.value.toString() +
                      ' dari ' +
                      imgUrl.length.toString(),
                  style: const TextStyle(
                    color: ConfigColor.secondaryTextColor,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          );
        } else {
          return errorPageLoader(
              error: APIErrorResponse(
                  code: 0,
                  title: 'Platform',
                  msg: 'Authorized Headers Not Found'),
              callback: () => controller.loadHeaderImage(), context: context);
        }
      }),
    );
  }
}