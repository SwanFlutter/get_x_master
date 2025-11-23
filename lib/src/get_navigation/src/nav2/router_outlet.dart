import 'package:flutter/material.dart';

import '../../../../get_x_master.dart';

/// A generic router outlet widget that manages navigation state and renders
/// route-specific content based on the current navigation configuration.
///
/// Example usage:
/// ```dart
/// // Basic usage with builder
/// RouterOutlet<MyDelegate, MyRoute>.builder(
///   builder: (context, delegate, currentRoute) {
///     return Text('Current route: ${currentRoute?.path}');
///   },
/// );
///
/// // Usage with page picking
/// RouterOutlet<MyDelegate, MyRoute>(
///   pickPages: (route) => route.pages,
///   pageBuilder: (context, delegate, pages) {
///     return Navigator(pages: pages);
///   },
/// );
/// ```
class RouterOutlet<TDelegate extends RouterDelegate<T>, T extends Object>
    extends StatefulWidget {
  /// The router delegate that manages navigation state
  final TDelegate routerDelegate;

  /// Builder function that constructs the widget tree based on the current route
  final Widget Function(
    BuildContext context,
    TDelegate delegate,
    T? currentRoute,
  )
  builder;

  /// Creates a router outlet with a custom builder function.
  RouterOutlet.builder({super.key, TDelegate? delegate, required this.builder})
    : routerDelegate = delegate ?? Get.delegate<TDelegate, T>()!;

  /// Creates a router outlet with page picking and building capabilities.
  RouterOutlet({
    Key? key,
    TDelegate? delegate,
    required Iterable<GetPage> Function(T currentNavStack) pickPages,
    required Widget Function(
      BuildContext context,
      TDelegate,
      Iterable<GetPage>? page,
    )
    pageBuilder,
  }) : this.builder(
         builder: (context, rDelegate, currentConfig) {
           var picked = currentConfig == null ? null : pickPages(currentConfig);
           if (picked?.isEmpty ?? false) {
             picked = null;
           }
           return pageBuilder(context, rDelegate, picked);
         },
         delegate: delegate,
         key: key,
       );

  @override
  RouterOutletState<TDelegate, T> createState() =>
      RouterOutletState<TDelegate, T>();
}

/// State class for RouterOutlet that manages lifecycle and route changes.
class RouterOutletState<TDelegate extends RouterDelegate<T>, T extends Object>
    extends State<RouterOutlet<TDelegate, T>> {
  /// Access to the router delegate
  TDelegate get delegate => widget.routerDelegate;

  /// Current route configuration
  T? currentRoute;

  @override
  void initState() {
    super.initState();
    _getCurrentRoute();
    delegate.addListener(onRouterDelegateChanged);
  }

  @override
  void dispose() {
    delegate.removeListener(onRouterDelegateChanged);
    super.dispose();
  }

  /// Updates the current route from the delegate
  void _getCurrentRoute() {
    currentRoute = delegate.currentConfiguration;
  }

  /// Handles route changes from the delegate
  void onRouterDelegateChanged() {
    setState(_getCurrentRoute);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, delegate, currentRoute);
  }
}

/// A GetX-specific implementation of RouterOutlet that provides additional
/// functionality for GetX navigation.
///
/// Example usage:
/// ```dart
/// // Basic outlet with initial route
/// GetRouterOutlet(
///   initialRoute: '/home',
/// );
///
/// // Outlet with anchor route
/// GetRouterOutlet(
///   anchorRoute: '/dashboard',
///   initialRoute: '/dashboard/users',
/// );
///
/// // Custom builder
/// GetRouterOutlet.builder(
///   builder: (context, delegate, route) {
///     return Text('Current path: ${route?.location}');
///   },
/// );
/// ```
class GetRouterOutlet extends RouterOutlet<GetDelegate, GetNavConfig> {
  /// Creates a GetRouterOutlet with route filtering capabilities.
  GetRouterOutlet({
    Key? key,
    String? anchorRoute,
    required String initialRoute,
    Iterable<GetPage> Function(Iterable<GetPage> afterAnchor)? filterPages,
    GlobalKey<NavigatorState>? navigatorKey,
    GetDelegate? delegate,
  }) : this.pickPages(
         pickPages: (config) {
           Iterable<GetPage<dynamic>> ret;
           if (anchorRoute == null) {
             // Skip ancestor path segments based on initial route
             final length = Uri.parse(initialRoute).pathSegments.length;
             return config.currentTreeBranch.skip(length).take(length).toList();
           }
           ret = config.currentTreeBranch.pickAfterRoute(anchorRoute);
           if (filterPages != null) {
             ret = filterPages(ret);
           }
           return ret;
         },
         emptyPage: (delegate) =>
             Get.routeTree.matchRoute(initialRoute).route ??
             delegate.notFoundRoute,
         key: key,
         navigatorKey: navigatorKey,
         delegate: delegate,
       );

  /// Creates a GetRouterOutlet with custom page picking logic.
  GetRouterOutlet.pickPages({
    super.key, // Now a super parameter
    Widget Function(GetDelegate delegate)? emptyWidget,
    GetPage Function(GetDelegate delegate)? emptyPage,
    required super.pickPages, // Now a super parameter
    bool Function(Route<dynamic>, dynamic)? onPopPage,
    GlobalKey<NavigatorState>? navigatorKey,
    GetDelegate? delegate,
  }) : super(
         pageBuilder: (context, rDelegate, pages) {
           final pageRes = <GetPage?>[
             ...?pages,
             if (pages == null || pages.isEmpty) emptyPage?.call(rDelegate),
           ].whereType<GetPage>();

           if (pageRes.isNotEmpty) {
             return GetNavigator(
               onPopPage:
                   onPopPage ??
                   (route, result) {
                     final didPop = route.didPop(result);
                     if (!didPop) {
                       return false;
                     }
                     return true;
                   },
               pages: pageRes.toList(),
               key: navigatorKey,
             );
           }
           return (emptyWidget?.call(rDelegate) ?? const SizedBox.shrink());
         },
         delegate: delegate ?? Get.rootDelegate,
       );

  /// Creates a GetRouterOutlet with a custom builder function.
  GetRouterOutlet.builder({
    super.key, // Now a super parameter
    required super.builder, // Now a super parameter
    GetDelegate? routerDelegate,
  }) : super.builder(delegate: routerDelegate);
}

/// Extension methods for list of GetPage objects
extension PagesListExt on List<GetPage> {
  /// Returns all pages starting from the specified route (inclusive)
  Iterable<GetPage> pickAtRoute(String route) {
    return skipWhile((value) => value.name != route);
  }

  /// Returns all pages after the specified route (exclusive)
  Iterable<GetPage> pickAfterRoute(String route) {
    return pickAtRoute(route).skip(1);
  }
}
