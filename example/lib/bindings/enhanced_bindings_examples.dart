import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

import '../controller/courses_controller.dart';

/// Examples of different binding approaches using enhanced BindingsBuilder

/// 1. Traditional Bindings class approach (Recommended for complex dependencies)
class CoursesBinding extends Bindings {
  @override
  void dependencies() {
    // Using smartLazyPut for intelligent lifecycle management
    Get.smartLazyPut<CoursesController>(
      () => CoursesController(),
      fenix: true, // Allows recreation after disposal
    );
  }
}

/// 2. Using BindingsBuilder with smartLazyPut (Recommended for simple cases)
class SmartBindingsExamples {
  /// Best practice: Using smartLazyPut for automatic lifecycle management
  static Bindings get coursesSmartBinding =>
      BindingsBuilder<CoursesController>.smartLazyPut(
        () => CoursesController(),
        fenix: true, // Controller will be recreated if disposed
      );

  /// Alternative: Using lazyPut for manual lifecycle control
  static Bindings get coursesLazyBinding =>
      BindingsBuilder<CoursesController>.lazyPut(
        () => CoursesController(),
        fenix: true,
      );

  /// For immediate creation: Using put
  static Bindings get coursesPutBinding =>
      BindingsBuilder<CoursesController>.put(
        () => CoursesController(),
        permanent: false,
      );

  /// Custom binding with multiple dependencies
  static Bindings get multipleBinding => BindingsBuilder(() {
        // Register multiple controllers
        Get.smartLazyPut<CoursesController>(() => CoursesController());
        // Add more controllers as needed
        // Get.smartLazyPut<AuthController>(() => AuthController());
        // Get.smartLazyPut<UserController>(() => UserController());
      });
}

/// 3. Route definitions with different binding approaches
class AppRoutes {
  static const String courses = '/courses';
  static const String coursesLazy = '/courses-lazy';
  static const String coursesSmart = '/courses-smart';

  static List<GetPage> get pages => [
        // Using traditional Bindings class
        GetPage(
          name: courses,
          page: () => const CoursesPage(),
          binding: CoursesBinding(),
        ),

        // Using BindingsBuilder.smartLazyPut (Recommended)
        GetPage(
          name: coursesSmart,
          page: () => const CoursesPage(),
          binding: SmartBindingsExamples.coursesSmartBinding,
        ),

        // Using BindingsBuilder.lazyPut
        GetPage(
          name: coursesLazy,
          page: () => const CoursesPage(),
          binding: SmartBindingsExamples.coursesLazyBinding,
        ),
      ];
}

/// 4. Advanced binding patterns for different scenarios

/// For controllers that should persist across routes
class PersistentBindings extends Bindings {
  @override
  void dependencies() {
    // Controllers that should stay in memory
    Get.put<AuthController>(AuthController(), permanent: true);

    // Controllers that can be recreated when needed
    Get.smartLazyPut<CoursesController>(() => CoursesController());
  }
}

/// For conditional controller registration
class ConditionalBindings extends Bindings {
  @override
  void dependencies() {
    // Only register if not already registered
    if (!Get.isRegistered<CoursesController>()) {
      Get.smartLazyPut<CoursesController>(() => CoursesController());
    }

    // Register with different configurations based on conditions
    if (isUserLoggedIn()) {
      Get.smartLazyPut<UserDashboardController>(
        () => UserDashboardController(),
      );
    } else {
      Get.smartLazyPut<GuestController>(() => GuestController());
    }
  }

  bool isUserLoggedIn() {
    // Your authentication logic here
    return false; // Placeholder
  }
}

/// For tagged controllers (multiple instances of same type)
class TaggedBindings extends Bindings {
  @override
  void dependencies() {
    // Different instances for different purposes
    Get.smartLazyPut<CoursesController>(
      () => CoursesController(),
      tag: 'main_courses',
    );

    Get.smartLazyPut<CoursesController>(
      () => CoursesController(),
      tag: 'featured_courses',
    );
  }
}

/// 5. Binding utilities for manual controller management

class BindingUtils {
  /// Safely initialize a controller with fallback
  static T safeInitialize<T>(
    T Function() builder, {
    String? tag,
    bool useSmart = true,
  }) {
    try {
      return Get.find<T>(tag: tag);
    } catch (e) {
      if (useSmart) {
        Get.smartLazyPut<T>(builder, tag: tag);
      } else {
        Get.put<T>(builder(), tag: tag);
      }
      return Get.find<T>(tag: tag);
    }
  }

  /// Check if binding is properly configured
  static bool isBindingConfigured<T>({String? tag}) {
    return Get.isRegistered<T>(tag: tag) || Get.isPrepared<T>(tag: tag);
  }

  /// Reset and reinitialize controller
  static T resetController<T>(T Function() builder, {String? tag}) {
    if (Get.isRegistered<T>(tag: tag)) {
      Get.delete<T>(tag: tag);
    }
    Get.smartLazyPut<T>(builder, tag: tag);
    return Get.find<T>(tag: tag);
  }
}

/// Example usage in your app:
///
/// ```dart
/// void main() {
///   runApp(
///     GetMaterialApp(
///       initialRoute: AppRoutes.coursesSmart,
///       getPages: AppRoutes.pages,
///       // Global bindings that persist throughout the app
///       initialBinding: PersistentBindings(),
///     ),
///   );
/// }
/// ```

// Placeholder classes for examples
class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Courses Page')));
  }
}

class AuthController extends GetXController {}

class UserDashboardController extends GetXController {}

class GuestController extends GetXController {}
