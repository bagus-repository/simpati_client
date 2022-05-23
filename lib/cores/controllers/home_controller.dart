import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simpati_client/cores/configs/colors_config.dart';
import 'package:simpati_client/cores/controllers/controller.dart';
import 'package:simpati_client/cores/data/providers/api_provider.dart';
import 'package:simpati_client/cores/data/providers/store_provider.dart';
import 'package:simpati_client/cores/models/api_response_model.dart';
import 'package:simpati_client/cores/models/content_model.dart';
import 'package:simpati_client/cores/models/menu_model.dart';
import 'package:simpati_client/cores/models/news_model.dart';
import 'package:simpati_client/cores/models/screen_argument_model.dart';
import 'package:simpati_client/cores/models/slider_model.dart';
import 'package:get/get.dart';
import 'package:simpati_client/cores/routes/routes.dart';
import 'package:simpati_client/cores/utils/alert_util.dart';

class HomeController extends Controller {
  var sliders = <Slider>[].obs;
  var sliderIndex = 0.obs;
  final _httpClient = Get.find<APIProvider>();
  final carouselController = CarouselController();
  var menus = <MenuModel>[].obs;
  var news = <News>[].obs;
  var newsPageIndex = 1;
  var prevNews = false.obs;
  var nextNews = false.obs;
  final newsScrollCtrl = ScrollController();
  final storeProvider = Get.find<StoreProvider>();

  @override
  void onInit() {
    super.onInit();
    refreshHome();
  }

  Future<void> refreshHome() async {
    loadMenus();
    loadSliders();
    loadNews();
    await loadContent();
    await loadService();
  }

  Future<void> loadSliders() async {
    try {
      var response = await _httpClient.request(
          requestMethod: RequestMethod.raw,
          method: Method.get,
          urlPath: '/getSliders');
      if (response is APIErrorResponse) {
        AlertUtil.showSnackbar('Error', response.msg, AlertStatus.error);
      } else {
        if (response['status'] == 'success') {
          sliders
            ..assignAll(SliderModel.fromJson(response).data)
            ..refresh();
        } else {
          AlertUtil.showSnackbar('Error', response['msg'], AlertStatus.error);
        }
      }
    } catch (e) {
      AlertUtil.showSnackbar('Error', e.toString(), AlertStatus.error);
    }
  }

  Future<void> loadNews() async {
    try {
      var response = await _httpClient.request(
          requestMethod: RequestMethod.auth,
          method: Method.get,
          urlPath: '/news/list',
          params: {'page': newsPageIndex});
      if (response is APIErrorResponse) {
        AlertUtil.showSnackbar('Error', response.msg, AlertStatus.error);
      } else {
        if (response['status'] == 'success') {
          var newsModel = NewsModel.fromJson(response);
          nextNews.value = newsModel.data.to != null ? true : false;
          if (newsModel.data.data.isNotEmpty) {
            prevNews.value = newsPageIndex > 1 ? true : false;
            news.assignAll(newsModel.data.data);
          }
        } else {
          AlertUtil.showSnackbar('Error', response['msg'], AlertStatus.error);
        }
      }
    } catch (e) {
      AlertUtil.showSnackbar('Error', e.toString(), AlertStatus.error);
    }
  }

  void loadMenus() {
    menus.assignAll([
      MenuModel(
        menuId: 'profil',
        menuLink: Routes.SUB_MENU,
        menuName: 'Profil',
        menuColor: ConfigColor.getRandomColor(RandomColorMode.dark),
        menuIcon: FontAwesomeIcons.anchor,
        submenus: [
          ScreenArgument(
              stringPayload: 'Profil Kantor',
              link: Routes.PROFIL_PAGE,
              id: 'profil'),
          ScreenArgument(
              stringPayload: 'Struktur & Tupoksi',
              link: Routes.STRUKTUR_PAGE,
              id: 'profil-tup'),
        ],
      ),
      MenuModel(
        menuId: 'persyaratan',
        menuLink: Routes.PELAYANAN_PAGE,
        menuName: 'Persyaratan Layanan',
        menuColor: ConfigColor.getRandomColor(RandomColorMode.dark),
        menuIcon: FontAwesomeIcons.anchor,
      ),
      MenuModel(
          menuId: 'efilling',
          menuLink: Routes.EFILLING_PAGE,
          menuName: 'E-filling',
          menuColor: ConfigColor.getRandomColor(RandomColorMode.dark),
          menuIcon: FontAwesomeIcons.anchor),
      MenuModel(
          menuId: 'kontak',
          menuLink: Routes.PROFIL_PAGE,
          menuName: 'Kontak',
          menuColor: ConfigColor.getRandomColor(RandomColorMode.dark),
          menuIcon: FontAwesomeIcons.anchor),
    ]);
  }

  Future<void> loadContent() async {
    try {
      var response = await _httpClient.request(
          requestMethod: RequestMethod.auth,
          method: Method.get,
          urlPath: '/getContents');
      if (response is APIErrorResponse) {
        AlertUtil.showSnackbar('Error', response.msg, AlertStatus.error);
      } else {
        if (response['status'] == 'success') {
          storeProvider.contentModel = ContentModel.fromJson(response);
        } else {
          AlertUtil.showSnackbar('Error', response['msg'], AlertStatus.error);
        }
      }
    } catch (e) {
      AlertUtil.showSnackbar('Error', e.toString(), AlertStatus.error);
    }
  }

  Future<void> loadService() async {
    try {
      var response = await _httpClient.request(
          requestMethod: RequestMethod.auth,
          method: Method.get,
          urlPath: '/efilling/GetServiceList');
      if (response is APIErrorResponse) {
        AlertUtil.showSnackbar('Error', response.msg, AlertStatus.error);
      } else {
        if (response['status'] == 'success') {
          storeProvider.serviceModel = ContentModel.fromJson(response);
        } else {
          AlertUtil.showSnackbar('Error', response['msg'], AlertStatus.error);
        }
      }
    } catch (e) {
      AlertUtil.showSnackbar('Error', e.toString(), AlertStatus.error);
    }
  }
}
