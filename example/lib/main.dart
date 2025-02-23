import 'package:example/bindings/bindings.dart';
import 'package:example/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

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
      /*theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),*/
      home: const LoginPage(),
    );
  }
}
