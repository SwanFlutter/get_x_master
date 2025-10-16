import 'package:example/bindings/bindings.dart';
import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

import 'controller/theme_controller.dart';
/*
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialBinding: MyBinding(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Screen(),
    );
  }
}

*/

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
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تغییر تم'),
      ),
      body: Center(
        child: GetBuilder<ThemeController>(
          init: null, // Let GetX find the controller from bindings
          builder: (controller) {
            return Obx(() => Switch(
                  value: controller.isDarkMode,
                  onChanged: (value) {
                    controller.toggleTheme();
                  },
                  activeThumbColor: Colors.deepOrange,
                ));
          },
        ),
      ),
    );
  }
}
