import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

/// Example demonstrating ConditionalNavigation feature in GetX
///
/// This example shows how to use conditional navigation to dynamically
/// decide which page to navigate to based on runtime conditions.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Conditional Navigation Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const StartPage(),
    );
  }
}

// Simulated authentication service
class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  bool _isLoggedIn = false;
  bool _hasCompletedOnboarding = false;
  bool _isPremiumUser = false;

  bool get isLoggedIn => _isLoggedIn;
  bool get hasCompletedOnboarding => _hasCompletedOnboarding;
  bool get isPremiumUser => _isPremiumUser;

  void login() => _isLoggedIn = true;
  void logout() => _isLoggedIn = false;
  void completeOnboarding() => _hasCompletedOnboarding = true;
  void upgradeToPremium() => _isPremiumUser = true;
  void reset() {
    _isLoggedIn = false;
    _hasCompletedOnboarding = false;
    _isPremiumUser = false;
  }
}

// Controllers
class NavigationController extends GetXController {
  final authService = AuthService();

  void navigateWithCondition({required String type}) {
    switch (type) {
      case 'to':
        _navigateToExample();
        break;
      case 'off':
        _navigateOffExample();
        break;
      case 'offAll':
        _navigateOffAllExample();
        break;
    }
  }

  /// Example 1: Using Get.to() with ConditionalNavigation
  void _navigateToExample() {
    Get.to(
      () => const HomePage(),
      condition: ConditionalNavigation(
        condition: () => authService.isLoggedIn,
        truePage: () => const HomePage(),
        falsePage: () => const LoginPage(),
      ),
      transition: Transition.fadeIn,
    );
  }

  /// Example 2: Using Get.off() with ConditionalNavigation
  void _navigateOffExample() {
    Get.off(
      () => const HomePage(),
      condition: ConditionalNavigation(
        condition: () => authService.hasCompletedOnboarding,
        truePage: () => const HomePage(),
        falsePage: () => const OnboardingPage(),
      ),
      transition: Transition.rightToLeft,
    );
  }

  /// Example 3: Using Get.offAll() with ConditionalNavigation
  void _navigateOffAllExample() {
    Get.offAll(
      () => const HomePage(),
      condition: ConditionalNavigation(
        condition: () => authService.isPremiumUser,
        truePage: () => const PremiumDashboard(),
        falsePage: () => const HomePage(),
      ),
      transition: Transition.zoom,
    );
  }

  void toggleLogin() {
    if (authService.isLoggedIn) {
      authService.logout();
    } else {
      authService.login();
    }
    update();
  }

  void toggleOnboarding() {
    if (authService.hasCompletedOnboarding) {
      authService._hasCompletedOnboarding = false;
    } else {
      authService.completeOnboarding();
    }
    update();
  }

  void togglePremium() {
    if (authService.isPremiumUser) {
      authService._isPremiumUser = false;
    } else {
      authService.upgradeToPremium();
    }
    update();
  }
}

// ============================================================================
// PAGES
// ============================================================================

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      init: NavigationController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Conditional Navigation Demo'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                const Icon(
                  Icons.navigation,
                  size: 80,
                  color: Colors.blue,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Conditional Navigation',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Navigate dynamically based on conditions',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Status Cards
                _buildStatusCard(
                  title: 'Login Status',
                  status: controller.authService.isLoggedIn
                      ? 'Logged In'
                      : 'Logged Out',
                  isActive: controller.authService.isLoggedIn,
                  onToggle: controller.toggleLogin,
                ),
                const SizedBox(height: 16),
                _buildStatusCard(
                  title: 'Onboarding Status',
                  status: controller.authService.hasCompletedOnboarding
                      ? 'Completed'
                      : 'Not Completed',
                  isActive: controller.authService.hasCompletedOnboarding,
                  onToggle: controller.toggleOnboarding,
                ),
                const SizedBox(height: 16),
                _buildStatusCard(
                  title: 'Premium Status',
                  status:
                      controller.authService.isPremiumUser ? 'Premium' : 'Free',
                  isActive: controller.authService.isPremiumUser,
                  onToggle: controller.togglePremium,
                ),
                const SizedBox(height: 32),

                // Navigation Examples
                const Text(
                  'Try Navigation Methods:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Example 1: Get.to() with condition
                _buildExampleCard(
                  title: 'Get.to() - Conditional Push',
                  description:
                      'Navigate to HomePage if logged in, otherwise to LoginPage',
                  condition: 'Login Status',
                  onPressed: () => controller.navigateWithCondition(type: 'to'),
                  color: Colors.blue,
                ),
                const SizedBox(height: 16),

                // Example 2: Get.off() with condition
                _buildExampleCard(
                  title: 'Get.off() - Conditional Replace',
                  description:
                      'Replace with HomePage if onboarding completed, otherwise OnboardingPage',
                  condition: 'Onboarding Status',
                  onPressed: () =>
                      controller.navigateWithCondition(type: 'off'),
                  color: Colors.orange,
                ),
                const SizedBox(height: 16),

                // Example 3: Get.offAll() with condition
                _buildExampleCard(
                  title: 'Get.offAll() - Conditional Clear All',
                  description:
                      'Clear all and go to Premium Dashboard if premium, otherwise HomePage',
                  condition: 'Premium Status',
                  onPressed: () =>
                      controller.navigateWithCondition(type: 'offAll'),
                  color: Colors.purple,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusCard({
    required String title,
    required String status,
    required bool isActive,
    required VoidCallback onToggle,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              isActive ? Icons.check_circle : Icons.cancel,
              color: isActive ? Colors.green : Colors.red,
              size: 32,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 14,
                      color: isActive ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: onToggle,
              child: const Text('Toggle'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExampleCard({
    required String title,
    required String description,
    required String condition,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return Card(
      elevation: 3,
      color: color.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.code, color: color),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.info_outline, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  'Depends on: $condition',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Try This Example'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// DESTINATION PAGES
// ============================================================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.home, size: 100, color: Colors.blue),
            const SizedBox(height: 24),
            const Text(
              'Welcome to Home Page!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'You were navigated here because the condition was met.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Go Back'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Required'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock, size: 100, color: Colors.red),
            const SizedBox(height: 24),
            const Text(
              'Please Login',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'You were navigated here because you are not logged in.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                AuthService().login();
                Get.back();
              },
              icon: const Icon(Icons.login),
              label: const Text('Login & Go Back'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => Get.back(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Onboarding'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.accessibility_new,
                size: 100, color: Colors.orange),
            const SizedBox(height: 24),
            const Text(
              'Welcome! Complete Onboarding',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'You were navigated here because you haven\'t completed onboarding yet.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                AuthService().completeOnboarding();
                Get.back();
              },
              icon: const Icon(Icons.done),
              label: const Text('Complete Onboarding'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => Get.back(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class PremiumDashboard extends StatelessWidget {
  const PremiumDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium Dashboard'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, size: 100, color: Colors.amber),
            const SizedBox(height: 24),
            const Text(
              'Premium Dashboard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'You have access to premium features!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Go Back'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
