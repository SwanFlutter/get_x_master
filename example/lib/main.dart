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

  runApp(const GetMaterialApp(home: MyWidget()));
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 25,
          children: [
            ElevatedButton(
              child: Text("snackbar"),
              onPressed: () {
                Get.snackbar("title", "message",
                    snackPosition: SnackPosition.BOTTOM,
                    margin: EdgeInsets.all(15.0));
              },
            ),
            ElevatedButton(
              child: Text("showSnackbar"),
              onPressed: () {
                Get.showSnackbar(GetSnackBar(
                  title: "title",
                  message: "message",
                  backgroundColor: Colors.amber,
                  margin: EdgeInsets.all(15.0),
                  duration: Duration(seconds: 2),
                  snackPosition: SnackPosition.TOP,
                ));
              },
            ),
            ElevatedButton(
              child: Text("bottomSheet"),
              onPressed: () {
                Get.bottomSheet(
                  Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.red,
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text("defaultDialog"),
              onPressed: () {
                Get.defaultDialog(
                  title: "title",
                  content: Text("content"),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
