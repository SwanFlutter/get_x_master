# Get Instance Management

This section of the code is responsible for managing dependencies and class instances in your application. With this system, you can easily create, manage, and delete class instances.

---

## Key Features

- **Smart Dependency Management**
- **Memory Optimization**
- **Automatic Lifecycle Management**
- **Lazy Loading Support**
- **Automatic Controller Recreation**

---

## Different Types of Bindings

### 1. Traditional Bindings Class

#### Simple Example:
```dart
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
```

#### Advanced Example with Multiple Controllers:
```dart
class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Global controllers needed throughout the app
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<ThemeController>(ThemeController(), permanent: true);

    // Lazy controllers created only when needed
    Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<SettingsController>(() => SettingsController());

    // Smart controllers with automatic recreation
    Get.smartLazyPut<NotificationController>(() => NotificationController());
  }
}
```

### 2. BindingsBuilder - Simple Approach

#### For Single Controller:
```dart
// Using put (immediate creation)
GetPage(
  name: '/home',
  page: () => HomePage(),
  binding: BindingsBuilder<HomeController>.put(() => HomeController()),
)

// Using lazyPut (creation when needed)
GetPage(
  name: '/profile',
  page: () => ProfilePage(),
  binding: BindingsBuilder<ProfileController>.lazyPut(
    () => ProfileController(),
    fenix: true, // automatic recreation
  ),
)

// Using smartLazyPut (recommended)
GetPage(
  name: '/courses',
  page: () => CoursesPage(),
  binding: BindingsBuilder<CoursesController>.smartLazyPut(
    () => CoursesController(),
    fenix: true,
  ),
)
```

#### For Multiple Controllers:
```dart
GetPage(
  name: '/dashboard',
  page: () => DashboardPage(),
  binding: BindingsBuilder(() {
    Get.smartLazyPut<DashboardController>(() => DashboardController());
    Get.smartLazyPut<AnalyticsController>(() => AnalyticsController());
    Get.smartLazyPut<ReportsController>(() => ReportsController());
  }),
)
```

### 3. Conditional Bindings

```dart
class ConditionalBinding extends Bindings {
  @override
  void dependencies() {
    // Check authentication status
    if (Get.find<AuthController>().isLoggedIn) {
      Get.smartLazyPut<UserDashboardController>(() => UserDashboardController());
      Get.smartLazyPut<UserProfileController>(() => UserProfileController());
    } else {
      Get.smartLazyPut<GuestController>(() => GuestController());
      Get.smartLazyPut<LoginController>(() => LoginController());
    }

    // Check user role
    final userRole = Get.find<AuthController>().userRole;
    switch (userRole) {
      case UserRole.admin:
        Get.smartLazyPut<AdminController>(() => AdminController());
        break;
      case UserRole.teacher:
        Get.smartLazyPut<TeacherController>(() => TeacherController());
        break;
      case UserRole.student:
        Get.smartLazyPut<StudentController>(() => StudentController());
        break;
    }
  }
}
```

### 4. Tagged Bindings

```dart
class TaggedBinding extends Bindings {
  @override
  void dependencies() {
    // Multiple instances of one controller with different tags
    Get.smartLazyPut<CourseController>(
      () => CourseController(courseType: 'programming'),
      tag: 'programming_courses',
    );

    Get.smartLazyPut<CourseController>(
      () => CourseController(courseType: 'design'),
      tag: 'design_courses',
    );

    Get.smartLazyPut<CourseController>(
      () => CourseController(courseType: 'marketing'),
      tag: 'marketing_courses',
    );
  }
}

// Usage in page
class CoursePage extends StatelessWidget {
  final String courseTag;

  const CoursePage({required this.courseTag});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseController>(
      tag: courseTag,
      builder: (controller) => YourWidget(),
    );
  }
}
```

### 5. Nested Bindings

```dart
class MainAppBinding extends Bindings {
  @override
  void dependencies() {
    // Main app controllers
    Get.put<AppController>(AppController(), permanent: true);
    Get.put<NavigationController>(NavigationController(), permanent: true);
  }
}

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.smartLazyPut<AuthController>(() => AuthController());
    Get.smartLazyPut<LoginController>(() => LoginController());
    Get.smartLazyPut<RegisterController>(() => RegisterController());
  }
}

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.smartLazyPut<UserController>(() => UserController());
    Get.smartLazyPut<ProfileController>(() => ProfileController());
    Get.smartLazyPut<SettingsController>(() => SettingsController());
  }
}

// Usage in routes
final routes = [
  GetPage(
    name: '/',
    page: () => HomePage(),
    binding: MainAppBinding(),
  ),
  GetPage(
    name: '/auth',
    page: () => AuthPage(),
    bindings: [AuthBinding()], // Multiple bindings
  ),
  GetPage(
    name: '/user',
    page: () => UserPage(),
    bindings: [UserBinding(), AuthBinding()], // Combined bindings
  ),
];
```

### 6. Dynamic Bindings

