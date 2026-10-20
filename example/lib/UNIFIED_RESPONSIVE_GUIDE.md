# 🎯 راهنمای دسترسی یکپارچه به Responsive Methods
# Unified Responsive Access Guide

## ✨ ویژگی جدید

حالا می‌توانید **مستقیماً** از `ResponsiveData` در `GetResponsiveBuilder` به تمام متدهای responsive دسترسی داشته باشید!

## 🚀 قبل و بعد

### ❌ قبلاً (پیچیده):
```dart
GetResponsiveBuilder(
  builder: (context, data) {
    return Container(
      width: 100.w,           // نیاز به extension روی num
      height: 50.h,
      padding: EdgeInsets.all(16.w),
      child: Text(
        'Hello',
        style: TextStyle(fontSize: 16.sp),  // نیاز به extension
      ),
    );
  },
)
```

### ✅ حالا (ساده و یکپارچه):
```dart
GetResponsiveBuilder(
  builder: (context, data) {
    return Container(
      width: data.w(100),     // ✨ همه چیز از data
      height: data.h(50),
      padding: data.responsiveInsetsAll(16),
      child: Text(
        'Hello',
        style: TextStyle(fontSize: data.sp(16)),
      ),
    );
  },
)
```

## 📚 تمام متدهای موجود در ResponsiveData

### 1️⃣ متدهای پایه

```dart
GetResponsiveBuilder(
  builder: (context, data) {
    // Width & Height
    double width = data.w(100);      // 100 pixels responsive width
    double height = data.h(80);      // 80 pixels responsive height
    
    // Width & Height Percentage
    double halfWidth = data.wp(50);   // 50% of screen width
    double thirdHeight = data.hp(33); // 33% of screen height
    
    return Container();
  },
)
```

### 2️⃣ Font Sizes

```dart
GetResponsiveBuilder(
  builder: (context, data) {
    Text('Standard', style: TextStyle(fontSize: data.sp(16))),
    Text('Header', style: TextStyle(fontSize: data.hsp(20))),
    Text('Small', style: TextStyle(fontSize: data.ssp(12))),
    
    return Container();
  },
)
```

**تفاوت‌ها:**
- `data.sp(16)` - اندازه استاندارد با تنظیم خودکار
- `data.hsp(20)` - بهینه برای هدرها (مقیاس کمتر در صفحات بزرگ)
- `data.ssp(12)` - بهینه برای متن‌های کوچک

### 3️⃣ Widget & Image Sizes

```dart
GetResponsiveBuilder(
  builder: (context, data) {
    Icon(Icons.star, size: data.ws(24)),        // Widget size
    Image.network('url', width: data.imgSize(100)),  // Image size
    
    return Container();
  },
)
```

### 4️⃣ Percentages & Dimensions

```dart
GetResponsiveBuilder(
  builder: (context, data) {
    // محاسبه درصد
    double percent = data.widthPercent(100);   // 100px چند درصد از عرض است؟
    double hPercent = data.heightPercent(200); // 200px چند درصد از ارتفاع است؟
    
    // کمترین و بیشترین بعد
    double minSize = data.minDimension(100);   // برای ویجت‌های مربع
    double maxSize = data.maxDimension(100);   // برای ویجت‌های بزرگ
    
    return Container();
  },
)
```

### 5️⃣ Responsive EdgeInsets (جدید! 🎉)

```dart
GetResponsiveBuilder(
  builder: (context, data) {
    return Container(
      // EdgeInsets.all
      padding: data.responsiveInsetsAll(16),
      
      // EdgeInsets.symmetric
      margin: data.responsiveInsetsSymmetric(
        horizontal: 20,
        vertical: 12,
      ),
      
      // EdgeInsets.only
      padding: data.responsiveInsets(
        left: 16,
        top: 8,
        right: 16,
        bottom: 8,
      ),
    );
  },
)
```

### 6️⃣ Responsive BorderRadius (جدید! 🎉)

```dart
GetResponsiveBuilder(
  builder: (context, data) {
    return Container(
      decoration: BoxDecoration(
        // BorderRadius.circular
        borderRadius: data.responsiveBorderRadiusCircular(16),
        
        // BorderRadius.only
        borderRadius: data.responsiveBorderRadius(
          topLeft: 20,
          topRight: 10,
          bottomLeft: 10,
          bottomRight: 20,
        ),
      ),
    );
  },
)
```

