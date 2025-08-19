# Get X Master

[![pub package](https://img.shields.io/pub/v/get_x_master.svg)](https://pub.dev/packages/get_x_master)
[![GitHub](https://img.shields.io/github/license/SwanFlutter/get_x_master)](https://github.com/SwanFlutter/get_x_master/blob/main/LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/SwanFlutter/get_x_master)](https://github.com/SwanFlutter/get_x_master/stargazers)

## ⚠️ Important Notice

**This package is an independent state management solution inspired by [GetX](https://pub.dev/packages/get) by [Jonny Borges](https://github.com/jonataslaw/getx).**

GetX Master is a completely separate implementation that provides similar functionality to GetX but with enhanced features, improved performance, and better compatibility with the latest Flutter updates. While inspired by GetX's design principles, this is an independent project developed from the ground up.

### Why GetX Master?

- Enhanced Cupertino support with Apple-authentic design elements
- **ReactiveGetView** - Smart reactive widgets with automatic UI updates
- Additional utility functions and extensions
- Improved compatibility with latest Flutter versions
- Independent development and maintenance
- Custom features tailored for modern Flutter development
- Intelligent state management without manual Obx() wrapping

### Inspiration

- **Inspired by:** GetX design principles
- **This Project:** Independent implementation with enhanced features

## Table of Contents

- [🚀 Key Features](#-key-features)
- [📦 Installation](#-installation)
- [🎯 Quick Start](#-quick-start)
  - [Material App Quick Start](#material-app-quick-start)
  - [Cupertino App Quick Start](#-quick-start-with-cupertino)
- [🏗️ Core Components](#️-core-components)
  - [State Management](#state-management)
  - [Navigation Management](#navigation-management)
  - [Dependency Injection](#dependency-injection)
  - [HTTP Client & WebSocket (GetConnect)](#http-client--websocket-getconnect)
  - [Animations](#animations)
  - [Utilities & Extensions](#utilities--extensions)
  - [Responsive Design](#responsive-design)
- [🆕 Enhanced Cupertino Support](#-enhanced-cupertino-support)
- [📚 Documentation Links](#-documentation-links)
- [🤝 Contributing](#-contributing)
- [📄 License](#-license)

## 🚀 Key Features

GetX Master is a comprehensive Flutter framework designed for modern app development, providing:

- **State Management:** Reactive programming with observable variables (`.obs`), `ReactiveGetView` for automatic UI updates, and `GetBuilder` for simple state management. It includes memory optimization with automatic controller lifecycle management.
- **Navigation Management:** Context-less navigation with named routes, route middleware, nested navigation, and beautiful custom transitions for pages, dialogs, and bottom sheets.
- **Dependency Injection:** Smart dependency management with lazy loading, automatic disposal, permanent instances, and an organized bindings system.
- **Networking:** A complete HTTP client (`GetConnect`) with RESTful API support, interceptors, request caching, and a robust WebSocket (`GetSocket`) implementation for real-time communication.
- **Animations:** A fluent API for creating beautiful, chained animations with ease. Includes fade, slide, scale, rotate, and more.
- **Utilities & Extensions:** A rich set of helpers for validation, string manipulation, platform detection, internationalization (i18n), and dynamic theme switching.
- **Responsive Design:** Build responsive UIs without `BuildContext` using pixel-perfect or percentage-based sizing, with automatic device and orientation detection.

## 📦 Installation

Add GetX Master to your `pubspec.yaml`:

```yaml
dependencies:
  get_x_master: ^0.0.15
```

Then run:

```bash
flutter pub get
```

## 🎯 Quick Start

### Material App Quick Start

1.  **Setup GetMaterialApp**

    ```dart
    import 'package:flutter/material.dart';
    import 'package:get_x_master/get_x_master.dart';

    void main() => runApp(MyApp());

    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return GetMaterialApp(
          title: 'GetX Master Demo',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: HomePage(),
        );
      }
    }
    ```

**2. Create a Controller**

> **Note:** The "X" in `GetXController` must be uppercase.

```dart
class CounterController extends GetXController {
  var count = 0.obs; // .obs makes it reactive
  void increment() => count++;
}
```



4.  **Use ReactiveGetView for Automatic Updates**

    ```dart
    class HomePage extends ReactiveGetView<CounterController> {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(title: Text('GetX Master Counter')),
          body: Center(
            child: Text(
              'Count: ${controller.count}', // Automatically updates
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: controller.increment,
            child: Icon(Icons.add),
          ),
        );
      }
    }
    ```

### 🚀 Quick Start with Cupertino

```dart
import 'package:flutter/cupertino.dart';
import 'package:get_x_master/get_x_master.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetCupertinoApp(
      title: 'My iOS App',
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.systemBlue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Home'),
      ),
      child: Center(
        child: CupertinoButton.filled(
          onPressed: () => Get.to(() => SecondPage()),
          child: Text('Navigate'),
        ),
      ),
    );
  }
}
```

## 🏗️ Core Components

### State Management

GetX Master offers multiple state management solutions:

- **Reactive Variables (`.obs`):** The simplest way to make a variable observable.
- **`ReactiveGetView`:** A smart widget that automatically rebuilds when its controller's observable variables change. No more `Obx()` or `GetX()` boilerplate.
- **`GetBuilder`:** A lightweight widget for manual state updates via `update()`, ideal for simple use cases.
- **`StateMixin`:** Handle UI states (loading, success, error, empty) with ease.

### Navigation Management

Navigate anywhere in your app without `BuildContext`:

- **`Get.to(NextScreen())`**: Navigate to a new screen.
- **`Get.toNamed('/details')`**: Navigate using named routes.
- **`Get.back()`**: Go back to the previous screen.
- **`Get.off(NextScreen())`**: Go to the next screen and remove the previous one.
- **`Get.offAll(NextScreen())`**: Go to the next screen and remove all previous screens.
- **Dialogs, BottomSheets, and Snackbars:** Show overlays from anywhere in your code.

### Dependency Injection

Manage your controllers and services effortlessly with a smart and flexible dependency injection system.

- **`Get.put()`**: Injects a dependency instantly. You can also make it permanent to persist throughout the app's lifecycle.
  ```dart
  // Simple injection
  Get.put(Controller());

  // Injection with a tag for multiple instances of the same controller
  Get.put(Controller(), tag: 'unique_tag');

  // Permanent instance that survives across routes
  Get.put(AuthService(), permanent: true);
  ```

- **`Get.lazyPut()`**: Lazily injects a dependency, meaning it will only be instantiated when it's first needed. Ideal for controllers of views that may not be accessed.
  ```dart
  Get.lazyPut(() => LoginController());
  
  // With fenix mode - recreates if deleted
  Get.lazyPut(() => SessionController(), fenix: true);
  ```

- **`Get.smartLazyPut()`** ⭐: Enhanced lazy injection with intelligent lifecycle management. Only creates if not registered and handles recreation automatically.
  ```dart
  Get.smartLazyPut(() => MyController());
  
  // With advanced options
  Get.smartLazyPut(() => ChatController(), fenix: true, autoRemove: true);
  ```

- **`Get.putAsync()`**: Injects a dependency that requires an asynchronous operation to be created.
  ```dart
  await Get.putAsync(() async {
    final prefs = await SharedPreferences.getInstance();
    return SettingsService(prefs);
  });
  ```

- **`Get.create()`**: Creates a new instance every time you call `Get.find()`. Perfect for creating multiple instances of a controller, for example, in a list of items.
  ```dart
  Get.create(() => ItemController());
  
  // Each find() returns a new instance
  final item1 = Get.find<ItemController>(); // New instance
  final item2 = Get.find<ItemController>(); // Another new instance
  ```

- **`Get.smartPut()`** ⭐: Advanced injection with conditional logic and validation.
  ```dart
  // Create only if condition is met
  Get.smartPut<DatabaseService>(
    builder: () => DatabaseService(),
    condition: () => NetworkManager.isConnected,
    permanent: true
  );
  ```

- **`Get.smartPutIf()`** ⭐: Most advanced injection with fallback mechanisms.
  ```dart
  final userService = Get.smartPutIf<UserService>(
    primaryCondition: () => AuthManager.isLoggedIn,
    builder: () => AuthenticatedUserService(),
    fallbackBuilder: () => GuestUserService(),
  );
  ```

- **`Get.find()`**: Finds a registered dependency. GetX will find the correct instance from anywhere in your app.
  ```dart
  final controller = Get.find<MyController>();
  
  // With tag
  final taggedController = Get.find<MyController>(tag: 'special');
  ```

- **`Get.smartFind()`** ⭐: Enhanced find that ensures the controller exists and provides better error handling.
  ```dart
  // Automatically creates if prepared but not instantiated
  final controller = Get.smartFind<MyController>();
  ```

- **Bindings**: Decouple dependency injection from the UI by declaring all dependencies for a specific route in a `Bindings` class. This ensures that when a route is removed, all its related dependencies are also removed from memory.
  ```dart
  // Traditional Binding
  class HomeBinding extends Bindings {
    @override
    void dependencies() {
      Get.smartLazyPut(() => HomeController());
      Get.lazyPut(() => ApiService());
    }
  }
  
  // BindingsBuilder for simple cases
  GetPage(
    name: '/home',
    page: () => HomeView(),
    binding: BindingsBuilder.smartLazyPut(() => HomeController()),
  )
  ```

- **`GetxService`**: A special controller that persists in memory. It's never removed and is ideal for services that need to be available throughout the entire app lifecycle, like `AuthService` or `StorageService`.
  ```dart
  class AuthService extends GetxService {
    // This service will persist throughout the app lifecycle
  }
  ```

- **Instance Management**:
  ```dart
  // Check if registered
  if (Get.isRegistered<MyController>()) {
    // Controller is available
  }
  
  // Check if prepared (lazy)
  if (Get.isPrepared<MyController>()) {
    // Ready to be instantiated
  }
  
  // Delete instance
  Get.delete<MyController>();
  
  // Replace instance
  Get.replace<MyService>(newServiceInstance);
  
  // Lazy replace
  Get.lazyReplace<MyService>(() => NewServiceInstance());
  ```

For more detailed information, check out the [Dependency Injection Documentation](lib/src/get_instance/README.md).

### HTTP Client & WebSocket (GetConnect)

A powerful networking library built into GetX Master:

- **RESTful Client:** Make `get`, `post`, `put`, `delete` requests with a simple API.
- **Customization:** Configure base URL, timeout, interceptors, and authenticators.
- **WebSocket (`GetSocket`):** Easily connect to WebSocket servers, send and receive messages, and handle events.

### Animations

A fluent API to create stunning animations with minimal code:

```dart
// Chain multiple animations
Text('Hello World')
  .fadeIn(duration: Duration(milliseconds: 500))
  .slideInFromLeft(delay: Duration(milliseconds: 200))
  .scaleIn(delay: Duration(milliseconds: 400));
```

### Utilities & Extensions

A rich set of helper functions and extensions:

- **Validation:** `.isEmail`, `.isPhoneNumber`, `.isURL`, etc.
- **String Manipulation:** `.capitalize`, `.toCamelCase`, etc.
- **Platform Detection:** `GetPlatform.isAndroid`, `GetPlatform.isIOS`, `GetPlatform.isWeb`.
- **Internationalization (i18n):** Built-in support for multiple languages.
- **Theme Management:** `Get.changeTheme()` to switch between light and dark themes.

### Responsive Design

Create responsive UIs that adapt to different screen sizes:

- **`GetResponsiveView`:** Build different layouts for mobile, tablet, and desktop.
- **Screen Utils:** Use `.wp` (width percentage), `.hp` (height percentage), `.sp` (scalable pixels) for responsive sizing.

## 🆕 Enhanced Cupertino Support

GetX now includes full support for the latest Flutter Cupertino features, bringing authentic iOS design to your applications:

! https://github.com/user-attachments/assets/22a912c6-2ca4-4d0e-829c-151e840ddf10

### 🔥 New Cupertino Features

#### **Rounded Superellipse (Apple Squircle)**

- ✅ **Apple-authentic shapes** with smooth, continuous curves
- ✅ **Automatic integration** in `CupertinoAlertDialog` and `CupertinoActionSheet`
- ✅ **Custom shape APIs** for your own widgets
- ✅ **Cross-platform support** with graceful fallbacks

```dart
// Enhanced GetCupertinoApp with new features
GetCupertinoApp(
  theme: CupertinoThemeData(
    primaryColor: CupertinoColors.systemBlue,
    brightness: Brightness.light,
  ),
  scrollBehavior: CupertinoScrollBehavior(),
  restorationId: 'my_app',
  home: MyHomePage(),
)

// Using new squircle shapes
Container(
  decoration: ShapeDecoration(
    color: CupertinoColors.systemBlue,
    shape: RoundedSuperellipseBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
)
```

#### **Enhanced Cupertino Sheets**

- ✅ **Improved animations** and transitions
- ✅ **Better navigation bar** height handling
- ✅ **Enhanced drag behavior** with `enableDrag` parameter
- ✅ **Fixed content clipping** issues

```dart
// Enhanced sheet with new features
showCupertinoModalPopup(
  context: context,
  builder: (context) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    child: YourSheetContent(),
  ),
)
```

#### **Improved Navigation**

- ✅ **Smoother transitions** matching latest iOS
- ✅ **Better search field** alignment in `CupertinoSliverNavigationBar`
- ✅ **Enhanced icon positioning** and animations

### 📱 GetCupertinoApp vs GetMaterialApp

| Feature          | GetMaterialApp  | GetCupertinoApp |
| ---------------- | --------------- | --------------- |
| Design System    | Material Design | iOS/Cupertino   |
| Widgets          | Material widgets| Cupertino widgets|
| Squircle Support | ❌              | ✅              |
| iOS Authenticity | Good            | Excellent       |
| Cross-platform   | ✅              | ✅              |

## 📚 Documentation Links

- [Enhanced GetBuilder Widgets Guide](ENHANCED_GETBUILDER_GUIDE.md)
- [Cupertino Features Guide](CUPERTINO_FEATURES_GUIDE.md)
- [Material/Cupertino Mixing Guide](MATERIAL_CUPERTINO_MIXING_GUIDE.md)
- [Lifecycle Error Fix Guide](LIFECYCLE_ERROR_FIX_GUIDE.md)

These links will help you access the full documentation and detailed information about each section.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
