# Enhanced Cupertino Features in GetX

This guide covers the new and enhanced Cupertino features available in the latest version of Flutter, now fully supported in GetX's `GetCupertinoApp`.

## Overview

Flutter has introduced several significant improvements to Cupertino widgets, bringing them closer to native iOS design standards. GetX now supports all these new features through the enhanced `GetCupertinoApp`.

## New Features

### 1. Rounded Superellipse (Apple Squircle)

The rounded superellipse, often called the "Apple squircle," provides smoother and more continuous curves compared to traditional rounded rectangles. This shape is a cornerstone of iOS design language.

#### Key Benefits:
- ✅ More authentic iOS look and feel
- ✅ Smoother, more continuous curves
- ✅ Matches native iOS design standards
- ✅ Automatic fallback on unsupported platforms

#### Supported Widgets:
- `CupertinoAlertDialog` - Now uses squircle shape
- `CupertinoActionSheet` - Enhanced with squircle corners
- Custom widgets using new shape APIs

#### New Shape APIs:
```dart
// For painting or as widget shape
RoundedSuperellipseBorder(
  borderRadius: BorderRadius.circular(16),
)

// For clipping
ClipRSuperellipse(
  borderRadius: BorderRadius.circular(16),
  child: YourWidget(),
)

// Lower-level Canvas APIs
canvas.drawRSuperellipse(rect, borderRadius, paint);
canvas.clipRSuperellipse(rect, borderRadius);
path.addRSuperellipse(rect, borderRadius);
```

#### Example Usage:
```dart
GetCupertinoApp(
  home: CupertinoPageScaffold(
    child: Center(
      child: CupertinoButton(
        child: Text('Show Alert'),
        onPressed: () {
          showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: Text('Squircle Alert'),
              content: Text('This uses the new rounded superellipse!'),
              actions: [
                CupertinoDialogAction(
                  child: Text('OK'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        },
      ),
    ),
  ),
)
```

### 2. Enhanced Cupertino Sheet

The Cupertino sheet has received several important improvements:

#### Improvements:
- ✅ Fixed system UI theme handling on Android
- ✅ Proper navigation bar height calculation
- ✅ Content no longer cut off at bottom
- ✅ Improved rounded corner transitions
- ✅ Better compatibility with PopupMenuButton
- ✅ New `enableDrag` parameter for controlling drag behavior

#### New Features:
```dart
// Disable drag-to-dismiss behavior
showCupertinoModalPopup(
  context: context,
  builder: (context) => CupertinoActionSheet(
    // Your sheet content
  ),
  // New parameter to control drag behavior
  useRootNavigator: true,
);

// Using CupertinoSheetRoute directly
Navigator.push(
  context,
  CupertinoSheetRoute(
    builder: (context) => YourSheetWidget(),
    enableDrag: false, // Disable drag-to-dismiss
  ),
);
```

### 3. Improved Navigation

Navigation components have been enhanced to match the latest iOS design:

#### CupertinoSliverNavigationBar Improvements:
- ✅ Better search view animations
- ✅ Correct alignment of search field icons
- ✅ Improved prefix and suffix icon positioning

#### Navigation Transitions:
- ✅ Updated to match latest iOS transitions
- ✅ Smoother animations between routes
- ✅ Better handling of large titles

#### Example:
```dart
CupertinoPageScaffold(
  navigationBar: CupertinoSliverNavigationBar(
    largeTitle: Text('My App'),
    trailing: CupertinoButton(
      padding: EdgeInsets.zero,
      child: Icon(CupertinoIcons.search),
      onPressed: () {
        // Search functionality with improved animations
      },
    ),
  ),
  child: CustomScrollView(
    slivers: [
      // Your content
    ],
  ),
)
```

## GetCupertinoApp Enhancements

The `GetCupertinoApp` has been updated to support all new Flutter features:

### New Properties:

```dart
GetCupertinoApp(
  // Existing properties...
  
  // New Flutter Cupertino features
  scrollBehavior: CupertinoScrollBehavior(), // Custom scroll behavior
  restorationId: 'my_app', // State restoration support
  actions: <Type, Action<Intent>>{
    // Custom actions
  },
  
  // Enhanced theming
  theme: CupertinoThemeData(
    primaryColor: CupertinoColors.systemBlue,
    brightness: Brightness.light,
  ),
)
```

### Complete Example:

```dart
import 'package:flutter/cupertino.dart';
import 'package:get_x_master/get_x_master.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetCupertinoApp(
      title: 'Enhanced Cupertino App',
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.systemBlue,
        brightness: Brightness.light,
      ),
      scrollBehavior: CupertinoScrollBehavior(),
      restorationId: 'cupertino_app',
      home: HomePage(),
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
        GetPage(name: '/details', page: () => DetailsPage()),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Home'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.add),
          onPressed: () => Get.toNamed('/details'),
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Squircle example
              Container(
                width: 100,
                height: 100,
                decoration: ShapeDecoration(
                  color: CupertinoColors.systemBlue,
                  shape: RoundedSuperellipseBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 20),
              CupertinoButton.filled(
                child: Text('Show Enhanced Sheet'),
                onPressed: () => _showEnhancedSheet(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEnhancedSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 300,
        decoration: BoxDecoration(
          color: CupertinoColors.systemBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey3,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Enhanced Cupertino Sheet',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Sheet content
          ],
        ),
      ),
    );
  }
}
```

## Migration Guide

### From Previous GetCupertinoApp:

The migration is seamless - all existing code continues to work. New features are opt-in:

```dart
// Before
GetCupertinoApp(
  home: MyHomePage(),
  theme: CupertinoThemeData(),
)

// After - with new features
GetCupertinoApp(
  home: MyHomePage(),
  theme: CupertinoThemeData(),
  scrollBehavior: CupertinoScrollBehavior(), // New
  restorationId: 'my_app', // New
)
```

### Platform Support:

- **iOS**: Full support for all new features
- **Android**: Full support for all new features
- **Other platforms**: Graceful fallback to standard rounded rectangles

## Best Practices

### 1. Use Squircles for iOS-style Design:
```dart
// Good: Use squircle for iOS-authentic look
Container(
  decoration: ShapeDecoration(
    shape: RoundedSuperellipseBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
)

// Avoid: Traditional rounded rectangle for iOS design
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(16),
  ),
)
```

### 2. Leverage Enhanced Sheets:
```dart
// Good: Use new sheet features
showCupertinoModalPopup(
  context: context,
  useRootNavigator: true,
  builder: (context) => YourSheet(),
)
```

### 3. Implement Proper State Restoration:
```dart
GetCupertinoApp(
  restorationId: 'app_state',
  // This enables automatic state restoration
)
```

## Performance Considerations

- Rounded superellipse is optimized but still under active development
- Performance improvements are ongoing
- Use judiciously in performance-critical areas
- Consider fallback behavior on older devices

## Conclusion

The enhanced Cupertino features in GetX provide a more authentic iOS experience while maintaining the powerful state management and routing capabilities that GetX is known for. These improvements bring your Flutter apps closer to native iOS design standards while preserving cross-platform compatibility.
