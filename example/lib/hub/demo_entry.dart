import 'package:material_ui/material_ui.dart';

/// Group a demo belongs to on the hub page.
enum DemoCategory {
  state('State & Reactive'),
  navigation('Navigation'),
  responsive('Responsive'),
  network('Network'),
  forms('Forms & Validation'),
  ui('UI & Sheets'),
  cupertino('Cupertino'),
  screens('Full Screens');

  const DemoCategory(this.label);
  final String label;
}

/// Which design system a demo was written against.
enum DemoStyle { material, cupertino }

/// One runnable example on the hub page.
class DemoEntry {
  const DemoEntry({
    required this.title,
    required this.subtitle,
    required this.category,
    required this.builder,
    this.style = DemoStyle.material,
    this.prepare,
  });

  final String title;
  final String subtitle;
  final DemoCategory category;
  final DemoStyle style;
  final WidgetBuilder builder;

  /// Registers any controller/service the demo expects, right before opening it.
  final void Function()? prepare;
}
