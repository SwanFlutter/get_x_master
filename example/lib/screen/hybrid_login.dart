// ignore_for_file: library_private_types_in_public_api

import 'package:example/controller/login_controller.dart';
import 'package:example/new.dart';
import 'package:example/screen/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

class HybridLoginPage extends StatefulWidget {
  const HybridLoginPage({super.key});

  @override
  _HybridLoginPageState createState() => _HybridLoginPageState();
}

class _HybridLoginPageState extends State<HybridLoginPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Login Page')),
      child: SafeArea(
        child: Material(
          // This provides MaterialLocalizations for Material widgets
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Material TextField wrapped in Material widget
                TextField(
                  controller: LoginController.to.emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                TextField(
                  controller: LoginController.to.passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                // You can mix Cupertino and Material widgets
                AnimationExtension(
                  SizedBox(
                    width: Get.width / 2,
                    height: 56,
                    child: CupertinoButton.filled(
                      borderRadius: BorderRadius.circular(10),
                      onPressed: () {
                        LoginController.to.chackLogin();
                      },
                      child: AnimationExtension(
                        Text(
                          'Login',
                          style: TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 14.sp,
                          ),
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
                    GestureDetector(
                      onTap: () {
                        Get.to(() => SignUp());
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: CupertinoColors.activeBlue,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Material Button
                SizedBox(
                  width: Get.width / 2,
                  height: 56,
                  child: MaterialButton(
                    color: CupertinoColors.activeBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
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
                              Get.back();
                            },
                          ),
                          duration: const Duration(seconds: 5),
                          backgroundColor: Colors.grey[800]!,
                        ),
                      );
                    },
                    child: const Text(
                      'Snackbar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: Get.width / 2,
                  height: 56,
                  child: MaterialButton(
                    color: CupertinoColors.activeBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
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
                    child: const Text(
                      'Test',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
