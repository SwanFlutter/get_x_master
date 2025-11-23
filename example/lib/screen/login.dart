// ignore_for_file: library_private_types_in_public_api

import 'package:example/controller/login_controller.dart';
import 'package:example/new.dart';
import 'package:example/screen/signup.dart';
import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: LoginController.to.emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: LoginController.to.passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 20),
            AnimationExtension(
              SizedBox(
                width: Get.width / 2,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    LoginController.to.chackLogin();
                  },
                  child: AnimationExtension(
                    Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                  ).rotate(begin: 0, end: 1),
                ),
              ),
            ).rotate(begin: 0, end: 1),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account? ',
                  style: TextStyle(fontSize: 10.sp),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => SignUp());
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: Get.width / 2,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Get.showSnackbar(
                    GetSnackBar(
                      title: 'Error',
                      message: 'Internet connection failed.',
                      icon: const Icon(Icons.error, color: Colors.red),
                      padding: const EdgeInsets.all(20.0),
                      margin: const EdgeInsets.all(20.0),
                      mainButton: TextButton(
                        child: const Text(
                          'Retry',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Get.back(); // Close the snackbar
                        },
                      ),
                      duration: const Duration(seconds: 5),
                      backgroundColor: Colors.grey[800]!,
                    ),
                  );
                },
                child: const Text('Snackbar'),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: Get.width / 2,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Get.to(
                    () => Screen(),
                    condition: ConditionalNavigation(
                      condition: () => true,
                      truePage: () => Screen(),
                      falsePage: () => Screen2(),
                    ),
                  );
                },
                child: const Text('Test'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
