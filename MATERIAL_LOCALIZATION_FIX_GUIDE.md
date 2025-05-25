# راهنمای حل مشکل MaterialLocalizations

این راهنما برای حل خطای `No MaterialLocalizations found` در Flutter با GetX طراحی شده است.

## مشکل

وقتی از `GetCupertinoApp` استفاده می‌کنید اما widget های Material مثل `TextField`، `Scaffold`، یا `MaterialButton` به کار می‌برید، این خطا رخ می‌دهد:

```
FlutterError (No MaterialLocalizations found.
TextField widgets require MaterialLocalizations to be provided by a Localizations widget ancestor.
```

## راه‌حل‌های مختلف

### راه‌حل 1: استفاده از GetMaterialApp (توصیه شده)

ساده‌ترین راه‌حل تغییر `GetCupertinoApp` به `GetMaterialApp` است:

```dart
// قبل
GetCupertinoApp(
  home: MyHomePage(),
)

// بعد
GetMaterialApp(
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
  ),
  home: MyHomePage(),
)
```

### راه‌حل 2: تبدیل به Widget های Cupertino

اگر می‌خواهید از `GetCupertinoApp` استفاده کنید، widget های Material را به Cupertino تبدیل کنید:

#### جدول تبدیل Widget ها:

| Material Widget | Cupertino معادل |
|----------------|------------------|
| `Scaffold` | `CupertinoPageScaffold` |
| `AppBar` | `CupertinoNavigationBar` |
| `TextField` | `CupertinoTextField` |
| `MaterialButton` | `CupertinoButton` |
| `ElevatedButton` | `CupertinoButton.filled` |
| `AlertDialog` | `CupertinoAlertDialog` |

#### مثال تبدیل:

```dart
// قبل (Material)
Scaffold(
  appBar: AppBar(title: Text('صفحه ورود')),
  body: Column(
    children: [
      TextField(
        decoration: InputDecoration(labelText: 'ایمیل'),
      ),
      ElevatedButton(
        onPressed: () {},
        child: Text('ورود'),
      ),
    ],
  ),
)

// بعد (Cupertino)
CupertinoPageScaffold(
  navigationBar: CupertinoNavigationBar(
    middle: Text('صفحه ورود'),
  ),
  child: Column(
    children: [
      CupertinoTextField(
        placeholder: 'ایمیل',
        decoration: BoxDecoration(
          border: Border.all(color: CupertinoColors.systemGrey4),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      CupertinoButton.filled(
        onPressed: () {},
        child: Text('ورود'),
      ),
    ],
  ),
)
```

### راه‌حل 3: استفاده از Builder با Material

```dart
GetCupertinoApp(
  builder: (context, child) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: child,
    );
  },
  home: MyHomePage(),
)
```

### راه‌حل 4: Wrap کردن با Material

```dart
CupertinoPageScaffold(
  child: Material(
    child: Column(
      children: [
        TextField(
          decoration: InputDecoration(labelText: 'ایمیل'),
        ),
        MaterialButton(
          onPressed: () {},
          child: Text('ارسال'),
        ),
      ],
    ),
  ),
)
```

## مثال کامل - صفحه ورود با Material Design

```dart
import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'اپلیکیشن من',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('صفحه ورود'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'ایمیل',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'رمز عبور',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // منطق ورود
                },
                child: Text('ورود'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

## مثال کامل - صفحه ورود با Cupertino Design

```dart
import 'package:flutter/cupertino.dart';
import 'package:get_x_master/get_x_master.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetCupertinoApp(
      title: 'اپلیکیشن من',
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.systemBlue,
      ),
      home: CupertinoLoginPage(),
    );
  }
}

class CupertinoLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('صفحه ورود'),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoTextField(
                placeholder: 'ایمیل',
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemGrey4),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(height: 20),
              CupertinoTextField(
                placeholder: 'رمز عبور',
                obscureText: true,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemGrey4),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: CupertinoButton.filled(
                  onPressed: () {
                    // منطق ورود
                  },
                  child: Text('ورود'),
                ),
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

### 1. انتخاب درست App Type
- برای Material Design: `GetMaterialApp`
- برای iOS Design: `GetCupertinoApp`

### 2. سازگاری Widget ها
- با `GetMaterialApp`: از Material widgets استفاده کنید
- با `GetCupertinoApp`: از Cupertino widgets استفاده کنید

### 3. Theme سازی
```dart
// Material Theme
GetMaterialApp(
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    useMaterial3: true,
  ),
)

// Cupertino Theme
GetCupertinoApp(
  theme: CupertinoThemeData(
    primaryColor: CupertinoColors.systemBlue,
    brightness: Brightness.light,
  ),
)
```

### 4. Platform Adaptive
```dart
Widget buildButton() {
  if (GetPlatform.isIOS) {
    return CupertinoButton.filled(
      onPressed: () {},
      child: Text('دکمه iOS'),
    );
  } else {
    return ElevatedButton(
      onPressed: () {},
      child: Text('دکمه Android'),
    );
  }
}
```

## خلاصه

بهترین راه‌حل:
1. **برای اکثر پروژه‌ها**: از `GetMaterialApp` استفاده کنید
2. **برای طراحی iOS**: از `GetCupertinoApp` + Cupertino widgets
3. **برای ترکیبی**: از Builder با Material wrapper

این راه‌حل‌ها مشکل MaterialLocalizations را کاملاً حل می‌کنند.
