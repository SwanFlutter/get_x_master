# Get Instance Management

This section of the code is responsible for managing dependencies and instances of classes in your application. With this system, you can easily create, manage, and delete class instances.


---


## Key Features

# Smart Dependency Management Extension


## SmartLazyPut



The `smartLazyPut` extension enhances the standard `lazyPut` method from the GetX package, providing additional functionality for managing controller instances. This method ensures that controllers are only created when necessary, allowing for efficient memory usage and improved application performance.

#### Overview

The `smartLazyPut` method registers a controller with GetX, ensuring that the controller is only instantiated if it hasn't been registered before or if it has been removed. This extension checks if the builder for the controller has been prepared before proceeding with the registration.

#### Features Compared to Standard `lazyPut`

- **Controller Recreation Handling**: Unlike the standard `lazyPut`, which simply registers a controller, `smartLazyPut` checks if a controller is already registered or has been removed. If it has been removed, it allows for recreation, ensuring that you always have access to a valid instance.
  
- **Preparation Check**: Before registering a controller, `smartLazyPut` verifies if the builder has been prepared, adding an extra layer of safety to avoid unnecessary instantiation.

- **Automatic Memory Management**: The method automatically manages memory by ensuring that controllers are only created when needed. This is particularly useful in applications with complex navigation and multiple controllers.

#### Example Usage

```dart
// Define your controller
class MyController extends GetxController {
  final count = 0.obs;

  void increment() {
    count.value++;
  }
}

// In your main function or wherever you manage dependencies
void main() {
  // Using smartLazyPut to register MyController
  Get.smartLazyPut<MyController>(() => MyController());

  // Using smartFind to retrieve MyController
  MyController myController = Get.smartFind<MyController>();

  // Now you can use myController as needed
  myController.increment();
  print('Count: ${myController.count.value}');
}
```

### Parameters

- **builder**: A callback function that returns an instance of the controller.
- **tag**: An optional tag to identify the controller instance.
- **fenix**: If true (default), the controller instance will remain in memory even when not in use.
- **autoRemove**: If true, the controller instance will be automatically removed when not in use.

### Conclusion

The `smartLazyPut` extension provides a more robust and efficient way to manage controller instances in your GetX applications. By ensuring that controllers are only created when necessary and checking for existing registrations, this method enhances performance and reduces memory overhead compared to the standard `lazyPut`.




## Overview

The `SmartDependencyManagement` extension provides advanced dependency injection and management strategies for Dart applications using GetX.

## Methods

### 1. `smartPut<S>`

#### Description
Intelligently manages dependency injection with conditional logic and instance validation.

#### Example
```dart
class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.smartPut(
      builder: () => TodosController(),
      condition: () => true, // Optional condition
      validityCheck: (controller) => controller.todos.isEmpty,
      permanent: true,
    );
  }
}
```

### 2. `smartPutIf<S>`

#### Description
Advanced dependency management with primary and secondary conditions, including fallback mechanisms.

#### Example
```dart
class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.smartPutIf(
      primaryCondition: () => authController.isLoggedIn,
      builder: () => UserProfileController(),
      fallbackBuilder: () => GuestProfileController(),
      secondaryValidation: (controller) => controller.isProfileComplete(),
      enableLogging: true,
      permanent: true,
    );
  }
}
```

### 3. `lazyManage<S>`

#### Description
Simplified lazy initialization of dependencies with optional creation conditions.

#### Example
```dart
class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyManage(
      builder: () => ExpensiveServiceController(),
      initCondition: () => FeatureFlags.isAdvancedFeatureEnabled,
      permanent: false,
    );
  }
}
```

## Best Practices

- Use `smartPut` for simple conditional initialization
- Prefer `smartPutIf` for complex dependency scenarios
- Utilize `lazyManage` for performance-sensitive or optional services
- Always provide meaningful conditions and validation checks
- Enable logging during development for better debugging

## Use Cases

