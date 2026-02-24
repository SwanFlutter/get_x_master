/// Conditional navigation class specifically for `off()` method.
///
/// This class is designed for replacement navigation where you want to
/// pop the current route and push a new one based on a condition.
/// Unlike [ConditionalNavigation], this class only requires pages for the `off()` method.
///
/// Example:
/// ```dart
/// Get.off(
///   () => HomePage(),
///   conditionOff: ConditionalNavigationOff(
///     condition: () => UserService.hasProfile,
///     truePage: () => DashboardPage(),
///     falsePage: () => WelcomePage(),
///   ),
/// );
/// ```
class ConditionalNavigationOff {
  /// The condition function that returns a boolean to determine which page to navigate to.
  final dynamic Function() condition;

  /// The page to navigate to when condition returns true.
  final dynamic Function() truePage;

  /// The page to navigate to when condition returns false.
  final dynamic Function() falsePage;

  ConditionalNavigationOff({
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

/// Conditional navigation class specifically for `offAll()` method.
///
/// This class is designed for navigation where you want to remove all previous
/// routes and push a new one based on a condition.
/// Unlike [ConditionalNavigation], this class only requires pages for the `offAll()` method.
///
/// Example:
/// ```dart
/// Get.offAll(
///   () => HomePage(),
///   conditionOffAll: ConditionalNavigationOffAll(
///     condition: () => UserService.isFirstTime,
///     truePage: () => OnboardingPage(),
///     falsePage: () => MainPage(),
///   ),
/// );
/// ```
class ConditionalNavigationOffAll {
  /// The condition function that returns a boolean to determine which page to navigate to.
  final dynamic Function() condition;

  /// The page to navigate to when condition returns true.
  final dynamic Function() truePage;

  /// The page to navigate to when condition returns false.
  final dynamic Function() falsePage;

  ConditionalNavigationOffAll({
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
