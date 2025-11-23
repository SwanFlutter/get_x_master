import 'package:example/responsive_demo.dart';
import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

class Screen extends StatelessWidget {
  const Screen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Screen')),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 35,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.to(
                  () => Screen2(),
                  condition: ConditionalNavigation(
                    condition: isPlatform,
                    truePage: () => ResponsiveDemo(),
                    falsePage: () => Screen2(),
                  ),
                );
              },
              child: Text('Screen2'),
            ),
          ],
        ),
      ),
    );
  }

  bool isPlatform() {
    late bool isPlatform;
    if (GetPlatform.isAndroid) {
      isPlatform = true;
    } else if (GetPlatform.isWindows) {
      isPlatform = false;
    } else {
      throw Exception('Platform not supported');
    }
    return isPlatform;
  }
}

class Screen2 extends StatelessWidget {
  const Screen2({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Screen2')),
      body: Center(child: Text('ConditionFalsePage')),
    );
  }
}