```dart
class DynamicBinding extends Bindings {
  final Map<String, dynamic> parameters;

  DynamicBinding({required this.parameters});

  @override
  void dependencies() {
    final userId = parameters['userId'] as String?;
    final courseId = parameters['courseId'] as String?;

    if (userId != null) {
      Get.smartLazyPut<UserController>(
        () => UserController(userId: userId),
        tag: 'user_$userId',
      );
    }

    if (courseId != null) {
      Get.smartLazyPut<CourseController>(
        () => CourseController(courseId: courseId),
        tag: 'course_$courseId',
      );
    }
  }
}

// Usage
GetPage(
  name: '/user/:userId/course/:courseId',
  page: () => UserCoursePage(),
  binding: DynamicBinding(parameters: Get.parameters),
)
```

### 7. Service Bindings

```dart
class ServiceBinding extends Bindings {
  @override
  void dependencies() {
    // API services
    Get.put<ApiService>(ApiService(), permanent: true);
    Get.put<DatabaseService>(DatabaseService(), permanent: true);

    // Utility services
    Get.lazyPut<CacheService>(() => CacheService());
    Get.lazyPut<LoggingService>(() => LoggingService());

    // Business logic services
    Get.smartLazyPut<UserService>(() => UserService());
    Get.smartLazyPut<CourseService>(() => CourseService());
  }
}
```

## SmartLazyPut - Advanced Feature

`smartLazyPut` is an enhanced version of `lazyPut` that provides smarter controller management.

### SmartLazyPut Features:

- **Existence Check**: Before creation, checks if the controller is already registered
- **Automatic Recreation**: Provides recreation capability when disposed
- **Memory Management**: Automatically manages memory
- **Duplication Prevention**: Prevents re-registration of existing controllers

### Usage Example:

```dart
class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Using smartLazyPut
    Get.smartLazyPut<MyController>(() => MyController());

    // With additional parameters
    Get.smartLazyPut<UserController>(
      () => UserController(),
      tag: 'main_user',
      fenix: true, // automatic recreation
      autoRemove: true, // automatic removal
    );
  }
}

// Controller definition
class MyController extends GetxController {
  final count = 0.obs;

  void increment() {
    count.value++;
  }

  @override
  void onInit() {
    super.onInit();
    print('MyController initialized');
  }

  @override
  void onClose() {
    print('MyController disposed');
    super.onClose();
  }
}

// Usage in page
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyController>(
      builder: (controller) {
        return Scaffold(
          body: Center(
            child: Column(
              children: [
                Obx(() => Text('Count: ${controller.count}')),
                ElevatedButton(
                  onPressed: controller.increment,
                  child: Text('Increment'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
```

## Best Practices

### 1. Choosing the Right Binding Type:
```dart
// For global controllers
Get.put<AuthController>(AuthController(), permanent: true);

// For page controllers
Get.smartLazyPut<PageController>(() => PageController());

// For heavy controllers
Get.lazyPut<HeavyController>(() => HeavyController(), fenix: true);
```

### 2. Lifecycle Management:
```dart
class LifecycleBinding extends Bindings {
  @override
  void dependencies() {
    // Controllers that should always be in memory
    Get.put<CoreController>(CoreController(), permanent: true);

    // Controllers that can be disposed
    Get.smartLazyPut<TemporaryController>(() => TemporaryController());
  }
}
```

### 3. Using Tags:
```dart
// For multiple instances of one controller
Get.smartLazyPut<TabController>(() => TabController(), tag: 'tab1');
Get.smartLazyPut<TabController>(() => TabController(), tag: 'tab2');

// Access with tag
final tab1Controller = Get.find<TabController>(tag: 'tab1');
```

### 4. Status Checking:
```dart
// Check if registered
if (Get.isRegistered<MyController>()) {
  final controller = Get.find<MyController>();
}

// Check if prepared
if (Get.isPrepared<MyController>()) {
  // Controller is ready to be created
}
```
```

---

## Practical Real-World Examples

### 1. E-commerce Application

```dart
// Main app binding
class ShopAppBinding extends Bindings {
  @override
  void dependencies() {
    // Core services
    Get.put<ApiService>(ApiService(), permanent: true);
    Get.put<AuthService>(AuthService(), permanent: true);
    Get.put<CartService>(CartService(), permanent: true);

    // Global controllers
    Get.put<AppController>(AppController(), permanent: true);
    Get.smartLazyPut<ThemeController>(() => ThemeController());
  }
}

// Products page binding
class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.smartLazyPut<ProductsController>(() => ProductsController());
    Get.smartLazyPut<CategoryController>(() => CategoryController());
    Get.smartLazyPut<FilterController>(() => FilterController());
  }
}

// Cart binding
class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.smartLazyPut<CartController>(() => CartController());
    Get.smartLazyPut<CheckoutController>(() => CheckoutController());
  }
}

