import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_x_master/get_x_master.dart';

import 'utils/wrapper.dart';

void main() {
  testWidgets("Test dispose dependencies with unnamed routes", (tester) async {
    await tester.pumpWidget(Wrapper(child: Container()));

    expect(Get.isRegistered<Controller2>(), false);
    expect(Get.isRegistered<Controller>(), false);

    Get.to(const First());

    await tester.pumpAndSettle();

    expect(find.byType(First), findsOneWidget);

    expect(Get.isRegistered<Controller>(), true);

    Get.to(const Second());

    await tester.pumpAndSettle();

    expect(find.byType(Second), findsOneWidget);

    expect(Get.isRegistered<Controller>(), true);
    expect(Get.isRegistered<Controller2>(), true);

    Get.back();

    await tester.pumpAndSettle();

    expect(find.byType(First), findsOneWidget);

    expect(Get.isRegistered<Controller>(), true);
    expect(Get.isRegistered<Controller2>(), false);

    Get.back();

    await tester.pumpAndSettle();

    expect(Get.isRegistered<Controller>(), false);
    expect(Get.isRegistered<Controller2>(), false);
  });
}

class Controller extends GetXController {}

class Controller2 extends GetXController {}

class First extends StatelessWidget {
  const First({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Controller());
    return const Center(child: Text("first"));
  }
}

class Second extends StatelessWidget {
  const Second({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Controller2());
    return const Center(child: Text("second"));
  }
}
