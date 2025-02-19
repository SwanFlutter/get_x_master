import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../get_core/get_core.dart';
import '../../../get_instance/get_instance.dart';
import '../../../get_state_manager/get_state_manager.dart';
import '../../../get_utils/get_utils.dart';
import '../../get_navigation.dart';

/// A GetX-powered CupertinoApp that provides additional functionality for
/// state management, routing, and internationalization.
///
/// Example usage:
/// ```dart
/// // Basic usage
/// GetCupertinoApp(
///   home: MyHomePage(),
///   theme: CupertinoThemeData(
///     primaryColor: CupertinoColors.systemBlue,
///   ),
/// );
///
/// // With routing
/// GetCupertinoApp(
///   initialRoute: '/home',
///   getPages: [
///     GetPage(name: '/home', page: () => HomePage()),
///     GetPage(name: '/profile', page: () => ProfilePage()),
///   ],
/// );
///
/// // With translations
/// GetCupertinoApp(
///   translations: MyTranslations(),
///   locale: Locale('en', 'US'),
///   fallbackLocale: Locale('en', 'US'),
/// );
/// ```
class GetCupertinoApp extends StatelessWidget {
  /// Creates a GetCupertinoApp with standard navigation.
  ///
  /// Use this constructor for traditional navigation using routes and pages.
  const GetCupertinoApp({
    super.key,
    this.theme,
    this.navigatorKey,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.builder,
    this.translationsKeys,
    this.translations,
    this.textDirection,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.customTransition,
    this.onInit,
    this.onDispose,
    this.locale,
    this.fallbackLocale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.smartManagement = SmartManagement.full,
    this.initialBinding,
    this.useInheritedMediaQuery = false,
    this.unknownRoute,
    this.routingCallback,
    this.defaultTransition,
    this.onReady,
    this.getPages,
    this.opaqueRoute,
    this.enableLog = kDebugMode,
    this.logWriterCallback,
    this.popGesture,
    this.transitionDuration,
    this.defaultGlobalState,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.actions,
  }) : routeInformationProvider = null,
       routeInformationParser = null,
       routerDelegate = null,
       backButtonDispatcher = null;

  /// Creates a GetCupertinoApp using the Router API for navigation.
  ///
  /// This constructor is used for declarative routing using the Router API.
  GetCupertinoApp.router({
    super.key,
    this.theme,
    this.routeInformationProvider,
    RouteInformationParser<Object>? routeInformationParser,
    RouterDelegate<Object>? routerDelegate,
    this.backButtonDispatcher,
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.useInheritedMediaQuery = false,
    this.color,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.customTransition,
    this.translationsKeys,
    this.translations,
    this.textDirection,
    this.fallbackLocale,
    this.routingCallback,
    this.defaultTransition,
    this.opaqueRoute,
    this.onInit,
    this.onReady,
    this.onDispose,
    this.enableLog = kDebugMode,
    this.logWriterCallback,
    this.popGesture,
    this.smartManagement = SmartManagement.full,
    this.initialBinding,
    this.transitionDuration,
    this.defaultGlobalState,
    this.getPages,
    this.unknownRoute,
  }) : routerDelegate =
           routerDelegate ??= Get.createDelegate(notFoundRoute: unknownRoute),
       routeInformationParser =
           routeInformationParser ??= Get.createInformationParser(
             initialRoute: getPages?.first.name ?? '/',
           ),
       navigatorObservers = null,
       navigatorKey = null,
       onGenerateRoute = null,
       home = null,
       onGenerateInitialRoutes = null,
       onUnknownRoute = null,
       routes = null,
       initialRoute = null {
    Get.routerDelegate = routerDelegate;
    Get.routeInformationParser = routeInformationParser;
  }

  // Navigation related properties
  final GlobalKey<NavigatorState>? navigatorKey;
  final Widget? home;
  final Map<String, WidgetBuilder>? routes;
  final String? initialRoute;
  final RouteFactory? onGenerateRoute;
  final InitialRouteListFactory? onGenerateInitialRoutes;
  final RouteFactory? onUnknownRoute;
  final List<NavigatorObserver>? navigatorObservers;

  // Router API related properties
  final RouteInformationProvider? routeInformationProvider;
  final RouteInformationParser<Object>? routeInformationParser;
  final RouterDelegate<Object>? routerDelegate;
  final BackButtonDispatcher? backButtonDispatcher;

  // Theming and styling
  final CupertinoThemeData? theme;
  final Color? color;
  final ThemeData? highContrastTheme;
  final ThemeData? highContrastDarkTheme;

  // Internationalization
  final Map<String, Map<String, String>>? translationsKeys;
  final Translations? translations;
  final TextDirection? textDirection;
  final Locale? locale;
  final Locale? fallbackLocale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final LocaleResolutionCallback? localeResolutionCallback;
  final Iterable<Locale> supportedLocales;

  // Navigation configuration
  final CustomTransition? customTransition;
  final List<GetPage>? getPages;
  final GetPage? unknownRoute;
  final Transition? defaultTransition;
  final Duration? transitionDuration;
  final bool? popGesture;
  final bool? opaqueRoute;

  // GetX specific configuration
  final SmartManagement smartManagement;
  final Bindings? initialBinding;
  final bool? defaultGlobalState;
  final Function(Routing?)? routingCallback;
  final bool? enableLog;
  final LogWriterCallback? logWriterCallback;

