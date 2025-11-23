# راهنمای حل مشکل Controller Lifecycle در GetX

## مشکل شما
وقتی وارد صفحه می‌شوید و بدون انجام کار خارج می‌شوید، سپس دوباره وارد می‌شوید، خطای زیر رخ می‌دهد:

```
Exception: GetBuilder<CoursesController> failed to initialize.
Error: Exception: No controller available for type CoursesController
```

## علت مشکل
1. **Auto Disposal**: GetX به طور خودکار کنترلرها را dispose می‌کند وقتی از صفحه خارج می‌شوید
2. **عدم ثبت مجدد**: وقتی دوباره وارد صفحه می‌شوید، کنترلر دیگر در memory موجود نیست
3. **عدم استفاده از Binding**: بدون Binding مناسب، کنترلر به درستی مدیریت نمی‌شود

## راه‌حل‌های مختلف

### 1. استفاده از `init` parameter در GetBuilder (ساده‌ترین راه‌حل)

```dart
GetBuilder<CoursesController>(
  init: CoursesController(), // این تضمین می‌کند که کنترلر همیشه موجود باشد
  builder: (controller) {
    return YourWidget();
  },
)
```

### 2. استفاده از Binding (بهترین روش)

#### روش A: استفاده از کلاس Bindings سنتی
```dart
class CoursesBinding extends Bindings {
  @override
  void dependencies() {
    Get.smartLazyPut<CoursesController>(
      () => CoursesController(),
      fenix: true, // اجازه بازسازی بعد از dispose
    );
  }
}

GetPage(
  name: '/courses',
  page: () => CoursesPage(),
  binding: CoursesBinding(),
)
```

#### روش B: استفاده از BindingsBuilder.smartLazyPut (جدید و بهبود یافته)
```dart
GetPage(
  name: '/courses',
  page: () => CoursesPage(),
  binding: BindingsBuilder<CoursesController>.smartLazyPut(
    () => CoursesController(),
    fenix: true,
  ),
)
```

#### روش C: استفاده از BindingsBuilder برای چندین dependency
```dart
GetPage(
  name: '/courses',
  page: () => CoursesPage(),
  binding: BindingsBuilder(() {
    Get.smartLazyPut<CoursesController>(() => CoursesController());
    Get.smartLazyPut<AuthController>(() => AuthController());
  }),
)
```

### 3. ثبت کنترلر در main() یا app initialization

```dart
void main() {
  // ثبت کنترلرهای global
  Get.put<CoursesController>(CoursesController(), permanent: true);
  runApp(MyApp());
}
```

### 4. استفاده از smartLazyPut در صفحه

```dart
class CoursesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // اطمینان از وجود کنترلر
    Get.smartLazyPut<CoursesController>(() => CoursesController());

    return GetBuilder<CoursesController>(
      builder: (controller) {
        return YourWidget();
      },
    );
  }
}
```

### 5. مدیریت دستی کنترلر

```dart
class CoursesPage extends StatefulWidget {
  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  late CoursesController controller;

  @override
  void initState() {
    super.initState();
    // اطمینان از وجود کنترلر
    if (Get.isRegistered<CoursesController>()) {
      controller = Get.find<CoursesController>();
    } else {
      controller = Get.put<CoursesController>(CoursesController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoursesController>(
      builder: (controller) {
        return YourWidget();
      },
    );
  }
}
```

## بهترین practices

### 1. استفاده از fenix parameter
```dart
Get.lazyPut<CoursesController>(() => CoursesController(), fenix: true);
```

### 2. استفاده از permanent برای کنترلرهای global
```dart
Get.put<AuthController>(AuthController(), permanent: true);
```

### 3. بررسی وجود کنترلر قبل از استفاده
```dart
if (Get.isRegistered<CoursesController>()) {
  final controller = Get.find<CoursesController>();
  // استفاده از controller
} else {
  // ثبت کنترلر
  Get.put<CoursesController>(CoursesController());
}
```

### 4. استفاده از try-catch برای مدیریت خطا
```dart
try {
  final controller = Get.find<CoursesController>();
  // استفاده از controller
} catch (e) {
  // کنترلر موجود نیست، ایجاد کنید
  final controller = Get.put<CoursesController>(CoursesController());
}
```

## تغییرات اعمال شده در GetBuilder

GetBuilder بهبود یافته شامل موارد زیر است:

1. **بهتر error handling**: پیام‌های خطای واضح‌تر
2. **Smart recovery**: تلاش برای بازیابی کنترلر در صورت خطا
3. **Null safety**: بررسی‌های بیشتر برای جلوگیری از null reference
4. **Debug information**: اطلاعات بیشتر در حالت debug

## مثال کامل

```dart
// 1. تعریف کنترلر
class CoursesController extends GetXController {
  final RxList<String> courses = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCourses();
  }

  void loadCourses() {
    // بارگذاری داده‌ها
  }
}

// 2. تعریف Binding
class CoursesBinding extends Bindings {
  @override
  void dependencies() {
    Get.smartLazyPut<CoursesController>(() => CoursesController());
  }
}

// 3. استفاده در صفحه
class CoursesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CoursesController>(
        init: CoursesController(), // fallback اگر binding کار نکرد
        builder: (controller) {
          return ListView.builder(
            itemCount: controller.courses.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(controller.courses[index]),
              );
            },
          );
        },
      ),
    );
  }
}

// 4. تعریف route
GetPage(
  name: '/courses',
  page: () => CoursesPage(),
  binding: CoursesBinding(),
)
```

## نتیجه‌گیری

بهترین روش ترکیب استفاده از Binding + init parameter است که هم performance بهتری دارد و هم از بروز خطا جلوگیری می‌کند.
