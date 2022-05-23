import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:simpati_client/cores/configs/configs.dart';
import 'package:simpati_client/cores/models/news_model.dart';
import 'package:simpati_client/cores/utils/format_utils.dart';
import 'package:simpati_client/ui/widgets/dividers.dart';

class NewsDetailPage extends StatelessWidget {
  final News news;
  const NewsDetailPage({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                decoration: BoxDecoration(
                  color: ConfigColor.primaryColor,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            dividerHeading(),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: ConfigColor.primaryColor,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: CachedNetworkImage(
                  height: screenSize.height / 5,
                  imageUrl: news.thumbnail,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            dividerDefault(),
            Text(
              news.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.black,
              ),
              textAlign: TextAlign.start,
            ),
            Text(
              'Diperbarui pada ${FormatUtil.formatIdDate(FormatDateType.common_time, news.createdAt)}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
              textAlign: TextAlign.start,
            ),
            dividerTiny(),
            Html(
              data: news.desc,
            ),
          ],
        ),
      )),
    );
  }
}
