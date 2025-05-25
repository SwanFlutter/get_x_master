import 'package:example/bindings/bindings.dart';
import 'package:example/cupertino/simple_cupertino_example.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_x_master/get_x_master.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetCupertinoApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialBinding: MyBinding(),
      theme: const CupertinoThemeData(
        primaryColor: CupertinoColors.systemBlue,
        brightness: Brightness.light,
      ),
      home: const SimpleCupertinoExample(),
    );
  }
}
