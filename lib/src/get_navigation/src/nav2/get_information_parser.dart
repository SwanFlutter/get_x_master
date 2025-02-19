import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../../../get_x_master.dart';


/// A custom route information parser for GetX navigation system.
///
/// This parser converts between route information (URL and state) and [GetNavConfig] objects.
/// It handles route matching and provides default route behavior when necessary.
///
/// Example usage:
/// ```dart
/// // Basic usage with default initial route
/// final parser = GetInformationParser();
///
/// // Custom initial route
/// final parser = GetInformationParser(initialRoute: '/home');
///
/// // Using with Router
/// Router(
///   routeInformationParser: GetInformationParser(),
///   routerDelegate: GetRouterDelegate(...),
///   routeInformationProvider: GetRouteInformationProvider(),
/// )
/// ```
class GetInformationParser extends RouteInformationParser<GetNavConfig> {
  /// The route path to use when no specific route is provided.
  ///
  /// This route will be used in two cases:
  /// 1. When the location is empty
  /// 2. When the location is '/' and no matching route is found
  ///
  /// Defaults to '/'.
  final String initialRoute;

  /// Creates a new [GetInformationParser] instance.
  ///
  /// [initialRoute] specifies the default route to use when no route
  /// is provided or when the root route ('/') has no matching handler.
  GetInformationParser({
    this.initialRoute = '/',
  }) {
    Get.log('GetInformationParser is created !');
  }

  /// Converts route information from the system into a [GetNavConfig].
  ///
  /// This method handles several cases:
  /// 1. Empty location -> redirects to [initialRoute]
  /// 2. Root location ('/') -> checks for matching route, falls back to [initialRoute]
  /// 3. Other locations -> matches against route tree
  ///
  /// Returns a [SynchronousFuture] containing the parsed [GetNavConfig].
  @override
  SynchronousFuture<GetNavConfig> parseRouteInformation(
    RouteInformation routeInformation,
  ) {
    final uri = routeInformation.uri;
    var location = uri.toString();

    // Handle root route special case
    if (location == '/') {
      // If no route handler exists for root path,
      // redirect to initialRoute
      if (!Get.routeTree.routes.any((element) => element.name == '/')) {
        location = initialRoute;
      }
    }
    // Handle empty location
    else if (location.isEmpty) {
      location = initialRoute;
    }

    Get.log('GetInformationParser: route location: $location');

    // Match the location against the route tree
    final matchResult = Get.routeTree.matchRoute(location);

    // Create and return navigation configuration
    return SynchronousFuture(
      GetNavConfig(
        currentTreeBranch: matchResult.treeBranch,
        location: location,
        state: routeInformation.state,
      ),
    );
  }

  /// Converts a [GetNavConfig] back into route information.
  ///
  /// This is used when the app needs to update the system's URL bar or
  /// save the current route for state restoration.
  ///
  /// Returns [RouteInformation] containing the URI and state from the configuration.
  @override
  RouteInformation restoreRouteInformation(GetNavConfig configuration) {
    return RouteInformation(
      uri: Uri.tryParse(configuration.locationString),
      state: configuration.state,
    );
  }
}
