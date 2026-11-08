import 'package:get_x_master/get_x_master.dart';

import '../async_builder_example.dart' as async_builder;
import '../conditional_navigation_example.dart' as conditional_nav;
import '../controller/courses_controller.dart' as courses_ctrl;
import '../controller/theme_controller.dart' as theme_ctrl;
import '../cupertino/cupertino_features_example.dart' as cupertino_features;
import '../cupertino/simple_cupertino_example.dart' as cupertino_simple;
import '../enhanced_responsive_demo.dart' as enhanced_responsive;
import '../feature/bottom_sheet_test.dart' as bottom_sheet;
import '../get_connect/get_connect_example.dart' as get_connect;
import '../main_alternative.dart' as alt_main;
import '../main_with_service.dart' as with_service;
import '../new.dart' as new_screens;
import '../new_responsive_example.dart' as new_responsive;
import '../reactive_get_view_demo.dart' as reactive_demo;
import '../reactive_get_view_example.dart' as reactive_example;
import '../responsive/responsive_example.dart' as responsive_example;
import '../responsive_demo.dart' as responsive_demo;
import '../responsive_test_example.dart' as responsive_test;
import '../screen/courses_page.dart' as courses_page;
import '../screen/cupertino_login.dart' as cupertino_login;
import '../screen/home.dart' as home_screen;
import '../screen/hybrid_login.dart' as hybrid_login;
import '../screen/login.dart' as login_screen;
import '../screen/signup.dart' as signup_screen;
import '../services/auth_service.dart' as auth_service;
import '../show_loader_on_widget_example.dart' as show_loader;
import '../test_conditional_navigation.dart' as test_conditional;
import '../test_error_handling.dart' as error_handling;
import '../test_expandable_bottomsheet.dart' as expandable_sheet;
import '../test_identity_validator.dart' as identity_validator;
import '../test_validate_passsword.dart' as password_validator;
import '../unified_responsive_example.dart' as unified_responsive;
import '../widgets/enhanced_getbuilder_examples.dart' as enhanced_builder;
import 'demo_entry.dart';

/// Registers [T] only when it is not already in the container.
void _ensure<T extends GetXController>(T Function() create) {
  if (!Get.isRegistered<T>()) Get.put<T>(create());
}

