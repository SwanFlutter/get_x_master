import 'dart:convert';

import 'package:example/model/user_model.dart';
import 'package:example/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

class LoginController extends GetXController {
  static LoginController get to => Get.smartFind();

  late TextEditingController emailController;
  late TextEditingController passwordController;
  RxBool isLoading = false.obs;

  GetConnect http = GetConnect(
    allowAutoSignedCert: true,
    followRedirects: true,
    maxRedirects: 5,
  );

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void chackLogin() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showMassage(
        title: "Worning",
        message: 'Please fill all fields',
        icon: Icons.error,
        iconColor: Colors.redAccent,
      );
    } else if (!GetUtils.isEmail(emailController.text)) {
      showMassage(
        title: "Worning",
        message: 'Please enter a valid email',
        icon: Icons.error,
        iconColor: Colors.redAccent,
      );
    } else if (passwordController.text.length < 6) {
      showMassage(
        title: "Worning",
        message: 'Password must be at least 6 characters',
        icon: Icons.error,
        iconColor: Colors.redAccent,
      );
    } else {
      Get.showOverlay(
        asyncFunction: () => login(),
        opacity: 0.4,
        loadingWidget: const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }
  }

  Future<UserModel?> login() async {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    var body = {
      'email': emailController.text,
      'password': passwordController.text,
    };

    final response = await http.post(
      'http://192.168.1.103/testapinew/v1/login',
      headers: header,
      body,
    );

    var jsonData = json.decode(response.bodyString!);

    if (jsonData is Map) {
      bool success = jsonData['success'];
      String message = jsonData['message'];

      if (success) {
        UserModel user = UserModel.fromMap(jsonData['data']);
        showMassage(
          title: "Success",
          message: message,
          icon: Icons.check,
          iconColor: Colors.green,
        );
        Get.off(() => Home());
        return user;
      } else {
        showMassage(
          title: "Error",
          message: message,
          icon: Icons.error,
          iconColor: Colors.redAccent,
        );
      }
    } else {
      showMassage(
        title: "Error",
        message: 'Something went wrong',
        icon: Icons.error,
        iconColor: Colors.redAccent,
      );
    }
    return null;
  }

  void showMassage({
    required String title,
    required String message,
    required IconData icon,
    required Color iconColor,
  }) {
    Get.snackbar(
      title,
      message,
      barBlur: 0.8,
      borderRadius: 12.0,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      icon: Icon(icon, color: iconColor),
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.all(20.0),
      mainButton: TextButton(
        child: Text('Retry', style: TextStyle(color: Colors.white)),
        onPressed: () {
          // Perform operation to reconnect
          Get.back(); // Close the snackbar
        },
      ),
      duration: Duration(seconds: 5),
      backgroundColor: Colors.grey[800]!,
    );
  }
}
