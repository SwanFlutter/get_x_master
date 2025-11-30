

### Documentation for `CustomExpandableBottomSheetRoute` and `customExpandableBottomSheet`

This document provides an overview of the `CustomExpandableBottomSheetRoute` class and the `customExpandableBottomSheet` function, which are used to create and display a highly customizable expandable bottom sheet in a Flutter application.

---

## Table of Contents
1. [Introduction](#introduction)
2. [CustomExpandableBottomSheetRoute](#customexpandablebottomsheetroute)
   - [Constructor](#constructor)
   - [Properties](#properties)
   - [Methods](#methods)
3. [customExpandableBottomSheet](#customexpandablebottomsheet)
   - [Parameters](#parameters)
   - [Usage](#usage)
4. [Example](#example)

---

## Introduction


<img src="https://github.com/user-attachments/assets/f8232e77-47f5-4b66-a582-a411c408f1dc" width="300"/> <img src="https://github.com/user-attachments/assets/22849080-4090-439e-aca0-e9a34d8c520d" width="300"/>


---

## CustomExpandableBottomSheetRoute

### Constructor

```dart
CustomExpandableBottomSheetRoute({
  required this.builder,
  this.theme,
  this.barrierLabel,
  this.backgroundColor,
  this.isPersistent = false,
  this.elevation,
  this.shape,
  this.clipBehavior,
  this.modalBarrierColor,
  this.isDismissible = true,
  this.enableDrag = true,
  this.isScrollControlled = true,
  this.scaffoldKey,
  this.messengerKey,
  super.settings,
  this.enterBottomSheetDuration = const Duration(milliseconds: 250),
  this.exitBottomSheetDuration = const Duration(milliseconds: 200),
  this.curve,
  this.initialChildSize = 0.5,
  this.minChildSize = 0.03,
  this.maxChildSize = 1.0,
  this.borderRadius = 15.0,
  this.startFromTop = false,
  this.snap = false,
  this.isShowCloseBottom = true,
  this.closeIcon = Icons.close,
  this.indicatorColor = const Color.fromRGBO(224, 224, 224, 1),
});
```

### Properties

- **`builder`**: A builder function that returns the widget tree representing the content of the bottom sheet.
- **`scaffoldKey`**: A key to access the `ScaffoldState` of the internal `Scaffold` used to display the bottom sheet.
- **`messengerKey`**: A key to access the `ScaffoldMessengerState`.
- **`initialChildSize`**: The initial size of the bottom sheet, expressed as a fraction of the screen height.
- **`minChildSize`**: The minimum size of the bottom sheet, expressed as a fraction of the screen height.
- **`maxChildSize`**: The maximum size of the bottom sheet, expressed as a fraction of the screen height.
- **`borderRadius`**: The radius of the top corners of the bottom sheet.
- **`startFromTop`**: Whether the bottom sheet should open from the top of the screen instead of the bottom.
- **`snap`**: Whether the bottom sheet should snap to `initialChildSize`, `minChildSize`, or `maxChildSize`.
- **`theme`**: The theme to apply to the bottom sheet.
- **`backgroundColor`**: The background color of the bottom sheet.
- **`elevation`**: The elevation of the bottom sheet.
- **`shape`**: The shape of the bottom sheet.
- **`clipBehavior`**: The clipping behavior of the bottom sheet.
- **`modalBarrierColor`**: The color of the modal barrier that darkens the background behind the bottom sheet.
- **`isPersistent`**: Whether the bottom sheet should be persistent.
- **`isScrollControlled`**: Whether the bottom sheet's height is determined by its content.
- **`isDismissible`**: Whether the bottom sheet can be dismissed by tapping on the modal barrier.
- **`enableDrag`**: Whether the bottom sheet can be dragged by the user.
- **`enterBottomSheetDuration`**: The duration of the animation that slides the bottom sheet into view.
- **`exitBottomSheetDuration`**: The duration of the animation that slides the bottom sheet out of view.
- **`curve`**: The curve to use for the animation that slides the bottom sheet into and out of view.
- **`isShowCloseBottom`**: Whether to show the close button at the bottom.
- **`closeIcon`**: The icon to use for the close button.
- **`indicatorColor`**: The color of the indicator.

### Methods

- **`createAnimation()`**: Creates the animation for the bottom sheet's entrance and exit transitions.
- **`createAnimationController()`**: Creates the animation controller for managing the bottom sheet's animations.
- **`buildPage()`**: Builds the bottom sheet's UI.
- **`dispose()`**: Disposes of the animation controller and reports the route disposal.

---

## customExpandableBottomSheet

### Parameters

- **`builder`**: Required. A builder function that returns the widget tree for the bottom sheet content.
- **`initialChildSize`**: The initial size of the bottom sheet (fraction of screen height). Defaults to `0.0` for top-down.
- **`minChildSize`**: The minimum size of the bottom sheet (fraction of screen height). Defaults to `0.0` for top-down.
- **`maxChildSize`**: The maximum size of the bottom sheet (fraction of screen height). Defaults to `1.0`.
- **`borderRadius`**: The radius of the rounded corners. Defaults to `15.0`.
- **`isDismissible`**: Whether the bottom sheet can be dismissed by tapping the barrier. Defaults to `true`.
- **`enableDrag`**: Whether the bottom sheet can be dragged. Defaults to `true`.
- **`snap`**: Whether the bottom sheet should snap to specific sizes. Defaults to `false`.
- **`backgroundColor`**: The background color of the bottom sheet.
- **`elevation`**: The elevation of the bottom sheet.
- **`enterBottomSheetDuration`**: The duration of the entrance animation.
- **`exitBottomSheetDuration`**: The duration of the exit animation.
- **`theme`**: A theme to apply to the bottom sheet.
- **`curve`**: The animation curve.
- **`shape`**: The shape of the bottom sheet.
- **`barrierLabel`**: The label for the barrier.
- **`clipBehavior`**: The clip behavior.
- **`isPersistent`**: Whether the bottom sheet is persistent (cannot be dismissed by tapping outside). Defaults to `false`.
- **`isScrollControlled`**: Whether the bottom sheet is scroll-controlled. Defaults to `true`.
- **`messengerKey`**: A key for accessing the `ScaffoldMessengerState`.
- **`modalBarrierColor`**: The color of the modal barrier.
- **`scaffoldKey`**: A key for accessing the `ScaffoldState`.
- **`settings`**: Route settings.
- **`startFromTop`**: Whether the bottom sheet should open from the top. Defaults to `true`.
- **`isShowCloseBottom`**: Whether to show the close button. Defaults to `false`.
- **`closeIcon`**: The icon to use for the close button. Defaults to `Icons.close`.
- **`indicatorColor`**: The color of the indicator. Defaults to `Color.fromRGBO(224, 224, 224, 1)`.

### Usage

```dart
Get.customExpandableBottomSheet(
  builder: (context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('This is a custom expandable bottom sheet'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  },
  initialChildSize: 0.5,
  minChildSize: 0.25,
  maxChildSize: 0.75,
  borderRadius: 20.0,
  isDismissible: true,
  enableDrag: true,
  startFromTop: false,
);
```

---

## Example

Here is a complete example demonstrating how to use the `customExpandableBottomSheet` function:

```dart
import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Expandable Bottom Sheet Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.customExpandableBottomSheet(
              builder: (context) {
                return Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('This is a custom expandable bottom sheet'),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Close'),
                      ),
                    ],
                  ),
                );
              },
              initialChildSize: 0.5,
              minChildSize: 0.25,
              maxChildSize: 0.75,
              borderRadius: 20.0,
              isDismissible: true,
              enableDrag: true,
              startFromTop: false,
            );
          },
          child: Text('Show Bottom Sheet'),
        ),
      ),
    );
  }
}
```

---


# GetSnackBar



`GetSnackBar` is a widget in the GetX Flutter library used to display short, temporary messages to the user (like notifications or confirmation messages). It's a replacement for Flutter's default `SnackBar` and offers more features, including:

-   Appearance customization (color, border, shadow, gradient, ...)
-   Icon display and animation for the icon
-   Adding an action button
-   Displaying a progress indicator
-   Support for input forms
-   Position control (top or bottom of the screen) and style (floating or grounded)
-   Control of entry and exit animations
-   Ability to close by swiping or touching the background
-   Snackbar queue management (display one after another)

## Usage

To display a `GetSnackBar`, you first need to create a `GetSnackBar` and then pass it to `Get` using the `show()` method:

```dart
Get.showSnackbar(
  GetSnackBar(
    title: 'Title',
    message: 'Snackbar message',
    duration: Duration(seconds: 3),
  ),
);
```

This code shows the simplest way to use GetSnackbar.

### GetSnackBar Parameters

`GetSnackBar` has many parameters for customization. Here we review the most important ones:

| Parameter                     | Type                      | Description                                                                                                                                                                                            | Default                  |
| :---------------------------- | :------------------------ | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----------------------- |
| `title`                       | `String?`                 | Snackbar title                                                                                                                                                                                         | `null`                   |
| `message`                     | `String?`                 | Main snackbar message                                                                                                                                                                                       | `null`                   |
| `titleText`                   | `Widget?`                 | Widget to display the title (replaces `title`)                                                                                                                                                                 | `null`                   |
| `messageText`                 | `Widget?`                 | Widget to display the message (replaces `message`)                                                                                                                                                               | `null`                   |
| `icon`                        | `Widget?`                 | Widget to display an icon next to the message                                                                                                                                                                       | `null`                   |
| `shouldIconPulse`            | `bool`                    | If `true`, the icon will have a pulse animation                                                                                                                                                         | `true`                   |
| `mainButton`                  | `Widget?`                 | Action button                                                                                                                                                                            | `null`                   |
| `onTap`                       | `OnTap?`                  | Function called when the snackbar is tapped (except for the action button)                                                                                                                                                 | `null`                   |
| `duration`                    | `Duration?`               | Duration of the snackbar display. If `null`, the snackbar will be displayed until manually closed.                                                                                               | `null`                   |
| `isDismissible`               | `bool`                    | If `true`, the user can close the snackbar by swiping or touching the background.                                                                                                                          | `true`                   |
| `dismissDirection`            | `DismissDirection?`       | Swipe direction to close the snackbar                                                                                                                                                                              | `DismissDirection.down`  |
| `showProgressIndicator`       | `bool`                    | If `true`, a progress bar will be displayed at the top of the snackbar.                                                                                                                                           | `false`                  |
| `progressIndicatorController` | `AnimationController?`     | Animation controller for the progress bar.                                                                                                                                                                    | `null`                   |
| `snackPosition`               | `SnackPosition`           | Snackbar position (`SnackPosition.TOP` or `SnackPosition.BOTTOM`)                                                                                                                                          | `SnackPosition.BOTTOM`  |
| `snackStyle`                  | `SnackStyle`              | Snackbar style (`SnackStyle.FLOATING` or `SnackStyle.GROUNDED`)                                                                                                                                            | `SnackStyle.FLOATING` |
| `backgroundColor`             | `Color`                   | Background color                                                                                                                                                                                         | `Color(0xFF303030)`     |
| `userInputForm`                | `Form?`                  | A `Form` widget to get user input. If this parameter is set, other widgets will be ignored.  |   `null`                   |
| `snackbarStatus`               | `SnackbarStatusCallback?` | A function called when snackbar status changes                                                                                                                                     | `null`                   |

### Examples

#### Example 1: Simple Snackbar

```dart
Get.showSnackbar(
  GetSnackBar(
    title: 'Notification',
    message: 'You received a new message!',
    duration: Duration(seconds: 3),
  ),
);
```

#### Example 2: Snackbar with Icon and Action Button

```dart
Get.showSnackbar(
  GetSnackBar(
    title: 'Error',
    message: 'Internet connection failed.',
    icon: Icon(Icons.error, color: Colors.red),
    mainButton: TextButton(
      child: Text('Retry', style: TextStyle(color: Colors.white)),
      onPressed: () {
        // Perform operation to reconnect
        Get.back(); // Close the snackbar
      },
    ),
    duration: Duration(seconds: 5),
    backgroundColor: Colors.grey[800]!,
  ),
);
```

#### Example 3: Snackbar with Form

```dart
 Get.showSnackbar(GetSnackBar(
  title: "User input form",
      userInputForm: Form(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Type your message',
                ),
              ),
            ),
            TextButton(onPressed: (){
              //do something
            }, child: Text("Send"))
          ],
        ),
      ),
 ));
```

#### Example 4: Using `snackbarStatus`

```dart
Get.showSnackbar(
  GetSnackBar(
    title: 'Status',
    message: 'Loading...',
    duration: Duration(seconds: 5),
    snackbarStatus: (status) {
      print('Snackbar status: $status');
      // Snackbar status: SnackbarStatus.OPENING
      // Snackbar status: SnackbarStatus.OPEN
      // Snackbar status: SnackbarStatus.CLOSING
      // Snackbar status: SnackbarStatus.CLOSED
    },
  ),
);

---


# Conditional Navigation Support - Implementation Walkthrough

## Overview
Successfully added `ConditionalNavigation` parameter support to all route-based navigation methods in the GetX `extension_navigation.dart` file, enabling dynamic page navigation based on runtime conditions.

## Changes Made

### 1. Updated Navigation Methods

Modified the following methods in `extension_navigation.dart`:

#### Method: `to()` (Already Implemented)
- ✅ Already had `ConditionalNavigation? condition` parameter
- Located at lines 759-798
- Serves as the reference implementation

#### Method: `off()`
- ✅ Added `ConditionalNavigation? condition` parameter at line 1166
- ✅ Added condition evaluation logic at lines 1168-1171
- Updated documentation with examples at lines 1138-1151

```dart
Future<T?>? off<T>(
  dynamic page, {
  // ... other parameters
  ConditionalNavigation? condition,
}) {
  if (condition != null) {
    page = condition.evaluate();
  }
  // ... rest of implementation
}
```

#### Method: `offAll()`
- ✅ Added `ConditionalNavigation? condition` parameter at line 1250
- ✅ Added condition evaluation logic at lines 1252-1255
- Updated documentation with examples at lines 1221-1235

```dart
Future<T?>? offAll<T>(
  dynamic page, {
  // ... other parameters
  ConditionalNavigation? condition,
}) {
  if (condition != null) {
    page = condition.evaluate();
  }
  // ... rest of implementation
}
```

### 2. Created Comprehensive Example

Created `conditional_navigation_example.dart` with:

#### Features
- **Interactive Demo App**: Complete Flutter application showcasing all three navigation methods
- **Auth Service Simulation**: Simulates authentication states (login, onboarding, premium)
- **Toggle Controls**: Users can toggle conditions to see how navigation changes
- **Three Navigation Examples**:
  1. `Get.to()` - Conditional push navigation
  2. `Get.off()` - Conditional replacement navigation
  3. `Get.offAll()` - Conditional clear-all navigation

#### Example Pages Included
- `StartPage` - Main demo page with controls
- `HomePage` - Standard home destination
- `LoginPage` - Displayed when user is not logged in
- `OnboardingPage` - Displayed when onboarding not completed
- `PremiumDashboard` - Displayed for premium users

#### Usage Examples in Code

**Example 1: Get.to() with condition**
```dart
Get.to(
  () => HomePage(),
  condition: ConditionalNavigation(
    condition: () => AuthService.isLoggedIn,
    truePage: () => HomePage(),
    falsePage: () => LoginPage(),
  ),
  transition: Transition.fadeIn,
);
```

**Example 2: Get.off() with condition**
```dart
Get.off(
  () => HomePage(),
  condition: ConditionalNavigation(
    condition: () => AuthService.hasCompletedOnboarding,
    truePage: () => HomePage(),
    falsePage: () => OnboardingPage(),
  ),
  transition: Transition.rightToLeft,
);
```

**Example 3: Get.offAll() with condition**
```dart
Get.offAll(
  () => HomePage(),
  condition: ConditionalNavigation(
    condition: () => AuthService.isPremiumUser,
    truePage: () => PremiumDashboard(),
    falsePage: () => HomePage(),
  ),
  transition: Transition.zoom,
);
```

## How It Works

### ConditionalNavigation Class
Located at `navigation_condition.dart`:

```dart
class ConditionalNavigation {
  final dynamic Function() condition;
  final dynamic Function() truePage;
  final dynamic Function() falsePage;

  ConditionalNavigation({
    required this.condition,
    required this.truePage,
    required this.falsePage,
  });

  dynamic Function() evaluate() {
    return condition() ? truePage : falsePage;
  }
}
```

### Evaluation Flow
1. Navigation method is called with a `page` and optional `condition`
2. If `condition` is provided, it evaluates the boolean condition
3. Based on result, selects either `truePage` or `falsePage`
4. The selected page replaces the original `page` parameter
5. Navigation proceeds with the conditionally-selected page

## Benefits

### 1. **Cleaner Code**
Instead of writing:
```dart
if (AuthService.isLoggedIn) {
  Get.to(() => HomePage());
} else {
  Get.to(() => LoginPage());
}
```

Now write:
```dart
Get.to(
  () => HomePage(),
  condition: ConditionalNavigation(
    condition: () => AuthService.isLoggedIn,
    truePage: () => HomePage(),
    falsePage: () => LoginPage(),
  ),
);
```

### 2. **Consistent API**
All navigation methods (`to`, `off`, `offAll`) now support conditional navigation using the same pattern.

### 3. **Declarative Navigation**
Express navigation intent declaratively rather than imperatively, making code easier to read and maintain.

### 4. **Type Safety**
Leverages Dart's type system to ensure proper page constructors are provided.

## Testing the Example

To run the example:

1. Navigate to the example directory:
   ```bash
   cd example
   ```

2. Run the example:
   ```bash
   flutter run -t lib/conditional_navigation_example.dart
   ```

3. Interact with the demo:
   - Toggle the status switches (Login, Onboarding, Premium)
   - Try each navigation method
   - Observe how different conditions lead to different pages

## Summary

✅ **Completed Tasks:**
- Added `ConditionalNavigation` support to `off()` method
- Added `ConditionalNavigation` support to `offAll()` method  
- Added comprehensive documentation with examples
- Created interactive demo application
- Demonstrated all three navigation patterns

The implementation maintains consistency with the existing `to()` method and provides a clean, declarative API for conditional navigation across the entire GetX navigation system.