  // Lifecycle callbacks
  final VoidCallback? onInit;
  final VoidCallback? onReady;
  final VoidCallback? onDispose;

  // App configuration
  final String title;
  final GenerateAppTitle? onGenerateTitle;
  final TransitionBuilder? builder;
  final bool useInheritedMediaQuery;
  final Map<LogicalKeySet, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;

  // Debug options
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;

  @override
  Widget build(BuildContext context) => GetBuilder<GetMaterialController>(
    init: Get.rootController,
    dispose: (d) => onDispose?.call(),
    initState: _initState,
    builder: _buildApp,
  );

  void _initState(GetBuilderState<GetMaterialController> state) {
    Get.engine.addPostFrameCallback((_) => onReady?.call());

    _initializeLocalization();
    _initializeNavigation();
    _initializeConfiguration();

    onInit?.call();
  }

  void _initializeLocalization() {
    if (locale != null) Get.locale = locale;
    if (fallbackLocale != null) Get.fallbackLocale = fallbackLocale;

    if (translations != null) {
      Get.addTranslations(translations!.keys);
    } else if (translationsKeys != null) {
      Get.addTranslations(translationsKeys!);
    }
  }

  void _initializeNavigation() {
    Get.customTransition = customTransition;
    initialBinding?.dependencies();
    if (getPages != null) Get.addPages(getPages!);
  }

  void _initializeConfiguration() {
    Get.smartManagement = smartManagement;
    Get.config(
      enableLog: enableLog ?? Get.isLogEnable,
      logWriterCallback: logWriterCallback,
      defaultTransition: defaultTransition ?? Get.defaultTransition,
      defaultOpaqueRoute: opaqueRoute ?? Get.isOpaqueRouteDefault,
      defaultPopGesture: popGesture ?? Get.isPopGestureEnable,
      defaultDurationTransition:
          transitionDuration ?? Get.defaultTransitionDuration,
    );
  }

  Widget _buildApp(GetMaterialController controller) {
    return routerDelegate != null
        ? _buildRouterApp(controller)
        : _buildNavigatorApp(controller);
  }

  Widget _buildRouterApp(GetMaterialController controller) {
    return CupertinoApp.router(
      routerDelegate: routerDelegate!,
      routeInformationParser: routeInformationParser!,
      backButtonDispatcher: backButtonDispatcher,
      routeInformationProvider: routeInformationProvider,
      key: controller.unikey,
      theme: theme,
      builder: defaultBuilder,
      title: title,
      onGenerateTitle: onGenerateTitle,
      color: color,
      locale: Get.locale ?? locale,
      localizationsDelegates: localizationsDelegates,
      localeListResolutionCallback: localeListResolutionCallback,
      localeResolutionCallback: localeResolutionCallback,
      supportedLocales: supportedLocales,
      showPerformanceOverlay: showPerformanceOverlay,
      checkerboardRasterCacheImages: checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: checkerboardOffscreenLayers,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      shortcuts: shortcuts,
    );
  }

  Widget _buildNavigatorApp(GetMaterialController controller) {
    return CupertinoApp(
      key: controller.unikey,
      theme: theme,
      navigatorKey: navigatorKey == null ? Get.key : Get.addKey(navigatorKey!),
      home: home,
      routes: routes ?? const <String, WidgetBuilder>{},
      initialRoute: initialRoute,
      onGenerateRoute: getPages != null ? generator : onGenerateRoute,
      onGenerateInitialRoutes:
          (getPages == null || home != null)
              ? onGenerateInitialRoutes
              : initialRoutesGenerate,
      onUnknownRoute: onUnknownRoute,
      navigatorObservers: _buildNavigatorObservers(),
      builder: defaultBuilder,
      title: title,
      onGenerateTitle: onGenerateTitle,
      color: color,
      locale: Get.locale ?? locale,
      localizationsDelegates: localizationsDelegates,
      localeListResolutionCallback: localeListResolutionCallback,
      localeResolutionCallback: localeResolutionCallback,
      supportedLocales: supportedLocales,
      showPerformanceOverlay: showPerformanceOverlay,
      checkerboardRasterCacheImages: checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: checkerboardOffscreenLayers,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      shortcuts: shortcuts,
    );
  }

  List<NavigatorObserver> _buildNavigatorObservers() {
    final observers = <NavigatorObserver>[
      GetObserver(routingCallback, Get.routing),
    ];
    if (navigatorObservers != null) {
      observers.addAll(navigatorObservers!);
    }
    return observers;
  }

  Widget defaultBuilder(BuildContext context, Widget? child) {
    return Directionality(
      textDirection: _getTextDirection(),
      child:
          builder == null
              ? (child ?? const Material())
              : builder!(context, child ?? const Material()),
    );
  }

  TextDirection _getTextDirection() {
    return textDirection ??
        (rtlLanguages.contains(Get.locale?.languageCode)
            ? TextDirection.rtl
            : TextDirection.ltr);
  }

  Route<dynamic> generator(RouteSettings settings) {
    return PageRedirect(settings: settings, unknownRoute: unknownRoute).page();
  }

  List<Route<dynamic>> initialRoutesGenerate(String name) {
    return [
      PageRedirect(
        settings: RouteSettings(name: name),
        unknownRoute: unknownRoute,
      ).page(),
    ];
  }
}
