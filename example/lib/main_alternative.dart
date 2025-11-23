import 'package:example/bindings/bindings.dart';
import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

import 'controller/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ColorStudioApp());
}

class ColorStudioApp extends StatelessWidget {
  const ColorStudioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: MyBinding(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

// Alternative 1: Using late keyword with smartFind
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get controller lazily inside build - this works!
    final controller = Get.smartFind<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('تغییر تم'),
      ),
      body: Center(
        child: Obx(() => Switch(
              value: controller.isDarkMode,
              onChanged: (value) {
                controller.toggleTheme();
              },
              activeThumbColor: Colors.deepOrange,
            )),
      ),
    );
  }
}

// Alternative 2: Using StatefulWidget with late field
class HomeScreenStateful extends StatefulWidget {
  const HomeScreenStateful({super.key});

  @override
  State<HomeScreenStateful> createState() => _HomeScreenStatefulState();
}

class _HomeScreenStatefulState extends State<HomeScreenStateful> {
  late final ThemeController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.smartFind<ThemeController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تغییر تم'),
      ),
      body: Center(
        child: Obx(() => Switch(
              value: controller.isDarkMode,
              onChanged: (value) {
                controller.toggleTheme();
              },
              activeThumbColor: Colors.deepOrange,
            )),
      ),
    );
  }
}
