import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

/// Example controller with multiple reactive variables
class EnhancedController extends GetXController {
  // Regular observable variables
  final RxInt count = 0.obs;
  final RxString message = 'Hello GetX'.obs;
  final RxBool isLoading = false.obs;
  final RxDouble progress = 0.0.obs;

  // List of items
  final RxList<String> items = <String>[].obs;

  // Complex object
  final Rx<UserModel> user = UserModel(name: 'John', age: 25).obs;

  void increment() {
    count.value++;
    message.value = 'Count is now ${count.value}';
  }

  void toggleLoading() {
    isLoading.value = !isLoading.value;
    if (isLoading.value) {
      _simulateProgress();
    } else {
      progress.value = 0.0;
    }
  }

  void _simulateProgress() async {
    progress.value = 0.0;
    while (isLoading.value && progress.value < 1.0) {
      await Future.delayed(const Duration(milliseconds: 100));
      progress.value += 0.1;
    }
    if (progress.value >= 1.0) {
      isLoading.value = false;
      message.value = 'Loading completed!';
    }
  }

  void addItem() {
    items.add('Item ${items.length + 1}');
  }

  void removeItem(int index) {
    if (index >= 0 && index < items.length) {
      items.removeAt(index);
    }
  }

  void updateUser() {
    user.value = UserModel(
      name: user.value.name == 'John' ? 'Jane' : 'John',
      age: user.value.age + 1,
    );
  }
}

class UserModel {
  final String name;
  final int age;

  UserModel({required this.name, required this.age});

  @override
  String toString() => 'User(name: $name, age: $age)';
}

/// Example 1: Using GetBuilderObs to observe multiple reactive variables
class GetBuilderObsExample extends StatelessWidget {
  const GetBuilderObsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GetBuilderObs Example')),
      body: GetBuilderObs<EnhancedController>(
        init: EnhancedController(),
        // Specify which observables to watch
        observables: [
          Get.find<EnhancedController>().count,
          Get.find<EnhancedController>().message,
          Get.find<EnhancedController>().isLoading,
          Get.find<EnhancedController>().progress,
        ],
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Count display
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Count: ${controller.count.value}',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          controller.message.value,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Loading indicator
                if (controller.isLoading.value) ...[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text('Loading...'),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: controller.progress.value,
                          ),
                          const SizedBox(height: 8),
                          Text('${(controller.progress.value * 100).toInt()}%'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: controller.increment,
                        child: const Text('Increment'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: controller.toggleLoading,
                        child: Text(
                          controller.isLoading.value ? 'Stop' : 'Start Loading',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Example 2: Using MultiObx for multiple observables without controller
class MultiObxExample extends StatelessWidget {
  const MultiObxExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Create some standalone reactive variables
    final RxString title = 'MultiObx Example'.obs;
    final RxInt counter = 0.obs;
    final RxBool isDarkMode = false.obs;

    return Scaffold(
      appBar: AppBar(title: const Text('MultiObx Example')),
      body: MultiObx(
        // Watch multiple observables
        observables: [title, counter, isDarkMode],
        builder: () {
          return Theme(
            data: isDarkMode.value ? ThemeData.dark() : ThemeData.light(),
            child: Container(
              color: isDarkMode.value ? Colors.black : Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title.value,
                    style: TextStyle(
                      fontSize: 24,
                      color: isDarkMode.value ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Counter: ${counter.value}',
                    style: TextStyle(
                      fontSize: 18,
                      color: isDarkMode.value ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => counter.value++,
                        child: const Text('Increment'),
                      ),
                      ElevatedButton(
                        onPressed: () => counter.value--,
                        child: const Text('Decrement'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SwitchListTile(
                    title: const Text('Dark Mode'),
                    value: isDarkMode.value,
                    onChanged: (value) => isDarkMode.value = value,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      title.value = title.value == 'MultiObx Example'
                          ? 'Updated Title!'
                          : 'MultiObx Example';
                    },
                    child: const Text('Toggle Title'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Example 3: Using BuildContext extensions
class ContextExtensionsExample extends StatelessWidget {
  const ContextExtensionsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Context Extensions Example')),
      body: GetBuilder<EnhancedController>(
        init: EnhancedController(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Controller Access:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Controller found: ${context.findOrNull<EnhancedController>() != null}',
                        ),
                        Text(
                          'Controller registered: ${context.isControllerRegistered<EnhancedController>()}',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.showSnackbar('Hello from context extension!');
                  },
                  child: const Text('Show Snackbar'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.push(const SecondPage());
                  },
                  child: const Text('Navigate to Second Page'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('This is the second page'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
