# راهنمای حل خطای Element Lifecycle

این راهنما برای حل خطای `element._lifecycleState == _ElementLifecycle.active` در Flutter با GetX طراحی شده است.

## مشکل

خطای زیر هنگام استفاده از widget های GetX رخ می‌دهد:

```
_AssertionError ('package:flutter/src/widgets/framework.dart': Failed assertion: line 2092 pos 12: 'element._lifecycleState == _ElementLifecycle.active': is not true.)
```

## علل اصلی

### 1. Nested App Widgets
مهم‌ترین علت: استفاده از چندین `GetCupertinoApp` یا `GetMaterialApp` در یک اپلیکیشن.

```dart
// ❌ اشتباه - Nested Apps
class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return GetCupertinoApp(
      home: AnotherWidget(),
    );
  }
}

class AnotherWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return GetCupertinoApp( // ❌ App دوم - باعث مشکل می‌شود
      home: HomePage(),
    );
  }
}
```

### 2. Controller Lifecycle Issues
مشکل در مدیریت lifecycle کنترلرها.

### 3. Navigation Context Problems
استفاده نادرست از context در navigation.

## راه‌حل‌ها

### راه‌حل 1: حذف Nested Apps

```dart
// ✅ درست - تنها یک App در root
class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return GetCupertinoApp(
      home: HomePage(), // مستقیم به صفحه اصلی
    );
  }
}

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return CupertinoPageScaffold( // ✅ فقط Page Widget
      navigationBar: CupertinoNavigationBar(
        middle: Text('Home'),
      ),
      child: YourContent(),
    );
  }
}
```

### راه‌حل 2: صحیح Controller Management

```dart
// ✅ درست - Controller مناسب
class MyController extends GetXController {
  int count = 0;

  void increment() {
    count++;
    update(); // بروزرسانی UI
  }

  @override
  void onInit() {
    super.onInit();
    // مقداردهی اولیه
  }

  @override
  void onClose() {
    // پاکسازی منابع
    super.onClose();
  }
}

// استفاده صحیح
GetBuilder<MyController>(
  init: MyController(), // مقداردهی اولیه
  builder: (controller) {
    return Text('Count: ${controller.count}');
  },
)
```

### راه‌حل 3: Navigation صحیح

```dart
// ✅ درست - Navigation با GetX
CupertinoButton(
  onPressed: () {
    Get.to(() => SecondPage()); // استفاده از Get.to
  },
  child: Text('Go to Second Page'),
)

// یا استفاده از Navigator معمولی
CupertinoButton(
  onPressed: () {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => SecondPage(),
      ),
    );
  },
  child: Text('Go to Second Page'),
)
```

## مثال کامل - ساختار صحیح

### main.dart
```dart
import 'package:flutter/cupertino.dart';
import 'package:get_x_master/get_x_master.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetCupertinoApp( // تنها App در کل پروژه
      title: 'My App',
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.systemBlue,
      ),
      home: HomePage(),
      getPages: [ // تعریف routes
        GetPage(name: '/', page: () => HomePage()),
        GetPage(name: '/second', page: () => SecondPage()),
      ],
    );
  }
}
```

### home_page.dart
```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Home Page'),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Counter با GetBuilder
              GetBuilder<CounterController>(
                init: CounterController(),
                builder: (controller) {
                  return Column(
                    children: [
                      Text(
                        'Count: ${controller.count}',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CupertinoButton.filled(
                            onPressed: controller.decrement,
                            child: Text('-'),
                          ),
                          CupertinoButton.filled(
                            onPressed: controller.increment,
                            child: Text('+'),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              
              SizedBox(height: 40),
              
              // Navigation
              CupertinoButton.filled(
                onPressed: () => Get.toNamed('/second'),
                child: Text('Go to Second Page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### controller.dart
```dart
class CounterController extends GetXController {
  int count = 0;

  void increment() {
    count++;
    update();
  }

  void decrement() {
    count--;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    print('CounterController initialized');
  }

  @override
  void onClose() {
    print('CounterController disposed');
    super.onClose();
  }
}
```

### second_page.dart
```dart
class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Second Page'),
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Get.back(),
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'This is the second page!',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              CupertinoButton.filled(
                onPressed: () => Get.back(),
                child: Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## نکات مهم

### 1. تنها یک App Widget
- فقط یک `GetCupertinoApp` یا `GetMaterialApp` در کل پروژه
- سایر صفحات باید `Page` یا `Scaffold` باشند

### 2. Controller Management
- همیشه از `GetXController` ارث‌بری کنید
- از `update()` برای بروزرسانی UI استفاده کنید
- lifecycle methods را صحیح پیاده‌سازی کنید

### 3. Navigation
- از `Get.to()`, `Get.toNamed()`, `Get.back()` استفاده کنید
- یا از `Navigator` معمولی Flutter

### 4. State Management
```dart
// ✅ درست - GetBuilder
GetBuilder<MyController>(
  init: MyController(),
  builder: (controller) => YourWidget(),
)

// ✅ درست - Obx
final count = 0.obs;
Obx(() => Text('Count: ${count.value}'))

// ✅ درست - GetX
GetX<MyController>(
  init: MyController(),
  builder: (controller) => YourWidget(),
)
```

## Debug Tips

### 1. بررسی Widget Tree
```dart
// اطمینان حاصل کنید که تنها یک App دارید
flutter inspector
```

### 2. Controller Debug
```dart
class MyController extends GetXController {
  @override
  void onInit() {
    super.onInit();
    print('Controller initialized: ${this.runtimeType}');
  }

  @override
  void onClose() {
    print('Controller disposed: ${this.runtimeType}');
    super.onClose();
  }
}
```

### 3. Navigation Debug
```dart
// بررسی navigation stack
Get.routing.current // صفحه فعلی
Get.routing.previous // صفحه قبلی
```

## خلاصه

برای جلوگیری از خطای Element Lifecycle:

1. **تنها یک App** در root استفاده کنید
2. **Controller ها را صحیح** مدیریت کنید
3. **Navigation را درست** پیاده‌سازی کنید
4. **Lifecycle methods** را رعایت کنید

این راهنما مشکل شما را کاملاً حل خواهد کرد.
