import 'package:get_x_master/get_x_master.dart';

/// Example CoursesController that demonstrates proper GetX controller usage
class CoursesController extends GetXController {
  // Static getter for easy access (optional)
  static CoursesController get to => Get.find<CoursesController>();

  // Observable variables
  final RxList<Course> courses = <Course>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxInt selectedCourseIndex = (-1).obs;

  @override
  void onInit() {
    super.onInit();
    loadCourses();
  }

  @override
  void onClose() {
    // Clean up resources
    super.onClose();
  }

  /// Load courses from API or local storage
  Future<void> loadCourses() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Mock data
      courses.value = [
        Course(
          id: 1,
          title: 'Flutter Development',
          description: 'Learn Flutter from scratch',
        ),
        Course(
          id: 2,
          title: 'Dart Programming',
          description: 'Master Dart language',
        ),
        Course(
          id: 3,
          title: 'State Management',
          description: 'GetX, Provider, Bloc',
        ),
      ];

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Failed to load courses: $e';
    }
  }

  /// Add a new course
  void addCourse(Course course) {
    courses.add(course);
    update(); // Trigger GetBuilder updates
  }

  /// Remove a course
  void removeCourse(int index) {
    if (index >= 0 && index < courses.length) {
      courses.removeAt(index);
      if (selectedCourseIndex.value == index) {
        selectedCourseIndex.value = -1;
      }
      update();
    }
  }

  /// Select a course
  void selectCourse(int index) {
    selectedCourseIndex.value = index;
    update(['course_selection']); // Update only specific GetBuilder with id
  }

  /// Get selected course
  Course? get selectedCourse {
    if (selectedCourseIndex.value >= 0 &&
        selectedCourseIndex.value < courses.length) {
      return courses[selectedCourseIndex.value];
    }
    return null;
  }

  /// Refresh courses
  Future<void> refreshCourses() async {
    await loadCourses();
  }
}

/// Course model
class Course {
  final int id;
  final String title;
  final String description;

  Course({required this.id, required this.title, required this.description});

  @override
  String toString() =>
      'Course(id: $id, title: $title, description: $description)';
}
