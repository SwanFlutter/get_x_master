import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_x_master/get_x_master.dart';

void main() {
  group('GetCupertinoApp Tests', () {
    testWidgets('GetCupertinoApp builds successfully', (tester) async {
      await tester.pumpWidget(
        GetCupertinoApp(
          home: const CupertinoPageScaffold(child: Center(child: Text('Test'))),
        ),
      );

      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('GetCupertinoApp with new features builds successfully', (
      tester,
    ) async {
      await tester.pumpWidget(
        GetCupertinoApp(
          theme: const CupertinoThemeData(
            primaryColor: CupertinoColors.systemBlue,
          ),
          scrollBehavior: const CupertinoScrollBehavior(),
          restorationId: 'test_app',
          home: const CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(middle: Text('Enhanced App')),
            child: Center(child: Text('Enhanced Test')),
          ),
        ),
      );

      expect(find.text('Enhanced App'), findsOneWidget);
      expect(find.text('Enhanced Test'), findsOneWidget);
    });

    testWidgets('GetCupertinoApp.router builds successfully', (tester) async {
      final pages = [
        GetPage(name: '/', page: () => const TestHomePage()),
        GetPage(name: '/second', page: () => const TestSecondPage()),
      ];

      await tester.pumpWidget(
        GetCupertinoApp.router(
          getPages: pages,
          theme: const CupertinoThemeData(
            primaryColor: CupertinoColors.systemBlue,
          ),
          scrollBehavior: const CupertinoScrollBehavior(),
          restorationId: 'router_test_app',
        ),
      );

      expect(find.text('Home Page'), findsOneWidget);
    });

    testWidgets('GetCupertinoApp handles navigation correctly', (tester) async {
      await tester.pumpWidget(
        GetCupertinoApp(home: const TestNavigationPage()),
      );

      expect(find.text('Navigation Test'), findsOneWidget);

      // Test navigation
      await tester.tap(find.text('Go to Second'));
      await tester.pumpAndSettle();

      expect(find.text('Second Page'), findsOneWidget);
    });

    testWidgets('GetCupertinoApp shows alert dialog with squircle', (
      tester,
    ) async {
      await tester.pumpWidget(GetCupertinoApp(home: const TestAlertPage()));

      // Tap button to show alert
      await tester.tap(find.text('Show Alert'));
      await tester.pumpAndSettle();

      // Verify alert is shown
      expect(find.text('Test Alert'), findsOneWidget);
      expect(find.text('This alert uses enhanced features'), findsOneWidget);
    });

    testWidgets('GetCupertinoApp supports theming', (tester) async {
      await tester.pumpWidget(
        GetCupertinoApp(
          theme: const CupertinoThemeData(
            primaryColor: CupertinoColors.systemRed,
            brightness: Brightness.dark,
          ),
          home: const CupertinoPageScaffold(
            child: Center(child: Text('Themed App')),
          ),
        ),
      );

      expect(find.text('Themed App'), findsOneWidget);

      // Verify theme is applied
      final app = tester.widget<CupertinoApp>(find.byType(CupertinoApp));
      expect(app.theme?.primaryColor, CupertinoColors.systemRed);
      expect(app.theme?.brightness, Brightness.dark);
    });
  });
}

class TestHomePage extends StatelessWidget {
  const TestHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Home Page')),
      child: Center(child: Text('Home Page')),
    );
  }
}

class TestSecondPage extends StatelessWidget {
  const TestSecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Second Page')),
      child: Center(child: Text('Second Page')),
    );
  }
}

class TestNavigationPage extends StatelessWidget {
  const TestNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Navigation Test'),
      ),
      child: Center(
        child: CupertinoButton(
          child: const Text('Go to Second'),
          onPressed: () {
            Navigator.of(context).push(
              CupertinoPageRoute(builder: (context) => const TestSecondPage()),
            );
          },
        ),
      ),
    );
  }
}

class TestAlertPage extends StatelessWidget {
  const TestAlertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: CupertinoButton(
          child: const Text('Show Alert'),
          onPressed: () {
            showCupertinoDialog(
              context: context,
              builder:
                  (context) => CupertinoAlertDialog(
                    title: const Text('Test Alert'),
                    content: const Text('This alert uses enhanced features'),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text('OK'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
            );
          },
        ),
      ),
    );
  }
}
