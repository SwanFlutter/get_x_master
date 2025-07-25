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

- [About GetX Master](#about-getx-master)
- [Key Features Overview](#-key-features-overview)
- [Enhanced Cupertino Support](#-enhanced-cupertino-support)
- [Installing](#installing)
- [Counter App with GetX Master](#counter-app-with-getx-master)
- [The Three pillars](#the-three-pillars)
  - [State management](#state-management)
    - [Reactive State Manager](#reactive-state-manager)
    - [ReactiveGetView - Smart Reactive Widget](#reactivegetview---smart-reactive-widget)
    - [More details about state management](#more-details-about-state-management)
  - [Route management](#route-management)
    - [More details about route management](#more-details-about-route-management)
  - [Dependency management](#dependency-management)
    - [More details about dependency management](#more-details-about-dependency-management)
  - [Animation Extensions](#animation-extensions)
  - [GetSocket - WebSocket Management](#getsocket---websocket-management)
- [Utils](#utils)
  - [Internationalization](#internationalization)
    - [Translations](#translations)
      - [Using translations](#using-translations)
    - [Locales](#locales)
      - [Change locale](#change-locale)
      - [System locale](#system-locale)
  - [Change Theme](#change-theme)
  - [GetConnect](#getconnect)
    - [Default configuration](#default-configuration)
    - [Custom configuration](#custom-configuration)
  - [GetPage Middleware](#getpage-middleware)
    - [Priority](#priority)
    - [Redirect](#redirect)
    - [onPageCalled](#onpagecalled)
    - [OnBindingsStart](#onbindingsstart)
    - [OnPageBuildStart](#onpagebuildstart)
    - [OnPageBuilt](#onpagebuilt)
    - [OnPageDispose](#onpagedispose)
  - [Other Advanced APIs](#other-advanced-apis)
    - [Optional Global Settings and Manual configurations](#optional-global-settings-and-manual-configurations)
    - [Local State Widgets](#local-state-widgets)
      - [ValueBuilder](#valuebuilder)
      - [ObxValue](#obxvalue)
  - [Useful tips](#useful-tips)
    - [GetView](#getview)
    - [ReactiveGetView](#reactivegetview)
    - [GetResponsiveView](#getresponsiveview)
      - [How to use it](#how-to-use-it)
    - [GetWidget](#getwidget)
    - [GetxService](#getxservice)
- [Why GetX Master?](#why-getx-master)
- [Contributing](#contributing)

# About GetX Master

- GetX Master is an independent, extra-light and powerful solution for Flutter. It combines high-performance state management, intelligent dependency injection, and route management quickly and practically, with enhanced features and modern compatibility.

To read the documentation for these sections, you can use the following links to navigate to the respective pages on GitHub:

- New features package and read documentation


- [GetX State Management](https://github.com/SwanFlutter/get_x_master/blob/main/lib/src/get_state_manager/README.md)
- [GetX Connect - HTTP Client & WebSocket](https://github.com/SwanFlutter/get_x_master/blob/main/lib/src/get_connect/README.md)
- [GetX Utilities](https://github.com/SwanFlutter/get_x_master/blob/main/lib/src/get_utils/README.md)
- [GetX Animations](https://github.com/SwanFlutter/get_x_master/blob/main/lib/src/get_animations/README.md)
- [GetX Instance Management](https://github.com/SwanFlutter/get_x_master/blob/main/lib/src/get_instance/README.md)
- [GetX Utils AND Extensions](https://github.com/SwanFlutter/get_x_master/blob/main/lib/src/get_utils/README.md)
- [New Features Get.customExpandableBottomSheet](https://github.com/SwanFlutter/get_x_master/tree/main/lib/src/get_navigation)

## 🚀 Key Features Overview

### 🎨 Animation Extensions
GetX Master provides powerful animation extensions that make creating beautiful animations effortless:

```dart
// Fluent animation chaining
myWidget
  .fadeIn(duration: Duration(seconds: 1))
  .scale(begin: 0.5, end: 1.0, isSequential: true)
  .bounce(begin: 1.0, end: 1.2, isSequential: true);

// Available animations: fadeIn, fadeOut, slide, rotate, scale, bounce,
// blur, flip, wave, size, color animations and more!
```

### 🔌 GetSocket - WebSocket Management
Advanced WebSocket implementation with automatic reconnection and event handling:

```dart
final socket = GetSocket('ws://localhost:8080');

socket.onOpen(() => print('Connected!'));
socket.onMessage((data) => print('Received: $data'));
socket.onError((error) => print('Error: $error'));

socket.emit('chat_message', {'text': 'Hello World!'});
```

### 🧠 Smart Dependency Injection

#### GetSmartPut - Intelligent Instance Management
```dart
// Smart conditional instance creation
Get.smartPutIf<UserService>(
  primaryCondition: () => AuthManager.isLoggedIn,
  builder: () => UserService(),
  fallbackBuilder: () => GuestUserService(),
  secondaryValidation: (service) => service.hasValidPermissions(),
);
```

#### GetSmartLazyPut - Enhanced Lazy Loading
```dart
// Smart lazy initialization with automatic recreation
Get.smartLazyPut<ApiController>(() => ApiController());

// With advanced options
Get.smartLazyPut<DatabaseController>(
  () => DatabaseController(),
  tag: 'main_db',
  fenix: true, // automatic recreation when needed
  autoRemove: true, // automatic cleanup
);
```

#### GetSmartIf - Conditional Logic
```dart
// Smart conditional dependency management
Get.smartManage<NotificationService>(
  condition: () => Platform.isAndroid || Platform.isIOS,
  validityCheck: (service) => service.isPermissionGranted(),
  builder: () => NotificationService(),
  fallback: MockNotificationService(),
);
```

### 🎯 Advanced Features
- **ReactiveGetView**: Automatic reactive UI updates without manual Obx() wrapping
- **Smart Bindings**: Intelligent dependency injection with BindingsBuilder
- **Enhanced Controllers**: GetxController with advanced lifecycle management
- **Animation Extensions**: 15+ built-in animation types with fluent API
- **WebSocket Support**: Full-featured GetSocket implementation
- **Event Loop Extensions**: Advanced async operation management
- **Responsive Utilities**: Built-in responsive design helpers

## 🆕 Enhanced Cupertino Support

GetX now includes full support for the latest Flutter Cupertino features, bringing authentic iOS design to your applications:

![get_x_cuoertino](https://github.com/user-attachments/assets/22a912c6-2ca4-4d0e-829c-151e840ddf10)


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

| Feature | GetMaterialApp | GetCupertinoApp |
|---------|----------------|-----------------|
| Design System | Material Design | iOS/Cupertino |
| Widgets | Material widgets | Cupertino widgets |
| Squircle Support | ❌ | ✅ |
| iOS Authenticity | Good | Excellent |
| Cross-platform | ✅ | ✅ |

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

### 📚 Documentation Links

- [Enhanced GetBuilder Widgets Guide](ENHANCED_GETBUILDER_GUIDE.md)
- [Cupertino Features Guide](CUPERTINO_FEATURES_GUIDE.md)
- [Material/Cupertino Mixing Guide](MATERIAL_CUPERTINO_MIXING_GUIDE.md)
- [Lifecycle Error Fix Guide](LIFECYCLE_ERROR_FIX_GUIDE.md)

These links will help you access the full documentation and detailed information about each section.





- GetX Master has 3 basic principles. This means that these are the priority for all resources in the library: **PRODUCTIVITY, PERFORMANCE AND ORGANIZATION.**

  - **PERFORMANCE:** GetX Master is focused on performance and minimum consumption of resources. GetX Master does not use Streams or ChangeNotifier.

  - **PRODUCTIVITY:** GetX Master uses an easy and pleasant syntax. No matter what you want to do, there is always an easier way with GetX Master. It will save hours of development and will provide the maximum performance your application can deliver.

    Generally, the developer should be concerned with removing controllers from memory. With GetX Master this is not necessary because resources are removed from memory when they are not used by default. If you want to keep it in memory, you must explicitly declare "permanent: true" in your dependency. That way, in addition to saving time, you are less at risk of having unnecessary dependencies on memory. Dependency loading is also lazy by default.

  - **ORGANIZATION:** GetX Master allows the total decoupling of the View, presentation logic, business logic, dependency injection, and navigation. You do not need context to navigate between routes, so you are not dependent on the widget tree (visualization) for this. You don't need context to access your controllers/blocs through an inheritedWidget, so you completely decouple your presentation logic and business logic from your visualization layer. You do not need to inject your Controllers/Models/Blocs classes into your widget tree through `MultiProvider`s. For this, GetX Master uses its own dependency injection feature, decoupling the DI from its view completely.

    With GetX Master you know where to find each feature of your application, having clean code by default. In addition to making maintenance easy, this makes the sharing of modules something that until then in Flutter was unthinkable, something totally possible.
    BLoC was a starting point for organizing code in Flutter, it separates business logic from visualization. GetX Master is a natural evolution of this, not only separating the business logic but the presentation logic. Bonus injection of dependencies and routes are also decoupled, and the data layer is out of it all. You know where everything is, and all of this in an easier way than building a hello world.
    GetX Master is the easiest, practical, and scalable way to build high-performance applications with the Flutter SDK. It offers a huge range of APIs built-in that are not present in the default Flutter SDK.

- GetX Master is not bloated. It has a multitude of features that allow you to start programming without worrying about anything, but each of these features are in separate containers and are only started after use. If you only use State Management, only State Management will be compiled. If you only use routes, nothing from the state management will be compiled.

- GetX Master is capable of running with the same code on Android, iOS, Web, Mac, Linux, Windows, and on your server.
  **Note:** GetX Master is a standalone solution that doesn't require additional tools or extensions.

# Installing

Add GetX Master to your pubspec.yaml file:

```yaml
dependencies:
  get_x_master: ^0.0.14
```

Import GetX Master in files that it will be used:

```dart
import 'package:get_x_master/get_x_master.dart';
```

# Counter App with GetX Master

The "counter" project created by default on new project on Flutter has over 100 lines (with comments). To show the power of GetX Master, I will demonstrate how to make a "counter" changing the state with each click, switching between pages and sharing the state between screens, all in an organized way, separating the business logic from the view, in ONLY 26 LINES CODE INCLUDING COMMENTS.

- Step 1:
  Add "Get" before your MaterialApp, turning it into GetMaterialApp

```dart

void main() => runApp(GetMaterialApp(home: Home()));

```

- Note: this does not modify the MaterialApp of the Flutter, GetMaterialApp is not a modified MaterialApp, it is just a pre-configured Widget, which has the default MaterialApp as a child. You can configure this manually, but it is definitely not necessary. GetMaterialApp will create routes, inject them, inject translations, inject everything you need for route navigation. If you use Get only for state management or dependency management, it is not necessary to use GetMaterialApp. GetMaterialApp is necessary for routes, snackbars, internationalization, bottomSheets, dialogs, and high-level apis related to routes and absence of context.
- Note²: This step is only necessary if you gonna use route management (`Get.to()`, `Get.back()` and so on). If you not gonna use it then it is not necessary to do step 1

- Step 2:
  Create your business logic class and place all variables, methods and controllers inside it.
  You can make any variable observable using a simple ".obs".

```dart

class Controller extends GetxController{
  var count = 0.obs;
  increment() => count++;
}

```

- Step 3:
  Create your View, use StatelessWidget and save some RAM, with Get you may no longer need to use StatefulWidget.

```dart

class Home extends StatelessWidget {

  @override
  Widget build(context) {

    // Instantiate your class using Get.put() to make it available for all "child" routes there.
    final Controller c = Get.put(Controller());

    return Scaffold(
      // Use Obx(()=> to update Text() whenever count is changed.
      appBar: AppBar(title: Obx(() => Text("Clicks: ${c.count}"))),

      // Replace the 8 lines Navigator.push by a simple Get.to(). You don't need context
      body: Center(child: ElevatedButton(
              child: Text("Go to Other"), onPressed: () => Get.to(Other()))),
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: c.increment));
  }
}

class Other extends StatelessWidget {
  // You can ask Get to find a Controller that is being used by another page and redirect you to it.
  final Controller c = Get.find();

  @override
  Widget build(context){
     // Access the updated count variable
     return Scaffold(body: Center(child: Text("${c.count}")));
  }
}

```

- New feature

```dart

class Home extends StatelessWidget {

  @override
  Widget build(context) {

    // Instantiate your class using Get.smartLazyPut() to make it available for all "child" routes there.
    final Controller c = Get.smartLazyPut(Controller());

    return Scaffold(
      // Use Obx(()=> to update Text() whenever count is changed.
      appBar: AppBar(title: Obx(() => Text("Clicks: ${c.count}"))),

      // Replace the 8 lines Navigator.push by a simple Get.to(). You don't need context
      body: Center(child: ElevatedButton(
              child: Text("Go to Other"), onPressed: () => Get.to(Other()))),
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: c.increment));
  }
}

class Other extends StatelessWidget {
  // You can ask Get to find a Controller that is being used by another page and redirect you to it.
  final Controller c = Get.smartFind();

  @override
  Widget build(context){
     // Access the updated count variable
     return Scaffold(body: Center(child: Text("${c.count}")));
  }
}

```

---

Result:

This is a simple project but it already makes clear how powerful GetX Master is. As your project grows, this difference will become more significant.

GetX Master was designed to work with teams, but it makes the job of an individual developer simple.

Improve your deadlines, deliver everything on time without losing performance. GetX Master is designed for developers who value productivity and clean code!

# The Three pillars

## State management

GetX Master has two different state managers: the simple state manager (we'll call it GetBuilder) and the reactive state manager (GetX/Obx)

### Reactive State Manager

Reactive programming can alienate many people because it is said to be complicated. GetX Master turns reactive programming into something quite simple:

- You won't need to create StreamControllers.
- You won't need to create a StreamBuilder for each variable
- You will not need to create a class for each state.
- You will not need to create a get for an initial value.
- You will not need to use code generators

Reactive programming with GetX Master is as easy as using setState.

Let's imagine that you have a name variable and want that every time you change it, all widgets that use it are automatically changed.

This is your count variable:

```dart

var name = 'Jonatas Borges';

```

To make it observable, you just need to add ".obs" to the end of it:

```dart

var name = 'Jonatas Borges'.obs;

```

And in the UI, when you want to show that value and update the screen whenever the values changes, simply do this:

```dart

Obx(() => Text("${controller.name}"));

```

That's all. It's _that_ simple.

### ReactiveGetView - Smart Reactive Widget

GetX Master introduces **ReactiveGetView**, an enhanced version of GetView that provides automatic reactive updates without manual Obx() wrapping:

#### Traditional GetView (requires Obx):
```dart
class CounterView extends GetView<CounterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.name.value)), // Need Obx
      ),
      body: Center(
        child: Obx(() => Text('Count: ${controller.count.value}')), // Need Obx
      ),
    );
  }
}
```

#### ReactiveGetView (automatic reactivity):
```dart
class CounterView extends ReactiveGetView<CounterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.name.value), // No Obx needed!
      ),
      body: Center(
        child: Text('Count: ${controller.count.value}'), // No Obx needed!
      ),
    );
  }
}
```

**Key Benefits:**
- ✅ **Automatic reactive updates** - No manual Obx() wrapping needed
- ✅ **Cleaner code** - More readable and maintainable
- ✅ **Better performance** - Intelligent rebuilding only when necessary
- ✅ **Full compatibility** - Works with all existing GetX features
- ✅ **Smart detection** - Automatically tracks observable variables

### More details about state management

**GetX Master provides comprehensive state management with both simple and reactive approaches.**

You will get a good idea of GetX Master power.

## Route management

If you are going to use routes/snackbars/dialogs/bottomsheets without context, GetX Master is excellent for you too, just see it:

Add "Get" before your MaterialApp, turning it into GetMaterialApp

```dart

GetMaterialApp( // Before: MaterialApp(
  home: MyHome(),
)

```

Navigate to a new screen:

```dart

Get.to(NextScreen());

```

Navigate to new screen with name:

```dart

Get.toNamed('/details');

```

To close snackbars, dialogs, bottomsheets, or anything you would normally close with Navigator.pop(context);

```dart

Get.back();

```

To go to the next screen and no option to go back to the previous screen (for use in SplashScreens, login screens, etc.)

```dart

Get.off(NextScreen());

```

To go to the next screen and cancel all previous routes (useful in shopping carts, polls, and tests)

```dart

Get.offAll(NextScreen());

```

Noticed that you didn't have to use context to do any of these things? That's one of the biggest advantages of using GetX Master route management. With this, you can execute all these methods from within your controller class, without worries.

### More details about route management

**GetX Master works with named routes and also offers lower-level control over your routes!**

## Dependency management

GetX Master has a simple and powerful dependency manager that allows you to retrieve the same class as your Bloc or Controller with just 1 lines of code, no Provider context, no inheritedWidget:

```dart

Controller controller = Get.put(Controller()); // Rather Controller controller = Controller();

```

- Note: If you are using GetX Master's State Manager, pay more attention to the bindings API, which will make it easier to connect your view to your controller.

Instead of instantiating your class within the class you are using, you are instantiating it within the GetX Master instance, which will make it available throughout your App.
So you can use your controller (or class Bloc) normally

**Tip:** GetX Master dependency management is decoupled from other parts of the package, so if for example, your app is already using a state manager (any one, it doesn't matter), you don't need to rewrite it all, you can use this dependency injection with no problems at all

```dart

controller.fetchApi();

```

Imagine that you have navigated through numerous routes, and you need data that was left behind in your controller, you would need a state manager combined with the Provider or Get_it, correct? Not with GetX Master. You just need to ask GetX Master to "find" for your controller, you don't need any additional dependencies:

```dart

Controller controller = Get.find();

//Yes, it looks like Magic, GetX Master will find your controller, and will deliver it to you. You can have 1 million controllers instantiated, GetX Master will always give you the right controller.
```

And then you will be able to recover your controller data that was obtained back there:

```dart

Text(controller.textFromApi);

```

---

### More details about dependency management

**GetX Master provides comprehensive dependency management capabilities.**

## Animation Extensions

GetX Master includes powerful animation extensions that make creating beautiful animations incredibly simple. These extensions provide a fluent API for chaining multiple animations together.

### Available Animation Types

#### Basic Animations
```dart
// Fade animations
myWidget.fadeIn(duration: Duration(seconds: 1))
myWidget.fadeOut(duration: Duration(milliseconds: 500))

// Scale animations
myWidget.scale(begin: 0.5, end: 1.5, duration: Duration(seconds: 1))
myWidget.size(begin: 0.8, end: 1.2) // Size animation using scale

// Rotation animations
myWidget.rotate(begin: 0, end: 1) // Full rotation (360 degrees)
```

#### Advanced Animations
```dart
// Slide animations with custom offset
myWidget.slide(
  offset: (context, value) => Offset(-value, 0), // Slide from left
  duration: Duration(milliseconds: 800)
)

// Bounce effect
myWidget.bounce(begin: 0.8, end: 1.2, duration: Duration(seconds: 1))

// Blur effect
myWidget.blur(begin: 0, end: 10, duration: Duration(seconds: 2))

// 3D Flip animation
myWidget.flip(duration: Duration(milliseconds: 600))

// Wave animation
myWidget.wave(duration: Duration(seconds: 3))
```

#### Sequential Animation Chaining
```dart
// Chain multiple animations to run one after another
Text('Animated Text')
  .fadeIn(duration: Duration(seconds: 1))
  .scale(begin: 1.0, end: 1.5, duration: Duration(seconds: 1), isSequential: true)
  .bounce(begin: 1.5, end: 1.0, duration: Duration(milliseconds: 500), isSequential: true)
  .fadeOut(duration: Duration(seconds: 1), isSequential: true);
```

#### Color Animations
```dart
// Animate colors using the Animate widget
Animate(
  duration: Duration(seconds: 2),
  type: AnimationType.color,
  begin: Colors.red,
  end: Colors.blue,
  child: Container(width: 100, height: 100),
)
```

### Animation Features
- **Fluent API**: Chain animations easily with method chaining
- **Sequential Support**: Run animations one after another with `isSequential: true`
- **Customizable**: Full control over duration, delay, and curves
- **Performance Optimized**: Built on Flutter's animation framework
- **15+ Animation Types**: Comprehensive set of pre-built animations

## GetSocket - WebSocket Management

GetX Master provides a powerful WebSocket implementation with automatic connection management, event handling, and cross-platform support.

### Basic Usage
```dart
// Create a WebSocket connection
final socket = GetSocket('ws://localhost:8080');

// Set up event listeners
socket.onOpen(() {
  print('WebSocket connected!');
});

socket.onMessage((data) {
  print('Received message: $data');
});

socket.onError((error) {
  print('WebSocket error: $error');
});

socket.onClose((close) {
  print('WebSocket closed: ${close.reason}');
});

// Connect to the server
await socket.connect();
```

### Advanced Features
```dart
// Send custom events
socket.emit('chat_message', {
  'user': 'john_doe',
  'message': 'Hello everyone!',
  'timestamp': DateTime.now().toIso8601String(),
});

// Listen for specific events
socket.on('user_joined', (data) {
  print('User ${data['username']} joined the chat');
});

// Send raw data
socket.send('Raw message data');

// Configure ping interval for connection health
final socket = GetSocket(
  'ws://localhost:8080',
  ping: Duration(seconds: 30), // Send ping every 30 seconds
  allowSelfSigned: true, // Allow self-signed certificates
);
```

### Key Features
- **Cross-platform**: Works on Web, Mobile, and Desktop
- **Automatic Reconnection**: Built-in connection management
- **Event-based**: Clean event-driven architecture
- **SSL Support**: Full SSL/TLS support with self-signed certificate option
- **Ping/Pong**: Automatic connection health monitoring

# Utils

## Internationalization

### Translations

Translations are kept as a simple key-value dictionary map.
To add custom translations, create a class and extend `Translations`.

```dart
import 'package:get_x_master/get_x_master.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello World',
        },
        'de_DE': {
          'hello': 'Hallo Welt',
        }
      };
}
```

#### Using translations

Just append `.tr` to the specified key and it will be translated, using the current value of `Get.locale` and `Get.fallbackLocale`.

```dart

Text('title'.tr);

```

#### Using translation with singular and plural

```dart

var products = [];
Text('singularKey'.trPlural('pluralKey', products.length, Args));

```

#### Using translation with parameters

```dart
import 'package:get_x_master/get_x_master.dart';

Map<String, Map<String, String>> get keys => {
    'en_US': {
        'logged_in': 'logged in as @name with email @email',
    },
    'es_ES': {
       'logged_in': 'iniciado sesión como @name con e-mail @email',
    }
};

Text('logged_in'.trParams({
  'name': 'Jhon',
  'email': 'jhon@example.com'
  }));
```

### Locales

Pass parameters to `GetMaterialApp` to define the locale and translations.

```dart

return GetMaterialApp(
    translations: Messages(), // your translations
    locale: Locale('en', 'US'), // translations will be displayed in that locale
    fallbackLocale: Locale('en', 'UK'), // specify the fallback locale in case an invalid locale is selected.
);

```

#### Change locale

Call `Get.updateLocale(locale)` to update the locale. Translations then automatically use the new locale.

```dart

var locale = Locale('en', 'US');
Get.updateLocale(locale);

```

#### System locale

To read the system locale, you could use `Get.deviceLocale`.

```dart

return GetMaterialApp(
    locale: Get.deviceLocale,
);

```

---

## Change Theme

Please do not use any higher level widget than `GetMaterialApp` in order to update it. This can trigger duplicate keys. A lot of people are used to the prehistoric approach of creating a "ThemeProvider" widget just to change the theme of your app, and this is definitely NOT necessary with **GetX Master**.

You can create your custom theme and simply add it within `Get.changeTheme` without any boilerplate for that:

```dart

Get.changeTheme(ThemeData.light());

```

If you want to create something like a button that changes the Theme in `onTap`, you can combine two **GetX Master** APIs for that:

- The api that checks if the dark `Theme` is being used.
- And the `Theme` Change API, you can just put this within an `onPressed`:

```dart

Get.changeTheme(Get.isDarkMode? ThemeData.light(): ThemeData.dark());

```

When `.darkmode` is activated, it will switch to the _light theme_, and when the _light theme_ becomes active, it will change to _dark theme_.


---


## GetConnect

GetConnect is an easy way to communicate from your back to your front with http or websockets

### Default configuration

You can simply extend GetConnect and use the GET/POST/PUT/DELETE/SOCKET methods to communicate with your Rest API or websockets.

```dart

class UserProvider extends GetConnect {
  // Get request
  Future<Response> getUser(int id) => get('http://youapi/users/$id');
  // Post request
  Future<Response> postUser(Map data) => post('http://youapi/users', body: data);
  // Post request with File
  Future<Response<CasesModel>> postCases(List<int> image) {
    final form = FormData({
      'file': MultipartFile(image, filename: 'avatar.png'),
      'otherFile': MultipartFile(image, filename: 'cover.png'),
    });
    return post('http://youapi/users/upload', form);
  }

  GetSocket userMessages() {
    return socket('https://yourapi/users/socket');
  }
}

```



### Custom configuration

GetConnect is highly customizable You can define base Url, as answer modifiers, as Requests modifiers, define an authenticator, and even the number of attempts in which it will try to authenticate itself, in addition to giving the possibility to define a standard decoder that will transform all your requests into your Models without any additional configuration.

```dart

class HomeProvider extends GetConnect {
  @override
  void onInit() {
    // All request will pass to jsonEncode so CasesModel.fromJson()
    httpClient.defaultDecoder = CasesModel.fromJson;
    httpClient.baseUrl = 'https://api.covid19api.com';
    // baseUrl = 'https://api.covid19api.com'; // It define baseUrl to
    // Http and websockets if used with no [httpClient] instance

    // It's will attach 'apikey' property on header from all requests
    httpClient.addRequestModifier((request) {
      request.headers['apikey'] = '12345678';
      return request;
    });

    // Even if the server sends data from the country "Brazil",
    // it will never be displayed to users, because you remove
    // that data from the response, even before the response is delivered
    httpClient.addResponseModifier<CasesModel>((request, response) {
      CasesModel model = response.body;
      if (model.countries.contains('Brazil')) {
        model.countries.remove('Brazilll');
      }
    });

    httpClient.addAuthenticator((request) async {
      final response = await get("http://yourapi/token");
      final token = response.body['token'];
      // Set the header
      request.headers['Authorization'] = "$token";
      return request;
    });

    //Autenticator will be called 3 times if HttpStatus is
    //HttpStatus.unauthorized
    httpClient.maxAuthRetries = 3;
  }

  @override
  Future<Response<CasesModel>> getCases(String path) => get(path);
}

```

---


## GetPage Middleware

The GetPage has now new property that takes a list of GetMiddleWare and run them in the specific order.

**Note**: When GetPage has a Middlewares, all the children of this page will have the same middlewares automatically.

### Priority

The Order of the Middlewares to run can be set by the priority in the GetMiddleware.

```dart

final middlewares = [
  GetMiddleware(priority: 2),
  GetMiddleware(priority: 5),
  GetMiddleware(priority: 4),
  GetMiddleware(priority: -8),
];

```

those middlewares will be run in this order **-8 => 2 => 4 => 5**

### Redirect

This function will be called when the page of the called route is being searched for. It takes RouteSettings as a result to redirect to. Or give it null and there will be no redirecting.

```dart

RouteSettings redirect(String route) {
  final authService = Get.find<AuthService>();
  return authService.authed.value ? null : RouteSettings(name: '/login')
}

```

### onPageCalled

This function will be called when this Page is called before anything created
you can use it to change something about the page or give it new page

```dart

GetPage onPageCalled(GetPage page) {
  final authService = Get.find<AuthService>();
  return page.copyWith(title: 'Welcome ${authService.UserName}');
}

```

### OnBindingsStart

This function will be called right before the Bindings are initialize.
Here you can change Bindings for this page.

```dart

List<Bindings> onBindingsStart(List<Bindings> bindings) {
  final authService = Get.find<AuthService>();
  if (authService.isAdmin) {
    bindings.add(AdminBinding());
  }
  return bindings;
}

```

### OnPageBuildStart

This function will be called right after the Bindings are initialize.
Here you can do something after that you created the bindings and before creating the page widget.

```dart

GetPageBuilder onPageBuildStart(GetPageBuilder page) {
  print('bindings are ready');
  return page;
}

```

### OnPageBuilt

This function will be called right after the GetPage.page function is called and will give you the result of the function. and take the widget that will be showed.

### OnPageDispose

This function will be called right after disposing all the related objects (Controllers, views, ...) of the page.

## Other Advanced APIs

```dart

// give the current args from currentScreen
Get.arguments

// give name of previous route
Get.previousRoute

// give the raw route to access for example, rawRoute.isFirst()
Get.rawRoute

// give access to Routing API from GetObserver
Get.routing

// check if snackbar is open
Get.isSnackbarOpen

// check if dialog is open
Get.isDialogOpen

// check if bottomsheet is open
Get.isBottomSheetOpen

// remove one route.
Get.removeRoute()

// back repeatedly until the predicate returns true.
Get.until()

// go to next route and remove all the previous routes until the predicate returns true.
Get.offUntil()

// go to next named route and remove all the previous routes until the predicate returns true.
Get.offNamedUntil()

//Check in what platform the app is running
GetPlatform.isAndroid
GetPlatform.isIOS
GetPlatform.isMacOS
GetPlatform.isWindows
GetPlatform.isLinux
GetPlatform.isFuchsia

//Check the device type
GetPlatform.isMobile
GetPlatform.isDesktop
//All platforms are supported independently in web!
//You can tell if you are running inside a browser
//on Windows, iOS, OSX, Android, etc.
GetPlatform.isWeb


// Equivalent to : MediaQuery.of(context).size.height,
// but immutable.
Get.height
Get.width

// Gives the current context of the Navigator.
Get.context

// Gives the context of the snackbar/dialog/bottomsheet in the foreground, anywhere in your code.
Get.contextOverlay

// Note: the following methods are extensions on context. Since you
// have access to context in any place of your UI, you can use it anywhere in the UI code

// If you need a changeable height/width (like Desktop or browser windows that can be scaled) you will need to use context.
context.width
context.height

// Gives you the power to define half the screen, a third of it and so on.
// Useful for responsive applications.
// param dividedBy (double) optional - default: 1
// param reducedBy (double) optional - default: 0
context.heightTransformer()
context.widthTransformer()

/// Similar to MediaQuery.sizeOf(context);
context.mediaQuerySize()

/// Similar to MediaQuery.paddingOf(context);
context.mediaQueryPadding()

/// Similar to MediaQuery.viewPaddingOf(context);
context.mediaQueryViewPadding()

/// Similar to MediaQuery.viewInsetsOf(context);
context.mediaQueryViewInsets()

/// Similar to MediaQuery.orientationOf(context);
context.orientation()

/// Check if device is on landscape mode
context.isLandscape()

/// Check if device is on portrait mode
context.isPortrait()

/// Similar to MediaQuery.devicePixelRatioOf(context);
context.devicePixelRatio()

/// Similar to MediaQuery.textScaleFactorOf(context);
context.textScaleFactor()

/// Get the shortestSide from screen
context.mediaQueryShortestSide()

/// True if width be larger than 800
context.showNavbar()

/// True if the shortestSide is smaller than 600p
context.isPhone()

/// True if the shortestSide is largest than 600p
context.isSmallTablet()

/// True if the shortestSide is largest than 720p
context.isLargeTablet()

/// True if the current device is Tablet
context.isTablet()

/// Returns a value<T> according to the screen size
/// can give value for:
/// watch: if the shortestSide is smaller than 300
/// mobile: if the shortestSide is smaller than 600
/// tablet: if the shortestSide is smaller than 1200
/// desktop: if width is largest than 1200
context.responsiveValue<T>()


```

### Optional Global Settings and Manual configurations

GetMaterialApp configures everything for you, but if you want to configure Get manually.

```dart

MaterialApp(
  navigatorKey: Get.key,
  navigatorObservers: [GetObserver()],
);


```

You will also be able to use your own Middleware within `GetObserver`, this will not influence anything.

```dart

MaterialApp(
  navigatorKey: Get.key,
  navigatorObservers: [
    GetObserver(MiddleWare.observer) // Here
  ],
);


```

You can create _Global Settings_ for `Get`. Just add `Get.config` to your code before pushing any route.
Or do it directly in your `GetMaterialApp`

```dart

GetMaterialApp(
  enableLog: true,
  defaultTransition: Transition.fade,
  opaqueRoute: Get.isOpaqueRouteDefault,
  popGesture: Get.isPopGestureEnable,
  transitionDuration: Get.defaultDurationTransition,
  defaultGlobalState: Get.defaultGlobalState,
);

Get.config(
  enableLog = true,
  defaultPopGesture = true,
  defaultTransition = Transitions.cupertino
)

```

You can optionally redirect all the logging messages from `Get`.
If you want to use your own, favourite logging package,
and want to capture the logs there:

```dart

GetMaterialApp(
  enableLog: true,
  logWriterCallback: localLogWriter,
);

void localLogWriter(String text, {bool isError = false}) {
  // pass the message to your favourite logging package here
  // please note that even if enableLog: false log messages will be pushed in this callback
  // you get check the flag if you want through GetConfig.isLogEnable
}

```

### Local State Widgets

These Widgets allows you to manage a single value, and keep the state ephemeral and locally.
We have flavours for Reactive and Simple.
For instance, you might use them to toggle obscureText in a `TextField`, maybe create a custom
Expandable Panel, or maybe modify the current index in `BottomNavigationBar` while changing the content
of the body in a `Scaffold`.

#### ValueBuilder

A simplification of `StatefulWidget` that works with a `.setState` callback that takes the updated value.

```dart

ValueBuilder<bool>(
  initialValue: false,
  builder: (value, updateFn) => Switch(
    value: value,
    onChanged: updateFn, // same signature! you could use ( newValue ) => updateFn( newValue )
  ),
  // if you need to call something outside the builder method.
  onUpdate: (value) => print("Value updated: $value"),
  onDispose: () => print("Widget unmounted"),
),

```

#### ObxValue

Similar to [`ValueBuilder`](#valuebuilder), but this is the Reactive version, you pass a Rx instance (remember the magical .obs?) and
updates automatically... isn't it awesome?

```dart

ObxValue((data) => Switch(
        value: data.value,
        onChanged: data, // Rx has a _callable_ function! You could use (flag) => data.value = flag,
    ),
    false.obs,
),

```

## Useful tips

`.obs`ervables (also known as _Rx_ Types) have a wide variety of internal methods and operators.

> Is very common to _believe_ that a property with `.obs` **IS** the actual value... but make no mistake!
> We avoid the Type declaration of the variable, because Dart's compiler is smart enough, and the code
> looks cleaner, but:

```dart

var message = 'Hello world'.obs;
print( 'Message "$message" has Type ${message.runtimeType}');

```

Even if `message` _prints_ the actual String value, the Type is **RxString**!

So, you can't do `message.substring( 0, 4 )`.
You have to access the real `value` inside the _observable_:
The most "used way" is `.value`, but, did you know that you can also use...

```dart
final name = 'GetX'.obs;
// only "updates" the stream, if the value is different from the current one.
name.value = 'Hey';

// All Rx properties are "callable" and returns the new value.
// but this approach does not accepts `null`, the UI will not rebuild.
name('Hello');

// is like a getter, prints 'Hello'.
name() ;

/// numbers:

final count = 0.obs;

// You can use all non mutable operations from num primitives!
count + 1;

// Watch out! this is only valid if `count` is not final, but var
count += 1;

// You can also compare against values:
count > 2;

/// booleans:

final flag = false.obs;

// switches the value between true/false
flag.toggle();


/// all types:

// Sets the `value` to null.
flag.nil();

// All toString(), toJson() operations are passed down to the `value`
print( count ); // calls `toString()` inside  for RxInt

final abc = [0,1,2].obs;
// Converts the value to a json Array, prints RxList
// Json is supported by all Rx types!
print('json: ${jsonEncode(abc)}, type: ${abc.runtimeType}');

// RxMap, RxList and RxSet are special Rx types, that extends their native types.
// but you can work with a List as a regular list, although is reactive!
abc.add(12); // pushes 12 to the list, and UPDATES the stream.
abc[3]; // like Lists, reads the index 3.


// equality works with the Rx and the value, but hashCode is always taken from the value
final number = 12.obs;
print( number == 12 ); // prints > true

/// Custom Rx Models:

// toJson(), toString() are deferred to the child, so you can implement override on them, and print() the observable directly.

class User {
    String name, last;
    int age;
    User({this.name, this.last, this.age});

    @override
    String toString() => '$name $last, $age years old';
}

final user = User(name: 'John', last: 'Doe', age: 33).obs;

// `user` is "reactive", but the properties inside ARE NOT!
// So, if we change some variable inside of it...
user.value.name = 'Roi';
// The widget will not rebuild!,
// `Rx` don't have any clue when you change something inside user.
// So, for custom classes, we need to manually "notify" the change.
user.refresh();

// or we can use the `update()` method!
user.update((value){
  value.name='Roi';
});

print( user );

```
## StateMixin

Another way to handle your `UI` state is use the `StateMixin<T>` .
To implement it, use the `with` to add the `StateMixin<T>`
to your controller which allows a T model.

``` dart

class Controller extends GetController with StateMixin<User>{}

```

The `change()` method change the State whenever we want.
Just pass the data and the status in this way:

```dart

change(data, status: RxStatus.success());

```

RxStatus allow these status:

``` dart

RxStatus.loading();
RxStatus.success();
RxStatus.empty();
RxStatus.error('message');

```

To represent it in the UI, use:

```dart

class OtherClass extends GetView<Controller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: controller.obx(
        (state)=>Text(state.name),

        // here you can put your custom loading indicator, but
        // by default would be Center(child:CircularProgressIndicator())
        onLoading: CustomLoadingIndicator(),
        onEmpty: Text('No data found'),

        // here also you can set your own error widget, but by
        // default will be an Center(child:Text(error))
        onError: (error)=>Text(error),
      ),
    );
  }
}

```

---

#### GetView

I love this Widget, is so simple, yet, so useful!

Is a `const Stateless` Widget that has a getter `controller` for a registered `Controller`, that's all.

```dart

 class AwesomeController extends GetController {
   final String title = 'My Awesome View';
 }

  // ALWAYS remember to pass the `Type` you used to register your controller!
 class AwesomeView extends GetView<AwesomeController> {
   @override
   Widget build(BuildContext context) {
     return Container(
       padding: EdgeInsets.all(20),
       child: Text(controller.title), // just call `controller.something`
     );
   }
 }

```

#### ReactiveGetView

**ReactiveGetView** is the enhanced version of GetView with automatic reactive capabilities:

```dart

 class AwesomeController extends GetxController {
   final title = 'My Awesome View'.obs;
   final count = 0.obs;

   void updateTitle() => title.value = 'Updated Title';
   void increment() => count++;
 }

 // ReactiveGetView automatically updates when observable variables change
 class AwesomeView extends ReactiveGetView<AwesomeController> {
   @override
   Widget build(BuildContext context) {
     return Container(
       padding: EdgeInsets.all(20),
       child: Column(
         children: [
           Text(controller.title.value), // Automatically reactive!
           Text('Count: ${controller.count.value}'), // No Obx needed!
           ElevatedButton(
             onPressed: controller.updateTitle,
             child: Text('Update Title'),
           ),
         ],
       ),
     );
   }
 }

```

**Choose the right widget for your needs:**
- Use **GetView** for simple, non-reactive UIs
- Use **ReactiveGetView** when you need automatic reactive updates
- Use **Obx()** for fine-grained reactive control in specific parts



#### GetResponsiveView

Extend this widget to build responsive view.
this widget contains the `screen` property that have all
information about the screen size and type.

##### How to use it

You have two options to build it.

- with `builder` method you return the widget to build.
- with methods `desktop`, `tablet`,`phone`, `watch`. the specific
  method will be built when the screen type matches the method
  when the screen is [ScreenType.Tablet] the `tablet` method
  will be exuded and so on.
  **Note:** If you use this method please set the property `alwaysUseBuilder` to `false`

With `settings` property you can set the width limit for the screen types.

![example](https://github.com/SchabanBo/get_page_example/blob/master/docs/Example.gif?raw=true)
Code to this screen
[code](https://github.com/SchabanBo/get_page_example/blob/master/lib/pages/responsive_example/responsive_view.dart)

#### GetWidget

Most people have no idea about this Widget, or totally confuse the usage of it.
The use case is very rare, but very specific: It `caches` a Controller.
Because of the _cache_, can't be a `const Stateless`.

> So, when do you need to "cache" a Controller?

If you use, another "not so common" feature of **GetX**: `Get.create()`.

`Get.create(()=>Controller())` will generate a new `Controller` each time you call
`Get.find<Controller>()`,

That's where `GetWidget` shines... as you can use it, for example,
to keep a list of Todo items. So, if the widget gets "rebuilt", it will keep the same controller instance.

#### GetxService

This class is like a `GetxController`, it shares the same lifecycle ( `onInit()`, `onReady()`, `onClose()`).
But has no "logic" inside of it. It just notifies **GetX Master** Dependency Injection system, that this subclass
**can not** be removed from memory.

So is super useful to keep your "Services" always reachable and active with `Get.find()`. Like:
`ApiService`, `StorageService`, `CacheService`.

```dart

Future<void> main() async {
  await initServices(); /// AWAIT SERVICES INITIALIZATION.
  runApp(SomeApp());
}

/// Is a smart move to make your Services intiialize before you run the Flutter app.
/// as you can control the execution flow (maybe you need to load some Theme configuration,
/// apiKey, language defined by the User... so load SettingService before running ApiService.
/// so GetMaterialApp() doesnt have to rebuild, and takes the values directly.
void initServices() async {
  print('starting services ...');
  /// Here is where you put get_storage, hive, shared_pref initialization.
  /// or moor connection, or whatever that's async.
  await Get.putAsync(() => DbService().init());
  await Get.putAsync(SettingsService()).init();
  print('All services started...');
}

class DbService extends GetxService {
  Future<DbService> init() async {
    print('$runtimeType delays 2 sec');
    await 2.delay();
    print('$runtimeType ready!');
    return this;
  }
}

class SettingsService extends GetxService {
  void init() async {
    print('$runtimeType delays 1 sec');
    await 1.delay();
    print('$runtimeType ready!');
  }
}

```

The only way to actually delete a `GetxService`, is with `Get.reset()` which is like a
"Hot Reboot" of your app. So remember, if you need absolute persistence of a class instance during the
lifetime of your app, use `GetxService`.


### Tests

You can test your controllers like any other class, including their lifecycles:

```dart

class Controller extends GetxController {
  @override
  void onInit() {
    super.onInit();
    //Change value to name2
    name.value = 'name2';
  }

  @override
  void onClose() {
    name.value = '';
    super.onClose();
  }

  final name = 'name1'.obs;

  void changeName() => name.value = 'name3';
}

void main() {
  test('''
Test the state of the reactive variable "name" across all of its lifecycles''',
      () {
    /// You can test the controller without the lifecycle,
    /// but it's not recommended unless you're not using
    ///  GetX dependency injection
    final controller = Controller();
    expect(controller.name.value, 'name1');

    /// If you are using it, you can test everything,
    /// including the state of the application after each lifecycle.
    Get.put(controller); // onInit was called
    expect(controller.name.value, 'name2');

    /// Test your functions
    controller.changeName();
    expect(controller.name.value, 'name3');

    /// onClose was called
    Get.delete<Controller>();

    expect(controller.name.value, '');
  });
}

```

#### Tips

##### Mockito or mocktail
If you need to mock your GetxController/GetxService, you should extend GetxController, and mixin it with Mock, that way

```dart

class NotificationServiceMock extends GetxService with Mock implements NotificationService {}

```

##### Using Get.reset()
If you are testing widgets, or test groups, use Get.reset at the end of your test or in tearDown to reset all settings from your previous test.

##### Get.testMode
if you are using your navigation in your controllers, use `Get.testMode = true` at the beginning of your main.


# Breaking changes from 2.0

1- Rx types:

***

RxController and GetBuilder now have merged, you no longer need to memorize which controller you want to use, just use GetxController, it will work for simple state management and for reactive as well.

2- NamedRoutes
Before:

```dart

GetMaterialApp(
  namedRoutes: {
    '/': GetRoute(page: Home()),
  }
)

```

Now:

```dart

GetMaterialApp(
  getPages: [
    GetPage(name: '/', page: () => Home()),
  ]
)

```

Why this change?
Often, it may be necessary to decide which page will be displayed from a parameter, or a login token, the previous approach was inflexible, as it did not allow this.
Inserting the page into a function has significantly reduced the RAM consumption, since the routes will not be allocated in memory since the app was started, and it also allowed to do this type of approach:

```dart

GetStorage box = GetStorage();

GetMaterialApp(
  getPages: [
    GetPage(name: '/', page:(){
      return box.hasData('token') ? Home() : Login();
    })
  ]
)

```

---

# Why Getx?

1- Many times after a Flutter update, many of your packages will break. Sometimes compilation errors happen, errors often appear that there are still no answers about, and the developer needs to know where the error came from, track the error, only then try to open an issue in the corresponding repository, and see its problem solved. Get centralizes the main resources for development (State, dependency and route management), allowing you to add a single package to your pubspec, and start working. After a Flutter update, the only thing you need to do is update the Get dependency, and get to work. Get also resolves compatibility issues. How many times a version of a package is not compatible with the version of another, because one uses a dependency in one version, and the other in another version? This is also not a concern using Get, as everything is in the same package and is fully compatible.

2- Flutter is easy, Flutter is incredible, but Flutter still has some boilerplate that may be unwanted for most developers, such as `Navigator.of(context).push (context, builder [...]`. Get simplifies development. Instead of writing 8 lines of code to just call a route, you can just do it: `Get.to(Home())` and you're done, you'll go to the next page. Dynamic web urls are a really painful thing to do with Flutter currently, and that with GetX is stupidly simple. Managing states in Flutter, and managing dependencies is also something that generates a lot of discussion, as there are hundreds of patterns in the pub. But there is nothing as easy as adding a ".obs" at the end of your variable, and place your widget inside an Obx, and that's it, all updates to that variable will be automatically updated on the screen.

3- Ease without worrying about performance. Flutter's performance is already amazing, but imagine that you use a state manager, and a locator to distribute your blocs/stores/controllers/ etc. classes. You will have to manually call the exclusion of that dependency when you don't need it. But have you ever thought of simply using your controller, and when it was no longer being used by anyone, it would simply be deleted from memory? That's what GetX does. With SmartManagement, everything that is not being used is deleted from memory, and you shouldn't have to worry about anything but programming. You will be assured that you are consuming the minimum necessary resources, without even having created a logic for this.

4- Actual decoupling. You may have heard the concept "separate the view from the business logic". This is not a peculiarity of BLoC, MVC, MVVM, and any other standard on the market has this concept. However, this concept can often be mitigated in Flutter due to the use of context.
If you need context to find an InheritedWidget, you need it in the view, or pass the context by parameter. I particularly find this solution very ugly, and to work in teams we will always have a dependence on View's business logic. Getx is unorthodox with the standard approach, and while it does not completely ban the use of StatefulWidgets, InitState, etc., it always has a similar approach that can be cleaner. Controllers have life cycles, and when you need to make an APIREST request for example, you don't depend on anything in the view. You can use onInit to initiate the http call, and when the data arrives, the variables will be populated. As GetX is fully reactive (really, and works under streams), once the items are filled, all widgets that use that variable will be automatically updated in the view. This allows people with UI expertise to work only with widgets, and not have to send anything to business logic other than user events (like clicking a button), while people working with business logic will be free to create and test the business logic separately.

This library will always be updated and implementing new features. Feel free to offer PRs and contribute to them.

---

# Contributing

## How to contribute

_Want to contribute to the project? We will be proud to highlight you as one of our collaborators. Here are some points where you can contribute and make GetX Master even better._

- Helping to translate the readme into other languages.
- Adding documentation to the readme.
- Write articles or make videos teaching how to use GetX Master.
- Offering PRs for code/tests.
- Including new functions.

Any contribution is welcome!

## Support

If you have questions or need assistance regarding the use of GetX Master, please:
- Open an issue in this repository
- Check the documentation and examples
- Review the source code for implementation details

##  License
This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.

---

**GetX Master** - An independent state management solution for Flutter applications.