- Conditional service initialization
- Authentication-based dependency management
- Feature flag-controlled service creation
- Fallback strategies for dependencies
- Lazy loading of resource-intensive services

## Performance Considerations

- Minimal overhead for dependency management
- Efficient instance caching and reuse
- Supports multiple instances with tagging

---


# Authentication Dependency Management Example

## Scenario: Multi-Role Authentication System

### User Roles and Controllers
```dart
// Base authentication controller
class AuthController extends GetxController {
  final _userRole = UserRole.guest.obs;
  UserRole get userRole => _userRole.value;

  void login(String username, String password) {
    if (username == 'admin' && password == 'admin123') {
      _userRole.value = UserRole.admin;
    } else if (username == 'user' && password == 'user123') {
      _userRole.value = UserRole.premium;
    }
  }
}

// Enum for user roles
enum UserRole { guest, user, premium, admin }

// Different controllers for each role
class GuestController extends GetxController {
  List<String> get availableFeatures => ['limited_view'];
}

class UserController extends GetxController {
  List<String> get availableFeatures => ['basic_crud', 'profile_edit'];
}

class PremiumUserController extends GetxController {
  List<String> get availableFeatures => ['advanced_analytics', 'priority_support'];
}

class AdminController extends GetxController {
  List<String> get availableFeatures => [
    'user_management', 
    'system_config', 
    'full_dashboard_access'
  ];
}
```

### Smart Dependency Binding
```dart
class AuthBindings extends Bindings {
  @override
  void dependencies() {
    // Global authentication controller
    Get.put(AuthController(), permanent: true);

    // Smart role-based controller injection
    Get.smartPutIf(
      primaryCondition: () {
        final auth = Get.find<AuthController>();
        return auth.userRole != UserRole.guest;
      },
      builder: () {
        final auth = Get.find<AuthController>();
        switch (auth.userRole) {
          case UserRole.admin:
            return AdminController();
          case UserRole.premium:
            return PremiumUserController();
          case UserRole.user:
            return UserController();
          default:
            return GuestController();
        }
      },
      fallbackBuilder: () => GuestController(),
      permanent: false,
      enableLogging: true
    );
  }
}
```

### Usage Example
```dart
class LoginPage extends GetView<AuthController> {
  void performLogin(String username, String password) {
    controller.login(username, password);
    
    // Automatically loads appropriate role controller
    final roleController = Get.find<dynamic>();
    
    print('Available Features: ${roleController.availableFeatures}');
  }
}
```

## Key Benefits
- Dynamic role-based dependency injection
- Secure and flexible authentication management
- Automatic controller switching based on user role
- Fallback to guest controller for unauthorized access


--- 


# Advanced Smart Dependency Management Examples

## 1. Real-Time Chat System (`smartPut`)
```dart
// Real-time chat system with connection management
class ChatBindings extends Bindings {
  @override
  void dependencies() {
    // Socket connection controller with validation
    Get.smartPut<SocketController>(
      builder: () => SocketController(),
      condition: () => NetworkUtils.hasInternetConnection(),
      validityCheck: (controller) => controller.isConnectionActive(),
      permanent: true,
      fenix: true,
    );
  }
}

class SocketController extends GetxController {
  final _connection = WebSocketConnection();
  final _messages = <ChatMessage>[].obs;
  final _connectionStatus = ConnectionStatus.disconnected.obs;

  bool isConnectionActive() => 
    _connectionStatus.value == ConnectionStatus.connected;

  @override
  void onInit() {
    super.onInit();
    _initializeConnection();
    _setupHeartbeat();
  }

  void _initializeConnection() {
    _connection.connect();
    ever(_connectionStatus, (status) {
      if (status == ConnectionStatus.disconnected) {
        _attemptReconnect();
      }
    });
  }

  void _setupHeartbeat() {
    Timer.periodic(Duration(seconds: 30), (_) {
      if (!isConnectionActive()) {
        _attemptReconnect();
      }
    });
  }
}
```

