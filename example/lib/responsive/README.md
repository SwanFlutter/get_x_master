# نمونه‌های Responsive GetX
# GetX Responsive Examples

این پوشه شامل نمونه‌های کامل برای استفاده از قابلیت‌های Responsive در GetX است.

## 📁 فایل‌های موجود

### `responsive_test_example.dart`
یک مثال جامع که تمام قابلیت‌های responsive را نمایش می‌دهد:
- ✅ Extension های عددی (`.w`, `.h`, `.wp`, `.hp`)
- ✅ ResponsiveSize Extension (`.sp`, `.ws`, `.imgSize`)
- ✅ GetResponsiveBuilder برای به‌روزرسانی Real-time
- ✅ تشخیص نوع دستگاه (Phone, Tablet, Laptop, Desktop)
- ✅ Responsive Visibility
- ✅ GetResponsiveHelper

## 🚀 نحوه اجرا

### روش ۱: اجرای مستقیم
```bash
# در پوشه example
flutter run lib/responsive_test_example.dart
```

### روش ۲: تغییر main.dart
در فایل `example/lib/main.dart` این خط را اضافه کنید:
```dart
import 'responsive_test_example.dart';

void main() {
  runApp(const ResponsiveTestApp());
}
```

## 📱 قابلیت‌های تست شده

### 1. اطلاعات صفحه نمایش
نمایش اطلاعات کامل صفحه نمایش شامل:
- عرض و ارتفاع
- Pixel Ratio
- Aspect Ratio
- جهت صفحه (Landscape/Portrait)

### 2. Number Extensions
```dart
// Width/Height Percentage
50.0.wp  // 50% از عرض صفحه
30.0.hp  // 30% از ارتفاع صفحه

// Responsive Pixels
100.0.w  // 100 پیکسل واکنش‌گرا بر اساس عرض
80.0.h   // 80 پیکسل واکنش‌گرا بر اساس ارتفاع
```

### 3. ResponsiveSize Extension
```dart
// Font Size
16.sp    // اندازه فونت واکنش‌گرا
20.sp    // با تنظیم خودکار برای انواع دستگاه

// Widget Size (Icons, Buttons)
24.ws    // اندازه ویجت واکنش‌گرا
32.ws    // بهینه برای آیکون‌ها

// Image Size
100.imgSize  // اندازه تصویر واکنش‌گرا
```

### 4. GetResponsiveBuilder
برای به‌روزرسانی Real-time هنگام تغییر اندازه صفحه:
```dart
GetResponsiveBuilder(
  builder: (context, data) {
    return Text('Width: ${data.width}');
  },
)
```

### 5. Device Type Detection
```dart
GetResponsiveHelper.deviceType     // 'phone', 'tablet', 'laptop', 'desktop'
GetResponsiveHelper.isPhone        // true/false
GetResponsiveHelper.isTablet       // true/false
GetResponsiveHelper.isLaptop       // true/false
GetResponsiveHelper.isDesktop      // true/false
```

### 6. Responsive Visibility
```dart
Widget().responsiveVisibility(
  phone: true,      // نمایش در موبایل
  tablet: false,    // مخفی در تبلت
  laptop: true,     // نمایش در لپتاپ
  desktop: true,    // نمایش در دسکتاپ
)
```

### 7. GetResponsiveHelper Methods
```dart
GetResponsiveHelper.w(100)         // Responsive width
GetResponsiveHelper.h(80)          // Responsive height
GetResponsiveHelper.wp(25)         // Width percentage
GetResponsiveHelper.hp(15)         // Height percentage
GetResponsiveHelper.ws(24)         // Widget size
GetResponsiveHelper.imgSize(100)   // Image size

// Responsive Value
GetResponsiveHelper.responsiveValue<String>(
  phone: 'Mobile',
  tablet: 'Tablet',
  laptop: 'Laptop',
  desktop: 'Desktop',
)
```

## 🎨 ویژگی‌ها

- ✅ **Real-time Updates**: تغییرات فوری هنگام تغییر اندازه پنجره
- ✅ **Multi-device Support**: پشتیبانی از موبایل، تبلت، لپتاپ، و دسکتاپ
- ✅ **Smart Scaling**: مقیاس‌گذاری هوشمند بر اساس نوع دستگاه
- ✅ **Fallback Support**: مقادیر پیش‌فرض برای حالت‌های خطا
- ✅ **Persian & English**: پشتیبانی از دو زبان فارسی و انگلیسی

## 🐛 اشکال‌زدایی

اگر خطا دریافت کردید:
1. مطمئن شوید که `get_x_master` را import کرده‌اید
2. `flutter pub get` را در پوشه example اجرا کنید
3. اپلیکیشن را restart کنید

## 💡 نکات

- برای تست بهتر، اندازه پنجره مرورگر یا emulator را تغییر دهید
- در حالت Hot Reload، تغییرات فوری اعمال می‌شود
- برای دستگاه‌های مختلف، از emulator های متفاوت استفاده کنید
