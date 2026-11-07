import 'package:get_x_master/get_x_master.dart';
import 'package:material_ui/material_ui.dart';

import 'hub/hub_app.dart';
import 'hub/hub_settings.dart';

/// Single entry point for every example of get_x_master.
///
/// Run with `flutter run` and open any demo from the list. The switch in the
/// top bar swaps the whole app between GetMaterialApp and GetCupertinoApp so
/// each example can be tested under both design packages
/// (material_ui and cupertino_ui).
///
/// The previous standalone demo entry point is kept in `main_classic.dart`.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(HubSettings(), permanent: true);
  runApp(const HubApp());
}
