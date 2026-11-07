import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:get_x_master/get_x_master.dart';
import 'package:material_ui/material_ui.dart';

import 'demo_entry.dart';
import 'hub_settings.dart';

/// Wraps a demo so it works no matter which app shell (GetMaterialApp or
/// GetCupertinoApp) is running and which design system the demo uses.
///
/// - Material demos inside the Cupertino shell get a Theme, a
///   ScaffoldMessenger and a transparent Material ancestor.
/// - Cupertino demos inside the Material shell get a CupertinoTheme.
class DemoHost extends StatelessWidget {
  const DemoHost({super.key, required this.style, required this.child});

  final DemoStyle style;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final settings = Get.find<HubSettings>();

    if (style == DemoStyle.material && settings.cupertinoShell.value) {
      return Theme(
        data: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        child: ScaffoldMessenger(
          child: Material(type: MaterialType.transparency, child: child),
        ),
      );
    }

    if (style == DemoStyle.cupertino && !settings.cupertinoShell.value) {
      return CupertinoTheme(
        data: const CupertinoThemeData(),
        child: child,
      );
    }

    return child;
  }
}
