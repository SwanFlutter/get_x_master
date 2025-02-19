import 'package:example/controller/signup_controller.dart';
import 'package:example/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp'),
      ),
      body: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            TextField(
              controller: SignupController.to.emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: SignupController.to.passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: SignupController.to.confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
            ),
            AnimationExtension(
              MaterialButton(
                minWidth: Get.width / 2,
                height: 56,
                color: context.theme.colorScheme.inversePrimary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  SignupController.to.chackSignup();
                },
                child: AnimationExtension(Text('SignUp', style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 14.sp))).rotate(begin: 0, end: 1),
              ),
            ).wave(),
            SizedBox(height: 5),
            Row(
              // Center-align the row
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Don\'t have an account? ',
                    style: TextStyle(fontSize: 10.sp),
                    children: [
                      WidgetSpan(
                        child: InkWell(
                          onTap: () {
                            Get.to(() => LoginPage());
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: context.theme.primaryColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline, // Optional underline for emphasis
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ).paddingOnly(
                  left: context.mediaQuery.size.width * 0.24,
                ),
              ],
            ),
          ],
        ).paddingAll(20.0),
      ),
    );
  }
}
