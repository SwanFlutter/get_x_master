import 'package:get_x_master/get_x_master.dart';
import 'package:material_ui/material_ui.dart';
import 'package:toastification/toastification.dart';

import '../bindings/bindings.dart';
import '../cupertino/cupertino_features_example.dart';
import '../screen/login.dart';
import 'hub_page.dart';
import 'hub_settings.dart';

/// Root of the examples hub. Rebuilds as GetMaterialApp or GetCupertinoApp
/// depending on [HubSettings.cupertinoShell].
class HubApp extends StatelessWidget {
  const HubApp({super.key});

  /// Named routes used by some examples (Get.toNamed / Get.offAllNamed).
  static final List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    GetPage(name: '/squircle', page: () => const SquircleExamplePage()),
    GetPage(name: '/sheet', page: () => const SheetExamplePage()),
    GetPage(name: '/navigation', page: () => const NavigationExamplePage()),
    GetPage(name: '/login', page: () => const LoginPage()),
  ];

  @override
  Widget build(BuildContext context) {
    final settings = Get.find<HubSettings>();

    return Obx(() {
      if (settings.cupertinoShell.value) {
        return ToastificationWrapper(
          child: GetCupertinoApp(
            title: 'GetX Master Examples (Cupertino)',
            debugShowCheckedModeBanner: false,
            initialBinding: MyBinding(),
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            getPages: pages,
            home: const HubPage(),
          ),
        );
      }
      return ToastificationWrapper(
        child: GetMaterialApp(
          title: 'GetX Master Examples (Material)',
          debugShowCheckedModeBanner: false,
          initialBinding: MyBinding(),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          getPages: pages,
          home: const HubPage(),
        ),
      );
    });
  }
}
