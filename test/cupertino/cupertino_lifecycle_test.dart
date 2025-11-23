import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_x_master/get_x_master.dart';

void main() {
  group('Cupertino Lifecycle Tests', () {
    testWidgets('GetCupertinoApp builds without lifecycle errors', (
      tester,
    ) async {
      await tester.pumpWidget(GetCupertinoApp(home: const TestHomePage()));

      expect(find.text('Test Home'), findsOneWidget);

      // No lifecycle errors should occur
      await tester.pumpAndSettle();
    });

    testWidgets('Controller lifecycle works correctly', (tester) async {
      await tester.pumpWidget(
        GetCupertinoApp(home: const TestControllerPage()),
      );

      expect(find.text('Count: 0'), findsOneWidget);

      // Test increment
      await tester.tap(find.text('+'));
      await tester.pump();

      expect(find.text('Count: 1'), findsOneWidget);

      // Test decrement
      await tester.tap(find.text('-'));
      await tester.pump();

      expect(find.text('Count: 0'), findsOneWidget);
    });

    testWidgets('Navigation works without lifecycle errors', (tester) async {
      await tester.pumpWidget(
        GetCupertinoApp(home: const TestNavigationPage()),
      );

      expect(find.text('First Page'), findsOneWidget);

      // Navigate to second page
      await tester.tap(find.text('Go to Second'));
      await tester.pumpAndSettle();

      expect(find.text('Second Page'), findsOneWidget);

      // Navigate back
      await tester.tap(find.text('Go Back'));
      await tester.pumpAndSettle();

      expect(find.text('First Page'), findsOneWidget);
    });

    testWidgets('No nested apps cause lifecycle errors', (tester) async {
      // This should NOT cause lifecycle errors
      await tester.pumpWidget(GetCupertinoApp(home: const TestSingleAppPage()));

      expect(find.text('Single App'), findsOneWidget);
      await tester.pumpAndSettle();

      // Verify no errors in the widget tree
    });
  });
}

class TestHomePage extends StatelessWidget {
  const TestHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Test Home')),
      child: Center(child: Text('Test Home Page')),
    );
  }
}

class TestController extends GetXController {
  int count = 0;

  void increment() {
    count++;
    update();
  }

  void decrement() {
    count--;
    update();
  }
}

class TestControllerPage extends StatelessWidget {
  const TestControllerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: GetBuilder<TestController>(
          init: TestController(),
          builder: (controller) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Count: ${controller.count}'),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CupertinoButton(
                      onPressed: controller.decrement,
                      child: const Text('-'),
                    ),
                    CupertinoButton(
                      onPressed: controller.increment,
                      child: const Text('+'),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class TestNavigationPage extends StatelessWidget {
  const TestNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('First Page'),
            const SizedBox(height: 20),
            CupertinoButton(
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => const TestSecondPage(),
                  ),
                );
              },
              child: const Text('Go to Second'),
            ),
          ],
        ),
      ),
    );
  }
}

class TestSecondPage extends StatelessWidget {
  const TestSecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Second Page'),
            const SizedBox(height: 20),
            CupertinoButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class TestSingleAppPage extends StatelessWidget {
  const TestSingleAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    // This is correct - no nested GetCupertinoApp
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Single App')),
      child: Center(child: Text('This page does not create nested apps')),
    );
  }
}