/// Every runnable example of the package, in one list.
final List<DemoEntry> demoRegistry = <DemoEntry>[
  // ── State & Reactive ──────────────────────────────────────────────
  DemoEntry(
    title: 'Async builder + StateMixin',
    subtitle: 'GetConnect posts list with loading / error / success states',
    category: DemoCategory.state,
    builder: (_) => const async_builder.AsyncBuilderExample(),
  ),
  DemoEntry(
    title: 'Reactive GetView demo',
    subtitle: 'Counter with reactive GetView',
    category: DemoCategory.state,
    builder: (_) => const reactive_demo.ReactiveGetViewDemo(),
  ),
  DemoEntry(
    title: 'SafeReactiveGetView counter',
    subtitle: 'SafeReactiveGetView vs traditional GetView',
    category: DemoCategory.state,
    prepare: () => _ensure(() => reactive_example.ExampleCounterController()),
    builder: (_) => const reactive_example.CounterView(),
  ),
  DemoEntry(
    title: 'Enhanced GetBuilder + Obx',
    subtitle: 'GetBuilder with observables',
    category: DemoCategory.state,
    prepare: () => _ensure(() => enhanced_builder.EnhancedController()),
    builder: (_) => const enhanced_builder.GetBuilderObsExample(),
  ),
  DemoEntry(
    title: 'Multi Obx',
    subtitle: 'Several observables in one tree',
    category: DemoCategory.state,
    prepare: () => _ensure(() => enhanced_builder.EnhancedController()),
    builder: (_) => const enhanced_builder.MultiObxExample(),
  ),
  DemoEntry(
    title: 'Context extensions',
    subtitle: 'context.width, context.theme and friends',
    category: DemoCategory.state,
    prepare: () => _ensure(() => enhanced_builder.EnhancedController()),
    builder: (_) => const enhanced_builder.ContextExtensionsExample(),
  ),
  DemoEntry(
    title: 'Show loader on widget',
    subtitle: 'Loader overlay on a single widget',
    category: DemoCategory.state,
    prepare: () => _ensure(() => show_loader.LoaderExampleController()),
    builder: (_) => const show_loader.ShowLoaderOnWidgetExample(),
  ),
  DemoEntry(
    title: 'Theme switching (ColorStudio)',
    subtitle: 'ThemeController with smartFind alternatives',
    category: DemoCategory.state,
    prepare: () => _ensure(() => theme_ctrl.ThemeController()),
    builder: (_) => const alt_main.HomeScreen(),
  ),
  DemoEntry(
    title: 'GetxService demo',
    subtitle: 'Permanent AuthService, login and dashboard',
    category: DemoCategory.state,
    prepare: () {
      if (!Get.isRegistered<auth_service.AuthService>()) {
        Get.put(auth_service.AuthService(), permanent: true);
      }
    },
    builder: (_) => const with_service.LoginScreen(),
  ),

  // ── Navigation ────────────────────────────────────────────────────
  DemoEntry(
    title: 'Conditional navigation',
    subtitle: 'Auth / onboarding / premium route conditions',
    category: DemoCategory.navigation,
    builder: (_) => const conditional_nav.StartPage(),
  ),
  DemoEntry(
    title: 'Conditional navigation test',
    subtitle: 'Toggle auth and premium flags, then navigate',
    category: DemoCategory.navigation,
    builder: (_) => const test_conditional.ConditionalNavTestHome(),
  ),
  DemoEntry(
    title: 'Simple screens (Screen / Screen2)',
    subtitle: 'Basic Get.to navigation',
    category: DemoCategory.navigation,
    builder: (_) => const new_screens.Screen(),
  ),

  // ── Responsive ────────────────────────────────────────────────────
  DemoEntry(
    title: 'Unified responsive access',
    subtitle: 'All responsive helpers inside GetResponsiveBuilder',
    category: DemoCategory.responsive,
    builder: (_) => const unified_responsive.UnifiedResponsiveHome(),
  ),
  DemoEntry(
    title: 'Responsive test',
    subtitle: 'Comprehensive responsive feature test',
    category: DemoCategory.responsive,
    builder: (_) => const responsive_test.ResponsiveTestHome(),
  ),
  DemoEntry(
    title: 'Responsive demo',
    subtitle: 'Breakpoints, cards and layouts',
    category: DemoCategory.responsive,
    builder: (_) => const responsive_demo.ResponsiveDemo(),
  ),
  DemoEntry(
    title: 'Responsive example',
    subtitle: 'Extended responsive example',
    category: DemoCategory.responsive,
    builder: (_) => const responsive_example.ResponsiveExample(),
  ),
  DemoEntry(
    title: 'Enhanced responsive demo',
    subtitle: 'Enhanced responsive builder',
    category: DemoCategory.responsive,
    builder: (_) => const enhanced_responsive.EnhancedResponsiveDemo(),
  ),
  DemoEntry(
    title: 'New responsive example',
    subtitle: 'Newest responsive API',
    category: DemoCategory.responsive,
    builder: (_) => const new_responsive.NewResponsiveExample(),
  ),

  // ── Network ───────────────────────────────────────────────────────
  DemoEntry(
    title: 'GetConnect',
    subtitle: 'HTTP client and WebSocket tabs',
    category: DemoCategory.network,
    builder: (_) => const get_connect.GetConnectExample(),
  ),
  DemoEntry(
    title: 'Error handling',
    subtitle: 'REST + GraphQL errors, retries and status codes',
    category: DemoCategory.network,
    builder: (_) => const error_handling.TestErrorHandling(),
  ),

  // ── Forms & Validation ────────────────────────────────────────────
  DemoEntry(
    title: 'Identity validator',
    subtitle: 'National ID validation',
    category: DemoCategory.forms,
    builder: (_) => const identity_validator.TestIdentityValidator(),
  ),
  DemoEntry(
    title: 'Password validator',
    subtitle: 'Password strength rules',
    category: DemoCategory.forms,
    builder: (_) => const password_validator.TestValidatePasssword(),
  ),

  // ── UI & Sheets ───────────────────────────────────────────────────
  DemoEntry(
    title: 'Expandable bottom sheet',
    subtitle: 'Basic, from-top and expandable sheets',
    category: DemoCategory.ui,
    builder: (_) => const expandable_sheet.TestExpandableBottomSheet(),
  ),
  DemoEntry(
    title: 'Bottom sheet test',
    subtitle: 'Get.bottomSheet scenarios',
    category: DemoCategory.ui,
    builder: (_) => const bottom_sheet.BottomSheetTest(),
  ),

  // ── Full screens ──────────────────────────────────────────────────
  DemoEntry(
    title: 'Login (Material)',
    subtitle: 'LoginController with form validation',
    category: DemoCategory.screens,
    builder: (_) => const login_screen.LoginPage(),
  ),
  DemoEntry(
    title: 'Login (hybrid)',
    subtitle: 'Material + Cupertino mixed login page',
    category: DemoCategory.screens,
    style: DemoStyle.material,
    builder: (_) => const hybrid_login.HybridLoginPage(),
  ),
  DemoEntry(
    title: 'Sign up',
    subtitle: 'SignupController form',
    category: DemoCategory.screens,
    builder: (_) => const signup_screen.SignUp(),
  ),
  DemoEntry(
    title: 'Home',
    subtitle: 'Home screen with login widget',
    category: DemoCategory.screens,
    builder: (_) => const home_screen.Home(),
  ),
  DemoEntry(
    title: 'Courses',
    subtitle: 'CoursesController list and add',
    category: DemoCategory.screens,
    prepare: () => _ensure(() => courses_ctrl.CoursesController()),
    builder: (_) => const courses_page.CoursesPage(),
  ),

  // ── Cupertino ─────────────────────────────────────────────────────
  DemoEntry(
    title: 'Cupertino features',
    subtitle: 'Squircle, sheets and navigation',
    category: DemoCategory.cupertino,
    style: DemoStyle.cupertino,
    builder: (_) => const cupertino_features.CupertinoFeaturesExample(),
  ),
  DemoEntry(
    title: 'Simple Cupertino',
    subtitle: 'Cupertino page with GetXController',
    category: DemoCategory.cupertino,
    style: DemoStyle.cupertino,
    builder: (_) => const cupertino_simple.SimpleCupertinoExample(),
  ),
  DemoEntry(
    title: 'Login (Cupertino)',
    subtitle: 'iOS-style login page',
    category: DemoCategory.cupertino,
    style: DemoStyle.cupertino,
    builder: (_) => const cupertino_login.CupertinoLoginPage(),
  ),
];
