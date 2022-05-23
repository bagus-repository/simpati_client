import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:simpati_client/cores/routes/routes.dart';
import 'package:simpati_client/ui/pages/pages.dart';

class CorePages {
  static final GetPage unknownPage =
      GetPage(name: Routes.UNKNOWN, page: () => NotFoundPage());

  static final pages = <GetPage>[
    GetPage(
      name: Routes.INITIAL,
      page: () => SplashScreenPage(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
    ),
    GetPage(
      name: Routes.ONBOARDING_PAGE,
      page: () => OnboardingPage(),
    ),
    GetPage(
      name: Routes.LOGIN_PAGE,
      page: () => LoginPage(),
    ),
    GetPage(
      name: Routes.REGISTER_PAGE,
      page: () => RegisterPage(),
    ),
    GetPage(
      name: Routes.NEWUPDATE_PAGE,
      page: () => NewUpdatePage(),
    ),
    GetPage(
      name: Routes.PROFIL_PAGE,
      page: () => ContentPage(),
    ),
    GetPage(
      name: Routes.STRUKTUR_PAGE,
      page: () => ContentPage(),
    ),
    GetPage(
      name: Routes.PELAYANAN_PAGE,
      page: () => PelayananPage(),
    ),
    GetPage(
      name: Routes.SUB_MENU,
      page: () => SubmenuPage(),
    ),
    GetPage(
      name: Routes.EFILLING_PAGE,
      page: () => EfillingPage(),
    ),
    GetPage(
      name: Routes.RIWAYAT_EFILLING_PAGE,
      page: () => RiwayatServicePage(),
    ),
  ];
}