## 2. Multi-Environment Configuration (`smartPutIf`)
```dart
// Advanced configuration management with environment-specific implementations
class ConfigBindings extends Bindings {
  @override
  void dependencies() {
    Get.smartPutIf<EnvironmentConfig>(
      primaryCondition: () => !isProduction(),
      builder: () => DevelopmentConfig(
        apiUrl: 'dev-api.example.com',
        features: DevFeatures(),
        loggingEnabled: true,
      ),
      fallbackBuilder: () => ProductionConfig(
        apiUrl: 'api.example.com',
        features: ProdFeatures(),
        loggingEnabled: false,
      ),
      secondaryValidation: (config) => config.validateConfiguration(),
      enableLogging: true,
      permanent: true,
    );
  }
}

abstract class EnvironmentConfig {
  String get apiUrl;
  FeatureFlags get features;
  bool get loggingEnabled;
  bool validateConfiguration();
}

class DevelopmentConfig implements EnvironmentConfig {
  final String apiUrl;
  final FeatureFlags features;
  final bool loggingEnabled;

  DevelopmentConfig({
    required this.apiUrl,
    required this.features,
    required this.loggingEnabled,
  });

  @override
  bool validateConfiguration() {
    return apiUrl.contains('dev') && loggingEnabled;
  }
}

class ProductionConfig implements EnvironmentConfig {
  // Similar implementation...
}
```

## 3. Resource-Intensive Analytics System (`lazyManage`)
```dart
// Analytics system with lazy loading and resource management
class AnalyticsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyManage<AnalyticsEngine>(
      builder: () => AnalyticsEngine(
        trackers: [
          PerformanceTracker(),
          UserBehaviorTracker(),
          ErrorTracker(),
        ],
        configuration: AnalyticsConfig(
          batchSize: 100,
          sendInterval: Duration(minutes: 5),
          maxStorageSize: 50 * 1024 * 1024, // 50MB
        ),
      ),
      initCondition: () => 
        DeviceResources.hasRequiredMemory() && 
        UserPreferences.analyticsEnabled &&
        !LowPowerMode.isActive,
      permanent: false,
    );
  }
}

class AnalyticsEngine extends GetxController {
  final List<BaseTracker> trackers;
  final AnalyticsConfig configuration;
  final _eventQueue = <AnalyticsEvent>[].obs;
  Timer? _batchTimer;

  AnalyticsEngine({
    required this.trackers,
    required this.configuration,
  });

  @override
  void onInit() {
    super.onInit();
    _initializeTrackers();
    _startBatchProcessing();
  }

  void _initializeTrackers() {
    for (var tracker in trackers) {
      tracker.initialize();
      tracker.onEvent.listen((event) {
        _eventQueue.add(event);
      });
    }
  }

  void _startBatchProcessing() {
    _batchTimer = Timer.periodic(
      configuration.sendInterval,
      (_) => _processBatch(),
    );
  }

  Future<void> _processBatch() async {
    if (_eventQueue.length >= configuration.batchSize) {
      final batch = _eventQueue.take(configuration.batchSize).toList();
      await _sendBatch(batch);
      _eventQueue.removeRange(0, configuration.batchSize);
    }
  }

  @override
  void onClose() {
    _batchTimer?.cancel();
    for (var tracker in trackers) {
      tracker.dispose();
    }
    super.onClose();
  }
}
```

These examples demonstrate:

1. **Socket Controller (`smartPut`)**
   - Real-time connection management
   - Automatic reconnection
   - Connection validity checking
   - Heartbeat monitoring

2. **Environment Config (`smartPutIf`)**
   - Environment-specific implementations
   - Configuration validation
   - Feature flag management
   - Conditional initialization

3. **Analytics Engine (`lazyManage`)**
   - Resource-aware initialization
   - Batch processing
   - Multiple tracking systems
   - Memory management
   - Event queuing

Each example showcases professional-grade implementation with:
- Proper resource management
- Error handling
- Configuration flexibility
- Performance optimization
- Clean architecture principles

