import 'package:example/reactive_get_view_demo.dart';
import 'package:example/test_error_handling.dart';
import 'package:example/test_expandable_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize controllers
  Get.put(CounterController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX Master Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: const DemoHomePage(),
    );
  }
}

class DemoHomePage extends StatelessWidget {
  const DemoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GetX Master Demos'),
        centerTitle: true,
        elevation: 2,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDemoCard(
            context,
            title: 'Error Handling Demo',
            subtitle: 'Advanced error handling with Result pattern',
            icon: Icons.error_outline,
            color: Colors.red,
            onTap: () => Get.to(() => const TestErrorHandling()),
          ),
          _buildDemoCard(
            context,
            title: 'Expandable BottomSheet',
            subtitle: 'Draggable and expandable bottom sheets',
            icon: Icons.vertical_align_top,
            color: Colors.blue,
            onTap: () => Get.to(() => const TestExpandableBottomSheet()),
          ),
          _buildDemoCard(
            context,
            title: 'ReactiveGetView Demo',
            subtitle: 'Automatic reactive UI updates',
            icon: Icons.sync,
            color: Colors.green,
            onTap: () => Get.to(() => const ReactiveGetViewDemo()),
          ),
          _buildDemoCard(
            context,
            title: 'Snackbar & Dialog Demo',
            subtitle: 'Various UI overlays and notifications',
            icon: Icons.notifications,
            color: Colors.orange,
            onTap: () => Get.to(() => const SnackbarDialogDemo()),
          ),
        ],
      ),
    );
  }

  Widget _buildDemoCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

// =============================================================================
// Snackbar & Dialog Demo
// =============================================================================

class SnackbarDialogDemo extends StatelessWidget {
  const SnackbarDialogDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Snackbar & Dialog Demo')),
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("Snackbar (Bottom)"),
              onPressed: () {
                Get.snackbar(
                  "Success",
                  "Operation completed successfully!",
                  snackPosition: SnackPosition.bottom,
                  margin: const EdgeInsets.all(15.0),
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text("Snackbar (Top)"),
              onPressed: () {
                Get.showSnackbar(const GetSnackBar(
                  title: "Warning",
                  message: "Please check your input",
                  backgroundColor: Colors.amber,
                  margin: EdgeInsets.all(15.0),
                  duration: Duration(seconds: 2),
                  snackPosition: SnackPosition.top,
                ));
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text("Bottom Sheet"),
              onPressed: () {
                Get.bottomSheet(
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Bottom Sheet Content',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text("Default Dialog"),
              onPressed: () {
                Get.defaultDialog(
                  title: "Confirm Action",
                  content: const Text("Are you sure you want to proceed?"),
                  textConfirm: "Yes",
                  textCancel: "No",
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    Get.back();
                    Get.snackbar("Confirmed", "Action confirmed!");
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
