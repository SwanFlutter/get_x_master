import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

/// Example controller with observable variables
class CounterController extends GetXController {
  // Observable variables that will trigger UI updates
  final count = 0.obs;
  final name = 'Smart Counter'.obs;
  final isLoading = false.obs;
  final backgroundColor = Colors.blue.obs;

  void increment() {
    count.value++;
  }

  void decrement() {
    if (count.value > 0) {
      count.value--;
    }
  }

  void changeName(String newName) {
    name.value = newName;
  }

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  void changeBackgroundColor() {
    backgroundColor.value =
        backgroundColor.value == Colors.blue ? Colors.green : Colors.blue;
  }

  void reset() {
    count.value = 0;
    name.value = 'Smart Counter';
    isLoading.value = false;
    backgroundColor.value = Colors.blue;
  }
}

/// Example using ReactiveGetView - automatically reactive to all observable changes
class CounterView extends ReactiveGetView<CounterController> {
  const CounterView({super.key});

  @override
  Widget build() {
    // No need to wrap in Obx() - ReactiveGetView handles it automatically!
    return Scaffold(
      backgroundColor: controller.backgroundColor.value,
      appBar: AppBar(
        title: Text(controller.name.value),
        backgroundColor: controller.backgroundColor.value.withOpacity(0.8),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (controller.isLoading.value)
              const CircularProgressIndicator()
            else
              Text(
                'Count: ${controller.count.value}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: controller.decrement,
                  child: const Icon(Icons.remove),
                ),
                ElevatedButton(
                  onPressed: controller.increment,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controller.changeName(
                  controller.name.value == 'Smart Counter'
                      ? 'Reactive Counter'
                      : 'Smart Counter'),
              child: const Text('Toggle Name'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: controller.toggleLoading,
              child: Text(
                  controller.isLoading.value ? 'Hide Loading' : 'Show Loading'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: controller.changeBackgroundColor,
              child: const Text('Change Background'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: controller.reset,
              child: const Text('Reset All'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Comparison: Traditional GetView (requires Obx wrapping)
class TraditionalCounterView extends GetView<CounterController> {
  const TraditionalCounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        // Need Obx for reactive background color
        backgroundColor: controller.backgroundColor.value,
        appBar: AppBar(
          // Need Obx for reactive title
          title: Obx(() => Text(controller.name.value)),
          backgroundColor: controller.backgroundColor.value.withOpacity(0.8),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Need Obx for reactive loading state
              Obx(() => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : Text(
                      'Count: ${controller.count.value}',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    )),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: controller.decrement,
                    child: const Icon(Icons.remove),
                  ),
                  ElevatedButton(
                    onPressed: controller.increment,
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => controller.changeName(
                    controller.name.value == 'Smart Counter'
                        ? 'Reactive Counter'
                        : 'Smart Counter'),
                child: const Text('Toggle Name'),
              ),
              const SizedBox(height: 10),
              // Need Obx for reactive button text
              Obx(() => ElevatedButton(
                    onPressed: controller.toggleLoading,
                    child: Text(controller.isLoading.value
                        ? 'Hide Loading'
                        : 'Show Loading'),
                  )),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: controller.changeBackgroundColor,
                child: const Text('Change Background'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: controller.reset,
                child: const Text('Reset All'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Example app demonstrating ReactiveGetView
class ReactiveGetViewExampleApp extends StatelessWidget {
  const ReactiveGetViewExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReactiveGetView Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CounterView(),
    );
  }
}

void main() {
  // Initialize the controller
  Get.put(CounterController());

  runApp(const ReactiveGetViewExampleApp());
}
