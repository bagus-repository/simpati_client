import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'cores/bindings/initial_binding.dart';
import 'cores/routes/pages.dart';
import 'cores/routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    Intl.defaultLocale = 'id_ID';
    initializeDateFormatting();
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Simpati Client',
      locale: const Locale('id', 'ID'),
      initialRoute: Routes.INITIAL,
      unknownRoute: CorePages.unknownPage,
      getPages: CorePages.pages,
      initialBinding: InitialBinding(),
      defaultTransition: Transition.cupertino,
      routingCallback: (_) => print('Route: ${_?.current ?? 'Unknown Route'}'),
      navigatorObservers: const [],
      debugShowCheckedModeBanner: false,
    );
  }
}