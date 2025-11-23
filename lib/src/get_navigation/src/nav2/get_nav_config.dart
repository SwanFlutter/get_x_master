import 'package:flutter/widgets.dart';

import '../../../../get_x_master.dart';

/// A navigation configuration class that enables direct navigation to sub-routes
/// and manages the current navigation state in GetX.
///
/// This class extends [RouteInformation] to provide additional functionality
/// specific to GetX navigation, including management of the current page tree
/// branch and location information.
///
/// Example usage:
/// ```dart
/// // Create a configuration for a specific route
/// final config = GetNavConfig(
///   currentTreeBranch: [homePage, settingsPage],
///   location: '/home/settings',
///   state: {'id': 123},
/// );
///
/// // Create from a route string
/// final configFromRoute = GetNavConfig.fromRoute('/home/settings');
///
/// // Access current page
/// final currentPage = config.currentPage;
///
/// // Get location as string
/// print(config.locationString); // prints: /home/settings
///
/// // Create a copy with modified values
/// final newConfig = config.copyWith(
///   location: '/home/profile',
///   state: {'userId': 456},
/// );
/// ```
class GetNavConfig extends RouteInformation {
  /// The current branch in the navigation tree, representing the path
  /// from root to current page.
  ///
  /// This list contains all [GetPage] instances in the current navigation path,
  /// ordered from root to leaf.
  final List<GetPage> currentTreeBranch;

  /// The currently active page, which is the last page in the [currentTreeBranch].
  ///
  /// Returns null if [currentTreeBranch] is empty.
  GetPage? get currentPage =>
      currentTreeBranch.isNotEmpty ? currentTreeBranch.last : null;

  /// Creates a new [GetNavConfig] instance.
  ///
  /// Parameters:
  /// - [currentTreeBranch]: List of pages representing the current navigation path
  /// - [location]: The string representation of the current route (defaults to '/' if null)
  /// - [state]: Optional state object associated with this route
  GetNavConfig({
    required this.currentTreeBranch,
    required String? location,
    required super.state,
  }) : super(uri: Uri.parse(location ?? '/'));

  /// Returns the string representation of the current location.
  String get locationString => uri.toString();

  /// Creates a copy of this configuration with optional modified values.
  ///
  /// Parameters:
  /// - [currentTreeBranch]: New list of pages (optional)
  /// - [location]: New location string
  /// - [state]: New state object
  ///
  /// Returns a new [GetNavConfig] instance with the specified modifications.
  GetNavConfig copyWith({
    List<GetPage>? currentTreeBranch,
    required String? location,
    required Object? state,
  }) {
    return GetNavConfig(
      currentTreeBranch: currentTreeBranch ?? this.currentTreeBranch,
      location: location ?? locationString,
      state: state ?? this.state,
    );
  }

  /// Creates a [GetNavConfig] instance from a route string.
  ///
  /// This factory method attempts to match the provided route against the
  /// application's route tree and creates a corresponding configuration.
  ///
  /// Parameters:
  /// - [route]: The route string to parse
  ///
  /// Returns null if the route doesn't match any valid path in the route tree.
  static GetNavConfig? fromRoute(String route) {
    final res = Get.routeTree.matchRoute(route);
    if (res.treeBranch.isEmpty) return null;
    return GetNavConfig(
      currentTreeBranch: res.treeBranch,
      location: route,
      state: null,
    );
  }

  /// Provides a formatted string representation of the configuration.
  ///
  /// Useful for debugging and logging purposes.
  @override
  String toString() => '''
======GetNavConfig=====
currentTreeBranch: $currentTreeBranch
currentPage: $currentPage
======GetNavConfig=====''';
}