### 7️⃣ Device Type Detection

```dart
GetResponsiveBuilder(
  builder: (context, data) {
    String device = data.deviceType;  // 'phone', 'tablet', 'laptop', 'desktop', 'tv'
    bool isPhone = data.isPhone;
    bool isTablet = data.isTablet;
    bool isLaptop = data.isLaptop;
    bool isDesktop = data.isDesktop;
    bool isTv = data.isTv;
    
    return Container();
  },
)
```

### 8️⃣ Responsive Value (بر اساس دستگاه)

```dart
GetResponsiveBuilder(
  builder: (context, data) {
    // برای رنگ‌ها
    Color backgroundColor = data.responsiveValue<Color>(
      phone: Colors.blue,
      tablet: Colors.green,
      laptop: Colors.orange,
      desktop: Colors.purple,
      defaultValue: Colors.grey,
    );
    
    // برای اعداد
    double fontSize = data.responsiveValue<double>(
      phone: 14.0,
      tablet: 16.0,
      laptop: 18.0,
      desktop: 20.0,
      defaultValue: 16.0,
    );
    
    // برای متن
    String message = data.responsiveValue<String>(
      phone: 'موبایل',
      tablet: 'تبلت',
      laptop: 'لپتاپ',
      desktop: 'دسکتاپ',
      defaultValue: 'نامشخص',
    );
    
    return Container();
  },
)
```

### 9️⃣ Screen Information

```dart
GetResponsiveBuilder(
  builder: (context, data) {
    double screenWidth = data.width;
    double screenHeight = data.height;
    double aspectRatio = data.aspectRatio;
    bool isLandscape = data.isLandscape;
    bool isPortrait = data.isPortrait;
    double baseWidth = data.baseWidth;
    double baseHeight = data.baseHeight;
    double pixelRatio = data.pixelRatio;
    
    Map<String, dynamic> info = data.screenInfo;
    
    return Container();
  },
)
```

## 💡 مثال کامل عملی

```dart
import 'package:material_ui/material_ui.dart';
import 'package:get_x_master/get_x_master.dart';

class MyResponsivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetResponsiveBuilder(
        builder: (context, data) {
          return Padding(
            padding: data.responsiveInsetsAll(16),
            child: Column(
              children: [
                // هدر با فونت واکنش‌گرا
                Text(
                  'سلام دنیا',
                  style: TextStyle(
                    fontSize: data.sp(24),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                SizedBox(height: data.h(20)),
                
                // کارت واکنش‌گرا
                Container(
                  width: data.wp(90),
                  padding: data.responsiveInsetsSymmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: data.responsiveValue<Color>(
                      phone: Colors.blue.shade100,
                      tablet: Colors.green.shade100,
                      laptop: Colors.orange.shade100,
                      desktop: Colors.purple.shade100,
                    ),
                    borderRadius: data.responsiveBorderRadiusCircular(12),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.star,
                        size: data.ws(48),
                        color: Colors.amber,
                      ),
                      SizedBox(height: data.h(12)),
                      Text(
                        'دستگاه: ${data.deviceType}',
                        style: TextStyle(fontSize: data.sp(16)),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: data.h(20)),
                
                // دکمه واکنش‌گرا
                Container(
                  width: data.wp(80),
                  height: data.h(50),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.blue],
                    ),
                    borderRadius: data.responsiveBorderRadiusCircular(25),
                  ),
                  child: Center(
                    child: Text(
                      'دکمه واکنش‌گرا',
                      style: TextStyle(
                        fontSize: data.sp(16),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
```

## 🎯 مزایا

✅ **یکپارچگی کامل** - همه متدها در یک جا  
✅ **خوانایی بهتر** - کد تمیزتر و واضح‌تر  
✅ **Real-time Updates** - تغییرات فوری با تغییر اندازه  
✅ **Type Safe** - بدون نیاز به extension های جداگانه  
✅ **Device Aware** - هوشمند بر اساس نوع دستگاه  

## 🚀 نحوه اجرا

```bash
# مثال کامل
flutter run lib/unified_responsive_example.dart
```

## 📖 مستندات بیشتر

برای اطلاعات بیشتر به فایل‌های زیر مراجعه کنید:
- `responsive_test_example.dart` - تست تمام قابلیت‌ها
- `unified_responsive_example.dart` - مثال دسترسی یکپارچه
- `responsive/README.md` - راهنمای کامل
