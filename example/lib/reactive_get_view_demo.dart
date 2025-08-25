import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

/// Simple controller with observable variables
class DemoController extends GetXController {
  late var count = 0.obs;
  final message = 'Hello ReactiveGetView!'.obs;
  final isVisible = true.obs;

  void increment() => count++;
  void toggleMessage() =>
      message.value = message.value == 'Hello ReactiveGetView!'
          ? 'ReactiveGetView is Amazing!'
          : 'Hello ReactiveGetView!';
  void toggleVisibility() => isVisible.value = !isVisible.value;
}

/// ReactiveGetView - automatically reactive to all observable changes
class DemoView extends ReactiveGetView<DemoController> {
  const DemoView({super.key});

  @override
  Widget buildReactive(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.message.value),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (controller.isVisible.value)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Count: ${controller.count.value}',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.increment,
              child: const Text('Increment Counter'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: controller.toggleMessage,
              child: const Text('Toggle Message'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: controller.toggleVisibility,
              child: Text(
                  controller.isVisible.value ? 'Hide Counter' : 'Show Counter'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Demo app
class ReactiveGetViewDemo extends StatelessWidget {
  const ReactiveGetViewDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReactiveGetView Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const DemoView(),
    );
  }
}

void main() {
  // Initialize controller
  Get.put(DemoController());

  runApp(const ReactiveGetViewDemo());
}
