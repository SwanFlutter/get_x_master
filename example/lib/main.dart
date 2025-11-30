import 'package:example/conditional_navigation_example.dart';
import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';
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

  runApp(const GetMaterialApp(home: StartPage()));
}
