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
    Future.delayed(Duration(milliseconds: 500), () {
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

/// Enhanced ReactiveGetView demo showing intelligent selective rebuilding
class CounterView extends ReactiveGetView<CounterController> {
  const CounterView({super.key});

  @override
  Widget buildReactive(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.name.value),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: controller.toggleMessage,
            tooltip: controller.message.value,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Counter section
            if (controller.isVisible.value)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Count: ${controller.count.value}',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      if (controller.isLoading.value)
                        CircularProgressIndicator()
                      else
                        ElevatedButton(
                          onPressed: controller.increment,
                          child: Text('Increment Counter'),
                        ),
                    ],
                  ),
                ),
              )
            else
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Counter is hidden'),
                ),
              ),

            SizedBox(height: 20),

            // Control buttons
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                  onPressed: controller.toggleMessage,
                  child: Text('Toggle Message'),
                ),
                ElevatedButton(
                  onPressed: controller.toggleVisibility,
                  child: Text(controller.isVisible.value
                      ? 'Hide Counter'
                      : 'Show Counter'),
                ),
                ElevatedButton(
                  onPressed: controller.addItem,
                  child: Text('Add Item'),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Search section
            Text('Search Demo:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            TextField(
              onChanged: controller.updateSearchQuery,
              decoration: InputDecoration(
                hintText: 'Type to search...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Search Query: "${controller.searchQuery.value}"',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),

            SizedBox(height: 20),

            // List section
            Text('Dynamic List Demo:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            if (controller.items.isEmpty)
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'No items yet. Add some items or search to see results.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              )
            else
              ...controller.items.asMap().entries.map(
                    (entry) => Card(
                      child: ListTile(
                        title: Text(entry.value),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => controller.removeItem(entry.key),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

/// Demo app showcasing enhanced ReactiveGetView capabilities
class ReactiveGetViewDemo extends StatelessWidget {
  const ReactiveGetViewDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Enhanced ReactiveGetView Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const CounterView(),
      debugShowCheckedModeBanner: false,
    );
  }
}

void main() {
  // Initialize controller
  Get.put(CounterController());

  runApp(const ReactiveGetViewDemo());
}
