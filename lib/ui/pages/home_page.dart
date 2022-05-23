import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simpati_client/cores/configs/configs.dart';
import 'package:simpati_client/cores/controllers/home_controller.dart';
import 'package:simpati_client/cores/data/constants.dart';
import 'package:simpati_client/cores/models/screen_argument_model.dart';
import 'package:simpati_client/cores/routes/routes.dart';
import 'package:simpati_client/ui/pages/news_detail_page.dart';
import 'package:simpati_client/ui/pages/submenu_page.dart';
import 'package:simpati_client/ui/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final _controller = Get.put(HomeController());
  late Size screenSize;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => _controller.refreshHome(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                        child: Image.asset(
                      ConstantData.LOGO_URL,
                      width: screenSize.width / 3,
                    )),
                  ],
                ),
                dividerHeading(),
                Obx(() => _buildSliders()),
                dividerHeading(),
                _buildMenus(),
                dividerDefault(),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.RIWAYAT_EFILLING_PAGE),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          ConfigColor.secondaryColorVariant,
                          ConfigColor.secondaryColor,
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.chevronCircleRight,
                          color: Colors.white,
                          size: 20.0,
                        ),
                        dividerColDefault(),
                        const Text(
                          'Cek Riwayat Pelayanan Anda',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                dividerHeading(),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Informasi Berita',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      // Text(
                      //   'Lihat Semua',
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 16.0,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                dividerTiny(),
                Obx(
                  () => ListView.builder(
                    controller: _controller.newsScrollCtrl,
                    primary: false,
                    itemCount: _controller.news.length,
                    shrinkWrap: true,
                    itemBuilder: (_, index) => GestureDetector(
                      onTap: () => Get.to(() => NewsDetailPage(news: _controller.news[index])),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        padding:
                            const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          border: Border.all(
                            color: ConfigColor.primaryColor,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 75.0,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: _controller.news[index].thumbnail,
                                  ),
                                ),
                              ),
                            ),
                            dividerColTiny(),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _controller.news[index].title,
                                    maxLines: 2,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  dividerTiny(),
                                  Text(
                                    Bidi.stripHtmlIfNeeded(_controller.news[index].desc).trim(),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if(_controller.prevNews.value)
                      buttonCompact(onPressed: () async{
                        _controller.startSubmiting();
                        _controller.newsPageIndex -= 1;
                        await _controller.loadNews();
                        _controller.stopSubmiting();
                      }, text: 'Sebelumnya', iconData: FontAwesomeIcons.angleLeft, isSubmitting: _controller.isPageSubmitting.value),
                      if(_controller.nextNews.value)
                      buttonCompact(onPressed: () async{
                        _controller.startSubmiting();
                        _controller.newsPageIndex += 1;
                        await _controller.loadNews();
                        _controller.stopSubmiting();
                      }, text: 'Selanjutnya', iconData: FontAwesomeIcons.angleRight, isSubmitting: _controller.isPageSubmitting.value),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSliders() {
    if (_controller.sliders.isNotEmpty) {
      return Container(
        margin: const EdgeInsets.only(top: 12.0),
        height: screenSize.height * 0.2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: CarouselSlider(
                  items: _controller.sliders
                      .map((el) => GestureDetector(
                            onTap: () => {},
                            child: Stack(
                              alignment: Alignment.center,
                              fit: StackFit.expand,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(5.0),
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8.0)),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        width: 500.0,
                                        imageUrl: el.fileLink,
                                      )),
                                ),
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: Container(
                                        height: 24.0,
                                        width: double.infinity,
                                        margin: const EdgeInsets.only(bottom: 4.0),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            end: Alignment.topCenter,
                                            begin: Alignment.bottomCenter,
                                            colors: [
                                              Colors.grey[700]!,
                                              Colors.grey[400]!
                                                  .withOpacity(0.3),
                                            ],
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(8.0),
                                            bottomRight: Radius.circular(8.0),
                                          ),
                                        ),
                                        child: Text(
                                          el.judul,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ))
                      .toList(),
                  carouselController: _controller.carouselController,
                  options: CarouselOptions(
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      pauseAutoPlayOnTouch: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      viewportFraction: 0.7,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 1500),
                      autoPlayInterval: const Duration(seconds: 5),
                      onPageChanged: (index, reason) =>
                          _controller.sliderIndex.value = index),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _controller.sliders
                  .asMap()
                  .entries
                  .map((e) => Obx(
                        () => AnimatedContainer(
                          curve: Curves.fastOutSlowIn,
                          width: _controller.sliderIndex.value == e.key
                              ? 24.0
                              : 12.0,
                          height: 12.0,
                          duration: const Duration(milliseconds: 500),
                          margin: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            color: _controller.sliderIndex.value == e.key
                                ? ConfigColor.secondaryColor.withOpacity(0.9)
                                : Colors.grey.withOpacity(0.4),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(top: 12.0),
      height: screenSize.height * 0.2,
      color: Colors.grey,
    );
  }

  Widget _buildMenus() {
    return SizedBox(
      width: double.infinity,
      child: Obx(
        () => GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          crossAxisCount: 4,
          shrinkWrap: true,
          childAspectRatio: 1 / 1.2,
          children: _controller.menus
              .map((element) => GestureDetector(
                onTap: (){
                    Get.toNamed(element.menuLink,arguments: ScreenArgument(
                      stringPayload: element.menuName,
                      listPayload: element.submenus,
                      id: element.menuId,
                      link: 'content'
                    ));
                },
                child: Container(
                      margin: const EdgeInsets.all(4.0),
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                            flex: 2,
                            child: AspectRatio(
                              aspectRatio: 1.0,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: element.menuColor,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Icon(
                                  element.menuIcon,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Flexible(
                            flex: 1,
                            child: Text(
                              element.menuName,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              ))
              .toList(),
        ),
      ),
    );
  }
}
