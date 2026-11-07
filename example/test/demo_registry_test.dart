import 'package:example/hub/demo_entry.dart';
import 'package:example/hub/demo_registry.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('registry lists every example exactly once', () {
    expect(demoRegistry, isNotEmpty);
    final titles = demoRegistry.map((e) => e.title).toList();
    expect(titles.toSet().length, titles.length, reason: 'titles must be unique');
  });

  test('every category has at least one example', () {
    for (final category in DemoCategory.values) {
      expect(
        demoRegistry.any((e) => e.category == category),
        isTrue,
        reason: '${category.label} is empty',
      );
    }
  });

  test('cupertino demos live in the Cupertino category', () {
    for (final e in demoRegistry.where((e) => e.category == DemoCategory.cupertino)) {
      expect(e.style, DemoStyle.cupertino);
    }
  });
}
