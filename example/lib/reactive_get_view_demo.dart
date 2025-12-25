import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

/// Enhanced controller with all reactive properties for the demo
class CounterController extends GetXController {
  // Basic reactive properties
  final count = 0.obs;
  final name = 'Smart Counter App'.obs;
  final isLoading = false.obs;
  final searchQuery = ''.obs;

  // Additional demo properties
  final message = 'Hello ReactiveGetView!'.obs;
  final isVisible = true.obs;
  final items = <String>[].obs;

  void increment() {
    isLoading.value = true;
    // Simulate async operation
    Future.delayed(const Duration(milliseconds: 500), () {
      count.value++;
      isLoading.value = false;
    });
  }

  void changeName(String newName) => name.value = newName;

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    // Simulate search results
    if (query.isNotEmpty) {
      items.assignAll([
        'Result 1 for "$query"',
        'Result 2 for "$query"',
        'Result 3 for "$query"',
      ]);
    } else {
      items.clear();
    }
  }

  void toggleMessage() =>
      message.value = message.value == 'Hello ReactiveGetView!'
          ? 'ReactiveGetView is Amazing!'
          : 'Hello ReactiveGetView!';

  void toggleVisibility() => isVisible.value = !isVisible.value;

  void addItem() {
    items.add('Item ${items.length + 1}');
  }

  void removeItem(int index) {
    if (index < items.length) {
      items.removeAt(index);
    }
  }
}

/// Demo app showcasing enhanced ReactiveGetView capabilities
/// این صفحه به صورت مستقل کار می‌کند و نیازی به GetMaterialApp جداگانه ندارد
class ReactiveGetViewDemo extends StatelessWidget {
  const ReactiveGetViewDemo({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is available
    if (!Get.isRegistered<CounterController>()) {
      Get.put(CounterController());
    }

    return const CounterViewPage();
  }
}

/// Counter view using GetBuilder with Obx for reactive updates
class CounterViewPage extends StatelessWidget {
  const CounterViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CounterController>(
      init: Get.isRegistered<CounterController>() ? null : CounterController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Obx(() => Text(controller.name.value)),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            actions: [
              Obx(() => IconButton(
                    icon: const Icon(Icons.info),
                    onPressed: controller.toggleMessage,
                    tooltip: controller.message.value,
                  )),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Counter section
                Obx(() => controller.isVisible.value
                    ? Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Obx(() => Text(
                                    'Count: ${controller.count.value}',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                              const SizedBox(height: 16),
                              Obx(() => controller.isLoading.value
                                  ? const CircularProgressIndicator()
                                  : ElevatedButton(
                                      onPressed: controller.increment,
                                      child: const Text('Increment Counter'),
                                    )),
                            ],
                          ),
                        ),
                      )
                    : const Card(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('Counter is hidden'),
                        ),
                      )),

                const SizedBox(height: 20),

                // Control buttons
                Obx(() => Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ElevatedButton(
                          onPressed: controller.toggleMessage,
                          child: const Text('Toggle Message'),
                        ),
                        ElevatedButton(
                          onPressed: controller.toggleVisibility,
                          child: Text(
                            controller.isVisible.value
                                ? 'Hide Counter'
                                : 'Show Counter',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: controller.addItem,
                          child: const Text('Add Item'),
                        ),
                      ],
                    )),

                const SizedBox(height: 20),

                // Search section
                const Text(
                  'Search Demo:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  onChanged: controller.updateSearchQuery,
                  decoration: const InputDecoration(
                    hintText: 'Type to search...',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                const SizedBox(height: 8),
                Obx(() => Text(
                      'Search Query: "${controller.searchQuery.value}"',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    )),

                const SizedBox(height: 20),

                // List section
                const Text(
                  'Dynamic List Demo:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Obx(() => controller.items.isEmpty
                    ? Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'No items yet. Add some items or search to see results.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      )
                    : Column(
                        children: controller.items.asMap().entries.map(
                          (entry) {
                            return Card(
                              child: ListTile(
                                title: Text(entry.value),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () =>
                                      controller.removeItem(entry.key),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      )),

                const SizedBox(height: 20),

                // Message display
                Obx(() => Card(
                      color: Colors.blue.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            const Icon(Icons.message, color: Colors.blue),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                controller.message.value,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
