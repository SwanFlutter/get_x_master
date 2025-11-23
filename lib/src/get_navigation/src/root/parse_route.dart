import '../../get_navigation.dart';

/// The `RouteDecoder` class is used for decoding and managing routes.
/// Example usage:
/// ```dart
/// final decoder = RouteDecoder(
///   [GetPage(name: '/profile', page: () => ProfilePage())],
///   {'id': '123'},
///   {'user': userObject}
/// );
/// ```
class RouteDecoder {
  /// List of branches in the route tree.
  final List<GetPage> treeBranch;

  /// The current route - the last route in the treeBranch list.
  GetPage? get route => treeBranch.isEmpty ? null : treeBranch.last;

  /// URL parameters (e.g., `id` in `/user/:id`).
  final Map<String, String> parameters;

  /// Additional arguments that can be passed along with the route.
  final Object? arguments;

  const RouteDecoder(this.treeBranch, this.parameters, this.arguments);

  /// Replaces the arguments of the current route.
  /// Example:
  /// ```dart
  /// decoder.replaceArguments({'newData': 'value'});
  /// ```
  void replaceArguments(Object? arguments) {
    final route = this.route;
    if (route != null) {
      final index = treeBranch.indexOf(route);
      treeBranch[index] = route.copy(arguments: arguments);
    }
  }

  /// Replaces the parameters of the current route.
  /// Example:
  /// ```dart
  /// decoder.replaceParameters({'id': '456'});
  /// ```
  void replaceParameters(Object? arguments) {
    final route = this.route;
    if (route != null) {
      final index = treeBranch.indexOf(route);
      treeBranch[index] = route.copy(parameters: parameters);
    }
  }
}

/// The `ParseRouteTree` class is used for parsing and analyzing the route tree.
/// Example route definition:
/// ```dart
/// final parser = ParseRouteTree(routes: [
///   GetPage(name: '/home', page: () => HomePage()),
///   GetPage(
///     name: '/profile',
///     page: () => ProfilePage(),
///     children: [
///       GetPage(name: '/settings', page: () => SettingsPage()),
///     ],
///   ),
/// ]);
/// ```
class ParseRouteTree {
  ParseRouteTree({required this.routes});

  /// List of all defined routes.
  final List<GetPage> routes;

  /// Matches a route with the defined patterns.
  /// Example:
  /// ```dart
  /// final result = parser.matchRoute('/profile/123', arguments: {'data': 'test'});
  /// ```
  RouteDecoder matchRoute(String name, {Object? arguments}) {
    final uri = Uri.parse(name);
    // Split the path into segments.
    // Example: /home/profile/123 => [home, profile, 123]
    final split = uri.path.split('/').where((element) => element.isNotEmpty);

    // Build cumulative paths.
    // Example: /, /home, /home/profile, /home/profile/123
    var curPath = '/';
    final cumulativePaths = <String>['/'];

    for (var item in split) {
      if (curPath.endsWith('/')) {
        curPath += item;
      } else {
        curPath += '/$item';
      }
      cumulativePaths.add(curPath);
    }

    // Find matching routes in the tree.
    final treeBranch =
        cumulativePaths
            .map((e) => MapEntry(e, _findRoute(e)))
            .where((element) => element.value != null)
            .map((e) => MapEntry(e.key, e.value!))
            .toList();

    // Extract URL parameters.
    final params = Map<String, String>.from(uri.queryParameters);

    if (treeBranch.isNotEmpty) {
      final lastRoute = treeBranch.last;
      final parsedParams = _parseParams(name, lastRoute.value.path);
      if (parsedParams.isNotEmpty) {
        params.addAll(parsedParams);
      }

      // Apply parameters to all pages in the route.
      final mappedTreeBranch =
          treeBranch
              .map(
                (e) => e.value.copy(
                  parameters: {
                    if (e.value.parameters != null) ...e.value.parameters!,
                    ...params,
                  },
                  name: e.key,
                ),
              )
              .toList();

      return RouteDecoder(mappedTreeBranch, params, arguments);
    }

    return RouteDecoder(
      treeBranch.map((e) => e.value).toList(),
      params,
      arguments,
    );
  }

  /// Adds multiple routes to the tree.
  void addRoutes(List<GetPage> getPages) {
    for (final route in getPages) {
      addRoute(route);
    }
  }

  /// Adds a new route to the tree.
  /// Example:
  /// ```dart
  /// parser.addRoute(GetPage(
  ///   name: '/settings',
  ///   page: () => SettingsPage(),
  /// ));
  /// ```
  void addRoute(GetPage route) {
    routes.add(route);
    // Add child pages.
    for (var page in _flattenPage(route)) {
      addRoute(page);
    }
  }

  /// Flattens the hierarchical structure of pages into a flat list.
  List<GetPage> _flattenPage(GetPage route) {
    final result = <GetPage>[];
    if (route.children.isEmpty) {
      return result;
    }

    final parentPath = route.name;
    for (var page in route.children) {
      // Add parent middlewares to children.
      final parentMiddlewares = [
        if (page.middlewares != null) ...page.middlewares!,
        if (route.middlewares != null) ...route.middlewares!,
      ];
      result.add(_addChild(page, parentPath, parentMiddlewares));

      final children = _flattenPage(page);
      for (var child in children) {
        result.add(
          _addChild(child, parentPath, [
            ...parentMiddlewares,
            if (child.middlewares != null) ...child.middlewares!,
          ]),
        );
      }
    }
    return result;
  }

  /// Modifies the route for a GetPage.
  GetPage _addChild(
    GetPage origin,
    String parentPath,
    List<GetMiddleware> middlewares,
  ) => origin.copy(
    middlewares: middlewares,
    name: (parentPath + origin.name).replaceAll(r'//', '/'),
  );

  /// Finds a route that matches the given name.
  GetPage? _findRoute(String name) {
    return routes.firstWhereOrNull((route) => route.path.regex.hasMatch(name));
  }

  /// Parses URL parameters.
  Map<String, String> _parseParams(String path, PathDecoded routePath) {
    final params = <String, String>{};
    var idx = path.indexOf('?');
    if (idx > -1) {
      path = path.substring(0, idx);
      final uri = Uri.tryParse(path);
      if (uri != null) {
        params.addAll(uri.queryParameters);
      }
    }
    var paramsMatch = routePath.regex.firstMatch(path);

    for (var i = 0; i < routePath.keys.length; i++) {
      var param = Uri.decodeQueryComponent(paramsMatch![i + 1]!);
      params[routePath.keys[i]!] = param;
    }
    return params;
  }
}

/// Adds the `firstWhereOrNull` method to lists.
extension FirstWhereExt<T> on List<T> {
  /// The first element that satisfies the test condition, or null if none is found.
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
