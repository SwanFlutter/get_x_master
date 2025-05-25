# Material and Cupertino Widget Mixing Guide

This guide explains how to handle the common issue of mixing Material and Cupertino widgets in Flutter with GetX.

## The Problem

When using `GetCupertinoApp`, you might encounter this error:

```
FlutterError (No MaterialLocalizations found.
TextField widgets require MaterialLocalizations to be provided by a Localizations widget ancestor.
```

This happens because Material widgets (like `TextField`, `Scaffold`, `MaterialButton`) require `MaterialLocalizations`, which are automatically provided by `MaterialApp` but not by `CupertinoApp`.

## Solutions

### Solution 1: Use GetMaterialApp (Recommended for Material Design)

If your app primarily uses Material Design widgets, switch to `GetMaterialApp`:

```dart
import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
```

### Solution 2: Convert to Cupertino Widgets

If you want to keep `GetCupertinoApp`, replace Material widgets with Cupertino equivalents:

#### Widget Conversion Table:

| Material Widget | Cupertino Equivalent |
|----------------|---------------------|
| `Scaffold` | `CupertinoPageScaffold` |
| `AppBar` | `CupertinoNavigationBar` |
| `TextField` | `CupertinoTextField` |
| `MaterialButton` | `CupertinoButton` |
| `ElevatedButton` | `CupertinoButton.filled` |
| `FloatingActionButton` | `CupertinoButton` |
| `Switch` | `CupertinoSwitch` |
| `Slider` | `CupertinoSlider` |
| `AlertDialog` | `CupertinoAlertDialog` |
| `BottomSheet` | `CupertinoActionSheet` |

#### Example Conversion:

```dart
// Before (Material)
Scaffold(
  appBar: AppBar(title: Text('Login')),
  body: Column(
    children: [
      TextField(
        decoration: InputDecoration(labelText: 'Email'),
      ),
      ElevatedButton(
        onPressed: () {},
        child: Text('Login'),
      ),
    ],
  ),
)

// After (Cupertino)
CupertinoPageScaffold(
  navigationBar: CupertinoNavigationBar(
    middle: Text('Login'),
  ),
  child: Column(
    children: [
      CupertinoTextField(
        placeholder: 'Email',
        decoration: BoxDecoration(
          border: Border.all(color: CupertinoColors.systemGrey4),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      CupertinoButton.filled(
        onPressed: () {},
        child: Text('Login'),
      ),
    ],
  ),
)
```

### Solution 3: Enhanced GetCupertinoApp with Material Support

Use `GetCupertinoApp` with a builder that provides Material support:

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetCupertinoApp(
      title: 'My App',
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.systemBlue,
      ),
      // This builder provides Material support
      builder: (context, child) {
        return Material(
          child: child ?? Container(),
        );
      },
      home: MyHomePage(),
    );
  }
}
```

### Solution 4: Hybrid Approach

Wrap specific Material widgets with `Material`:

```dart
CupertinoPageScaffold(
  child: Material(
    child: Column(
      children: [
        // Now you can use Material widgets
        TextField(
          decoration: InputDecoration(labelText: 'Email'),
        ),
        MaterialButton(
          onPressed: () {},
          child: Text('Submit'),
        ),
      ],
    ),
  ),
)
```

### Solution 5: Localization Wrapper

Create a custom wrapper that provides both localizations:

```dart
class HybridApp extends StatelessWidget {
  final Widget child;
  
  const HybridApp({required this.child});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', 'US'),
      ],
      home: Material(child: child),
    );
  }
}
```

## Best Practices

### 1. Choose One Design System

**Recommended**: Stick to one design system throughout your app:
- Use `GetMaterialApp` + Material widgets for Material Design
- Use `GetCupertinoApp` + Cupertino widgets for iOS design

### 2. Platform-Specific Design

Use platform-specific widgets based on the platform:

```dart
Widget buildButton() {
  if (GetPlatform.isIOS) {
    return CupertinoButton.filled(
      onPressed: () {},
      child: Text('iOS Button'),
    );
  } else {
    return ElevatedButton(
      onPressed: () {},
      child: Text('Android Button'),
    );
  }
}
```

### 3. Custom Adaptive Widgets

Create adaptive widgets that automatically choose the right design:

```dart
class AdaptiveButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const AdaptiveButton({
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    if (GetPlatform.isIOS) {
      return CupertinoButton.filled(
        onPressed: onPressed,
        child: Text(text),
      );
    }
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
```

### 4. Theme Consistency

Ensure consistent theming across both design systems:

```dart
GetMaterialApp(
  theme: ThemeData(
    primarySwatch: Colors.blue,
    // Material theme
  ),
  cupertinoTheme: CupertinoThemeData(
    primaryColor: CupertinoColors.systemBlue,
    // Cupertino theme that matches Material theme
  ),
)
```

## Common Widgets and Their Alternatives

### Text Input
```dart
// Material
TextField(
  decoration: InputDecoration(
    labelText: 'Email',
    border: OutlineInputBorder(),
  ),
)

// Cupertino
CupertinoTextField(
  placeholder: 'Email',
  decoration: BoxDecoration(
    border: Border.all(color: CupertinoColors.systemGrey4),
    borderRadius: BorderRadius.circular(8),
  ),
)
```

### Buttons
```dart
// Material
ElevatedButton(
  onPressed: () {},
  child: Text('Button'),
)

// Cupertino
CupertinoButton.filled(
  onPressed: () {},
  child: Text('Button'),
)
```

### Navigation
```dart
// Material
Scaffold(
  appBar: AppBar(title: Text('Title')),
  body: YourContent(),
)

// Cupertino
CupertinoPageScaffold(
  navigationBar: CupertinoNavigationBar(
    middle: Text('Title'),
  ),
  child: YourContent(),
)
```

### Dialogs
```dart
// Material
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: Text('Alert'),
    content: Text('Message'),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text('OK'),
      ),
    ],
  ),
)

// Cupertino
showCupertinoDialog(
  context: context,
  builder: (context) => CupertinoAlertDialog(
    title: Text('Alert'),
    content: Text('Message'),
    actions: [
      CupertinoDialogAction(
        onPressed: () => Navigator.pop(context),
        child: Text('OK'),
      ),
    ],
  ),
)
```

## Conclusion

The key to avoiding Material/Cupertino mixing issues is to:

1. **Choose the right app type** (`GetMaterialApp` vs `GetCupertinoApp`)
2. **Use consistent widget families** (all Material or all Cupertino)
3. **Provide proper localization support** when mixing is necessary
4. **Consider platform-adaptive approaches** for cross-platform consistency

For most apps, using `GetMaterialApp` with Material widgets provides the best compatibility and fewer issues.
