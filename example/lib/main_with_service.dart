import 'package:example/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetxService Demo',
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

/// Initial binding that registers global services
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Register AuthService as a permanent service
    // It will persist throughout the app lifecycle
    Get.put(AuthService(), permanent: true);
  }
}

/// Login screen
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final authService = Get.find<AuthService>();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Show auth status
            Obx(
              () => Text(
                authService.isLoggedIn.value
                    ? 'Logged in as: ${authService.username.value}'
                    : 'Not logged in',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 32),

            // Email field
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            // Password field
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),

            // Login/Logout button
            Obx(
              () => authService.isLoggedIn.value
                  ? Column(
                      children: [
                        ElevatedButton(
                          onPressed: () =>
                              Get.to(() => const DashboardScreen()),
                          child: const Text('Go to Dashboard'),
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton(
                          onPressed: () async {
                            await authService.logout();
                            Get.snackbar(
                              'Success',
                              'Logged out successfully',
                              snackPosition: SnackPosition.bottom,
                            );
                          },
                          child: const Text('Logout'),
                        ),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        final email = emailController.text;
                        final password = passwordController.text;

                        if (email.isEmpty || password.isEmpty) {
                          Get.snackbar(
                            'Error',
                            'Please enter email and password',
                            snackPosition: SnackPosition.bottom,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                          return;
                        }

                        final success = await authService.login(
                          email,
                          password,
                        );

                        if (success) {
                          Get.snackbar(
                            'Success',
                            'Logged in successfully',
                            snackPosition: SnackPosition.bottom,
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                          );
                        } else {
                          Get.snackbar(
                            'Error',
                            'Invalid credentials',
                            snackPosition: SnackPosition.bottom,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      },
                      child: const Text('Login'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Dashboard screen that uses the AuthService
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Get.find<AuthService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authService.logout();
              Get.back();
              Get.snackbar(
                'Success',
                'Logged out successfully',
                snackPosition: SnackPosition.bottom,
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.dashboard, size: 100, color: Colors.blue),
            const SizedBox(height: 24),
            Obx(
              () => Text(
                'Welcome, ${authService.username.value}!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 16),
            Obx(
              () => Text(
                'Token: ${authService.token.value.substring(0, 20)}...',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Get.back(),
              child: const Text('Back to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
