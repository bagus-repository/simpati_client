import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:simpati_client/cores/controllers/content_controller.dart';
import 'package:simpati_client/cores/utils/format_utils.dart';
import 'package:simpati_client/ui/pages/fullscreen_image_page.dart';
import 'package:simpati_client/ui/widgets/widgets.dart';

class ContentPage extends StatelessWidget {
  final _controller = Get.put(ContentController(),
      tag: FormatUtil.getRandomString(type: RandomType.classId));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(title: _controller.argument.stringPayload ?? ''),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Html(
              data: _controller.content.value.content,
              onImageTap: (url, context, attributes, element) => Get.to(() => FullscreenImagePage(imgUrl: [url!], isOutSide: true,)),
            ),
          ],
        ),
      ),
    );
  }
}