// Routes
final shopRoutes = [
  GetPage(
    name: '/',
    page: () => HomePage(),
    binding: ShopAppBinding(),
  ),
  GetPage(
    name: '/products',
    page: () => ProductsPage(),
    binding: ProductsBinding(),
  ),
  GetPage(
    name: '/cart',
    page: () => CartPage(),
    binding: CartBinding(),
  ),
];
```

### 2. Educational Application

```dart
// Student binding
class StudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.smartLazyPut<StudentDashboardController>(() => StudentDashboardController());
    Get.smartLazyPut<CourseListController>(() => CourseListController());
    Get.smartLazyPut<AssignmentController>(() => AssignmentController());
  }
}

// Teacher binding
class TeacherBinding extends Bindings {
  @override
  void dependencies() {
    Get.smartLazyPut<TeacherDashboardController>(() => TeacherDashboardController());
    Get.smartLazyPut<ClassManagementController>(() => ClassManagementController());
    Get.smartLazyPut<GradeController>(() => GradeController());
  }
}

// Role-based binding
class RoleBasedBinding extends Bindings {
  @override
  void dependencies() {
    final userRole = Get.find<AuthController>().userRole;

    switch (userRole) {
      case UserRole.student:
        StudentBinding().dependencies();
        break;
      case UserRole.teacher:
        TeacherBinding().dependencies();
        break;
      case UserRole.admin:
        Get.smartLazyPut<AdminController>(() => AdminController());
        break;
    }
  }
}
```

### 3. Chat Application

```dart
// Chat room binding
class ChatRoomBinding extends Bindings {
  final String roomId;

  ChatRoomBinding({required this.roomId});

  @override
  void dependencies() {
    Get.smartLazyPut<ChatController>(
      () => ChatController(roomId: roomId),
      tag: 'chat_$roomId',
    );

    Get.smartLazyPut<MessageController>(
      () => MessageController(roomId: roomId),
      tag: 'message_$roomId',
    );
  }
}

// Usage in route
GetPage(
  name: '/chat/:roomId',
  page: () => ChatPage(),
  binding: ChatRoomBinding(roomId: Get.parameters['roomId']!),
)
```

## Important Notes and Troubleshooting

### 1. Controller Not Found Issue

```dart
// ❌ Wrong
GetBuilder<MyController>(
  builder: (controller) => MyWidget(),
)

// ✅ Correct - with init
GetBuilder<MyController>(
  init: MyController(),
  builder: (controller) => MyWidget(),
)

// ✅ Correct - with binding
class MyBinding extends Bindings {
  @override
  void dependencies() {
    Get.smartLazyPut<MyController>(() => MyController());
  }
}
```

### 2. Memory Management

```dart
// For heavy controllers
Get.smartLazyPut<HeavyController>(
  () => HeavyController(),
  fenix: true, // recreation when needed
);

// For temporary controllers
Get.lazyPut<TemporaryController>(
  () => TemporaryController(),
  fenix: false, // no recreation
);
```

### 3. Status Check Before Usage

```dart
class SafeControllerAccess {
  static T? getSafeController<T>({String? tag}) {
    try {
      if (Get.isRegistered<T>(tag: tag)) {
        return Get.find<T>(tag: tag);
      }
    } catch (e) {
      print('Error accessing controller: $e');
    }
    return null;
  }

  static T getOrCreateController<T>(
    T Function() builder, {
    String? tag,
  }) {
    try {
      return Get.find<T>(tag: tag);
    } catch (e) {
      Get.smartLazyPut<T>(builder, tag: tag);
      return Get.find<T>(tag: tag);
    }
  }
}
```

### 4. Testing Bindings

```dart
void main() {
  group('Binding Tests', () {
    setUp(() {
      Get.reset(); // Clear all instances
    });

    test('should register controller correctly', () {
      // Arrange
      final binding = MyBinding();

      // Act
      binding.dependencies();

      // Assert
      expect(Get.isRegistered<MyController>(), true);
    });

    test('should create controller when needed', () {
      // Arrange
      final binding = MyBinding();
      binding.dependencies();

      // Act
      final controller = Get.find<MyController>();

      // Assert
      expect(controller, isA<MyController>());
    });
  });
}
```

## Summary and Recommendations

### Choosing the Right Approach:

1. **BindingsBuilder.smartLazyPut**: For most cases (recommended)
2. **Traditional Bindings**: For complex logic
3. **Get.put**: For global controllers
4. **Tagged bindings**: For multiple instances of one controller

### Performance Tips:

- Use `smartLazyPut` for automatic management
- Set `fenix: true` for controllers that might be disposed
- Use `permanent: true` only for global controllers
- Always check controller status before usage

### Complete App Example:

```dart
void main() {
  runApp(
    GetMaterialApp(
      title: 'My App',
      initialRoute: '/',
      initialBinding: AppBinding(), // Main binding
      getPages: [
        GetPage(
          name: '/',
          page: () => HomePage(),
          binding: BindingsBuilder<HomeController>.smartLazyPut(
            () => HomeController(),
          ),
        ),
        GetPage(
          name: '/profile',
          page: () => ProfilePage(),
          binding: ProfileBinding(),
        ),
      ],
    ),
  );
}

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<ThemeController>(ThemeController(), permanent: true);
  }
}
```

Using these approaches, controller management in your application will be optimized and reliable.
