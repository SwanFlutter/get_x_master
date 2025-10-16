import 'package:get_x_master/get_x_master.dart';

/// AuthService is a global service that persists throughout the app lifecycle.
/// It manages authentication state and provides login/logout functionality.
class AuthService extends GetxService {
  // Observable authentication state
  final RxBool isLoggedIn = false.obs;
  final RxString username = ''.obs;
  final RxString token = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize service - load saved auth state, etc.
    _loadAuthState();
  }

  @override
  void onClose() {
    // Clean up resources if needed
    super.onClose();
  }

  /// Load authentication state from storage
  Future<void> _loadAuthState() async {
    // Simulate loading from storage
    await Future.delayed(Duration(milliseconds: 500));
    // Check if user was previously logged in
    // For demo purposes, we'll just set it to false
    isLoggedIn.value = false;
  }

  /// Login user with email and password
  Future<bool> login(String email, String password) async {
    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 1));

      // For demo purposes, accept any non-empty credentials
      if (email.isNotEmpty && password.isNotEmpty) {
        isLoggedIn.value = true;
        username.value = email.split('@').first;
        token.value = 'demo_token_${DateTime.now().millisecondsSinceEpoch}';
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  /// Logout current user
  Future<void> logout() async {
    // Simulate API call
    await Future.delayed(Duration(milliseconds: 500));

    isLoggedIn.value = false;
    username.value = '';
    token.value = '';
  }

  /// Check if user is authenticated
  bool get isAuthenticated => isLoggedIn.value && token.value.isNotEmpty;
}
