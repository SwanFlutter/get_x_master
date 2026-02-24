/// Conditional navigation class for dynamic page routing based on runtime conditions.
///
/// This class is designed for standard `to()` navigation where you can go back.
/// For `off()` and `offAll()` methods, use [ConditionalNavigationOff] and
/// [ConditionalNavigationOffAll] respectively for cleaner code.
///
/// Example:
/// ```dart
/// // Basic usage with to()
/// Get.to(
///   () => HomePage(),
///   condition: ConditionalNavigation(
///     condition: () => AuthService.isLoggedIn,
///     truePage: () => HomePage(),
///     falsePage: () => LoginPage(),
///   ),
/// );
///
/// // Complex condition
/// Get.to(
///   () => HomePage(),
///   condition: ConditionalNavigation(
///     condition: () =>
///       AuthService.isLoggedIn &&
///       UserService.hasActiveSubscription,
///     truePage: () => PremiumDashboardPage(),
///     falsePage: () => LoginPage(),
///   ),
/// );
/// ```
class ConditionalNavigation {
  /// The condition function that returns a boolean to determine which page to navigate to.
  final dynamic Function() condition;

  /// The page to navigate to when condition returns true.
  final dynamic Function() truePage;

  /// The page to navigate to when condition returns false.
  final dynamic Function() falsePage;

  ConditionalNavigation({
    required this.condition,
    required this.truePage,
    required this.falsePage,
  });

  /// Evaluates condition and returns the appropriate page.
  /// Returns [truePage] if condition is true, otherwise [falsePage].
  dynamic Function() evaluate() {
    return condition() ? truePage : falsePage;
  }
}
