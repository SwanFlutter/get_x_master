import 'package:flutter/foundation.dart';
import 'package:get_x_master/get_x_master.dart';

import '../controller/courses_controller.dart';
import '../screen/courses_page.dart';

/// Binding class for CoursesController
/// This ensures the controller is properly registered when the page is accessed
class CoursesBinding extends Bindings {
  @override
  void dependencies() {
    // Method 1: Using smartLazyPut (Recommended)
    // This will only create the controller when it's first accessed
    // and will recreate it if it was disposed
    Get.smartLazyPut<CoursesController>(
      () => CoursesController(),
      fenix: true, // Allows recreation after disposal
    );

    // Alternative methods:

    // Method 2: Using regular lazyPut
    // Get.lazyPut<CoursesController>(() => CoursesController(), fenix: true);

    // Method 3: Using put (creates immediately)
    // Get.put<CoursesController>(CoursesController());

    // Method 4: Using put with tag (for multiple instances)
    // Get.put<CoursesController>(CoursesController(), tag: 'main_courses');
  }
}

/// Alternative binding using BindingsBuilder for simpler cases
class CoursesBindingBuilder {
  static Bindings get binding => BindingsBuilder(() {
        Get.smartLazyPut<CoursesController>(() => CoursesController());
      });

  // Or using the put factory method
  static Bindings get putBinding => BindingsBuilder.put(
        () => CoursesController(),
        permanent: false, // Will be removed when not needed
      );
}

/// Example of how to use these bindings in your routes
class AppRoutes {
  static const String courses = '/courses';

  static List<GetPage> pages = [
    GetPage(
      name: courses,
      page: () => const CoursesPage(),
      binding: CoursesBinding(), // Use the binding
      // Alternative: binding: CoursesBindingBuilder.binding,
    ),
  ];
}

/// Example of manual controller management (without bindings)
class CoursesControllerManager {
  /// Initialize controller manually
  static CoursesController initialize() {
    if (Get.isRegistered<CoursesController>()) {
      return Get.find<CoursesController>();
    } else {
      return Get.put<CoursesController>(CoursesController());
    }
  }

  /// Initialize with smart management
  static CoursesController smartInitialize() {
    try {
      return Get.find<CoursesController>();
    } catch (e) {
      // Controller not found, create and register it
      Get.smartLazyPut<CoursesController>(() => CoursesController());
      return Get.find<CoursesController>();
    }
  }

  /// Safe initialization that won't throw errors
  static CoursesController? safeInitialize() {
    try {
      return Get.find<CoursesController>();
    } catch (e) {
      try {
        Get.smartLazyPut<CoursesController>(() => CoursesController());
        return Get.find<CoursesController>();
      } catch (e2) {
        if (kDebugMode) {
          print('Failed to initialize CoursesController: $e2');
        }
        return null;
      }
    }
  }

  /// Dispose controller manually
  static void dispose() {
    if (Get.isRegistered<CoursesController>()) {
      Get.delete<CoursesController>();
    }
  }

  /// Reset controller (dispose and recreate)
  static CoursesController reset() {
    dispose();
    return initialize();
  }
}

// Note: Import this file in your courses_page.dart:
// import '../bindings/courses_binding.dart';
