// ignore_for_file: library_private_types_in_public_api

import 'package:example/controller/login_controller.dart';
import 'package:example/new.dart';
import 'package:example/screen/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_x_master/get_x_master.dart';

class CupertinoLoginPage extends StatefulWidget {
  const CupertinoLoginPage({super.key});

  @override
  _CupertinoLoginPageState createState() => _CupertinoLoginPageState();
}

class _CupertinoLoginPageState extends State<CupertinoLoginPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Login Page'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Email TextField
              CupertinoTextField(
                controller: LoginController.to.emailController,
                placeholder: 'Email',
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemGrey4),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 20),

              // Password TextField
              CupertinoTextField(
                controller: LoginController.to.passwordController,
                placeholder: 'Password',
                obscureText: true,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemGrey4),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 20),

              // Login Button
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

              // Sign Up Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account? ',
                    style: TextStyle(fontSize: 10.sp),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
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

              // Snackbar Button
              SizedBox(
                width: Get.width / 2,
                height: 56,
                child: CupertinoButton.filled(
                  borderRadius: BorderRadius.circular(10),
                  onPressed: () {
                    Get.showSnackbar(
                      GetSnackBar(
                        title: 'Error',
                        message: 'Internet connection failed.',
                        icon: const Icon(
                          CupertinoIcons.exclamationmark_triangle,
                          color: CupertinoColors.systemRed,
                        ),
                        padding: const EdgeInsets.all(20.0),
                        margin: const EdgeInsets.all(20.0),
                        mainButton: CupertinoButton(
                          child: const Text(
                            'Retry',
                            style: TextStyle(color: CupertinoColors.white),
                          ),
                          onPressed: () {
                            Get.back(); // Close the snackbar
                          },
                        ),
                        duration: const Duration(seconds: 5),
                        backgroundColor: CupertinoColors.systemGrey,
                      ),
                    );
                  },
                  child: const Text('Snackbar'),
                ),
              ),

              const SizedBox(height: 10),

              // Test Button
              SizedBox(
                width: Get.width / 2,
                height: 56,
                child: CupertinoButton.filled(
                  borderRadius: BorderRadius.circular(10),
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
      ),
    );
  }
}
