# 📱 GetX Master Responsive Design System

<p align="center">
  <strong>A comprehensive, production-ready responsive design system for Flutter</strong>
</p>

<p align="center">
  <em>Pixel-perfect adaptations across Mobile, Tablet, Laptop, Desktop, and TV devices</em>
</p>

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Key Features](#-key-features)
- [Architecture](#-architecture)
- [Installation](#-installation)
- [Quick Start](#-quick-start)
- [Core Components](#-core-components)
  - [GetResponsiveBuilder](#1-getresponsivebuilder)
  - [ResponsiveData](#2-responsivedata)
  - [Size Extensions](#3-size-extensions)
  - [Real-time Extensions](#4-real-time-extensions)
  - [Responsive Widgets](#5-responsive-widgets)
- [API Reference](#-api-reference)
- [Device Breakpoints](#-device-breakpoints)
- [Best Practices](#-best-practices)
- [Examples](#-examples)
- [Migration Guide](#-migration-guide)
- [FAQ](#-faq)

---

## 🎯 Overview

The GetX Master Responsive Design System provides a unified, context-free approach to building responsive Flutter applications. It automatically adapts your UI to any screen size while maintaining design consistency across all device types.

### Why Choose This System?

| Feature | Traditional Approach | GetX Master Responsive |
|---------|---------------------|------------------------|
| Context Dependency | Required | Optional |
| Real-time Updates | Manual | Automatic |
| Device Detection | Manual | Built-in |
| Font Scaling | Basic | Smart & Adaptive |
| Code Complexity | High | Minimal |

---

## 🚀 Key Features

### Core Capabilities

- **🔄 Unified API** - Access all responsive features through `GetResponsiveBuilder` and `ResponsiveData`
- **🆓 Context-Free** - No `BuildContext` required for responsive calculations using extensions
- **⚡ Real-Time Updates** - UI adapts instantly when window is resized
- **📐 Percentage-Based Sizing** - Use `.wp` and `.hp` for relative sizing
- **🎨 Pixel-to-Responsive** - Convert design pixels to responsive units with `.w` and `.h`
- **🔤 Smart Font Scaling** - Text scales intelligently across devices with `.sp`, `.ssp`, and `.hsp`
- **📱 Device Detection** - Automatic detection of device type (Phone, Tablet, Laptop, Desktop, TV)
- **🧩 Responsive Widgets** - Ready-to-use widgets that handle responsiveness automatically
- **🛡️ Fallback Support** - Graceful degradation when GetX is not initialized

### Supported Platforms

| Platform | Status | Notes |
|----------|--------|-------|
| Android | ✅ Full Support | All screen sizes |
| iOS | ✅ Full Support | iPhone, iPad |
| Web | ✅ Full Support | Real-time resize |
| Windows | ✅ Full Support | Desktop & Laptop |
| macOS | ✅ Full Support | Desktop & Laptop |
| Linux | ✅ Full Support | Desktop & Laptop |

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    GetX Master Responsive                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐  │
│  │ responsive_     │  │ size_percent_   │  │ realtime_       │  │
│  │ builder.dart    │  │ extension.dart  │  │ responsive_     │  │
│  │                 │  │                 │  │ extension.dart  │  │
│  │ • GetResponsive │  │ • PercentSized  │  │ • Realtime      │  │
│  │   Builder       │  │ • ResponsiveSize│  │   Extensions    │  │
│  │ • ResponsiveData│  │ • GetResponsive │  │ • Responsive    │  │
│  │ • ResponsiveMode│  │   Helper        │  │   Widgets       │  │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘  │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │                    Device Detection                       │   │
│  │  Phone │ Tablet │ Laptop │ Desktop │ TV                  │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### File Structure

| File | Description |
|------|-------------|
| `responsive_builder.dart` | Core builder widget and ResponsiveData class |
| `size_percent_extension.dart` | Extensions for num/double types and helper class |
| `realtime_responsive_extension.dart` | Real-time responsive widgets and extensions |

---

## 📦 Installation

The responsive system is included in GetX Master. Import the responsive module:

```dart
import 'package:get_x_master/get_x_master.dart';

// Or import specific files:
import 'package:get_x_master/src/responsive/responsive_builder.dart';
import 'package:get_x_master/src/responsive/size_percent_extension.dart';
import 'package:get_x_master/src/responsive/realtime_responsive_extension.dart';
```

---

## ⚡ Quick Start

### Basic Usage in 3 Steps

**Step 1: Use Extensions (Simplest)**
```dart
Container(
  width: 200.w,      // Responsive width
  height: 100.h,     // Responsive height
  child: Text(
    'Hello World',
    style: TextStyle(fontSize: 16.sp),  // Responsive font
  ),
)
```

**Step 2: Use Builder (Real-time)**
```dart
GetResponsiveBuilder(
  builder: (context, data) {
    return Container(
      width: data.w(200),
      height: data.h(100),
      child: Text(
        'Hello World',
        style: TextStyle(fontSize: data.sp(16)),
      ),
    );
  },
)
```

**Step 3: Use Responsive Widgets (Convenient)**
```dart
GetResponsiveContainer(
  width: 200,
  height: 100,
  child: GetResponsiveText(
    'Hello World',
    fontSize: 16,
  ),
)
```

---

## 🧩 Core Components

### 1. GetResponsiveBuilder

The main widget for building responsive UIs with real-time updates.

```dart
GetResponsiveBuilder(
  mode: ResponsiveMode.layoutBuilder, // Default
  builder: (BuildContext context, ResponsiveData data) {
    return YourWidget();
  },
)
```

#### Responsive Modes

| Mode | Description | Use Case |
|------|-------------|----------|
| `ResponsiveMode.layoutBuilder` | Uses LayoutBuilder for real-time updates | Default, recommended for most cases |
| `ResponsiveMode.singlePage` | Uses MediaQuery for single-page updates | Single page responsive layouts |
| `ResponsiveMode.global` | Uses GetX for global values | When GetX is fully initialized |

#### Complete Example

```dart
GetResponsiveBuilder(
  mode: ResponsiveMode.layoutBuilder,
  builder: (context, data) {
    return Scaffold(
      body: Container(
        // Responsive sizing
        width: data.w(200),
        height: data.h(100),
        
        // Responsive padding
        padding: data.responsiveInsetsAll(16),
        
        // Responsive border radius
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: data.responsiveBorderRadiusCircular(12),
        ),
        
        // Device-specific values
        child: data.responsiveValue<Widget>(
          phone: _buildMobileLayout(data),
          tablet: _buildTabletLayout(data),
          laptop: _buildLaptopLayout(data),
          desktop: _buildDesktopLayout(data),
          tv: _buildTvLayout(data),
        ),
      ),
    );
  },
)
```

---

### 2. ResponsiveData

A comprehensive data container with all responsive calculations.

#### Factory Constructors

```dart
// From LayoutBuilder constraints (recommended)
ResponsiveData.fromConstraints(BoxConstraints constraints)

// From MediaQuery
ResponsiveData.fromMediaQuery(MediaQueryData mediaQuery)

// From GetX (global)
ResponsiveData.fromGetX()
```

#### Properties

| Property | Type | Description |
|----------|------|-------------|
| `width` | `double` | Current screen width |
| `height` | `double` | Current screen height |
| `deviceType` | `String` | Current device type |
| `isLandscape` | `bool` | Landscape orientation |
| `isPortrait` | `bool` | Portrait orientation |
| `aspectRatio` | `double` | Width/Height ratio |
| `baseWidth` | `double` | Base design width |
| `baseHeight` | `double` | Base design height |
| `pixelRatio` | `double` | Device pixel ratio |

#### Device Type Getters

```dart
data.isPhone    // true if phone
data.isTablet   // true if tablet
data.isLaptop   // true if laptop
data.isDesktop  // true if desktop
data.isTv       // true if TV
```

#### Sizing Methods

```dart
// Basic responsive sizing
data.w(200)           // Responsive width
data.h(100)           // Responsive height

// Percentage-based
data.wp(50)           // 50% of screen width
data.hp(30)           // 30% of screen height

// Font sizing
data.sp(16)           // Standard responsive font
data.ssp(14)          // Small responsive font
data.hsp(24)          // Header responsive font

// Widget sizing
data.ws(24)           // Widget size (icons, buttons)
data.imgSize(100)     // Image size

// Dimension helpers
data.minDimension(50) // Based on min(width, height)
data.maxDimension(50) // Based on max(width, height)

// Percentage calculations
data.widthPercent(100)  // What % is 100px of width
data.heightPercent(200) // What % is 200px of height
```

#### EdgeInsets & BorderRadius

```dart
// EdgeInsets
data.responsiveInsets(left: 16, top: 8, right: 16, bottom: 8)
data.responsiveInsetsSymmetric(horizontal: 16, vertical: 8)
data.responsiveInsetsAll(16)

// BorderRadius
data.responsiveBorderRadius(
  topLeft: 12,
  topRight: 12,
  bottomLeft: 8,
  bottomRight: 8,
)
data.responsiveBorderRadiusCircular(12)
```

#### Device-Specific Values

```dart
// Generic type support
final columns = data.responsiveValue<int>(
  phone: 1,
  tablet: 2,
  laptop: 3,
  desktop: 4,
  tv: 5,
  defaultValue: 1,
);

// Widget example
final layout = data.responsiveValue<Widget>(
  phone: MobileLayout(),
  tablet: TabletLayout(),
  desktop: DesktopLayout(),
);
```

---

### 3. Size Extensions

Context-free extensions for quick responsive calculations.

#### PercentSized Extension (on `double`)

```dart
// Percentage of screen
50.0.hp    // 50% of screen height
30.0.wp    // 30% of screen width

// Pixel to responsive
100.0.w    // 100px adapted to screen width
80.0.h     // 80px adapted to screen height

// Percentage calculations
100.0.widthPercent   // What % is 100px of width
200.0.heightPercent  // What % is 200px of height

// Direct responsive conversion
100.0.toResponsiveWidth
100.0.toResponsiveHeight
```

#### ResponsiveSize Extension (on `num`)

```dart
// Font sizing
16.sp              // Standard responsive font
14.ssp             // Small responsive font  
24.hsp             // Header responsive font
16.fs              // Original size (no scaling)
18.spWithBreakpoints // Font with breakpoint scaling

// Widget sizing
24.ws              // Widget size (icons, buttons)
100.imgSize        // Image size

// Basic responsive
200.w              // Responsive width
100.h              // Responsive height

// Percentage
50.wp              // 50% of screen width
30.hp              // 30% of screen height

// Percentage calculations
100.widthPercent   // What % is 100 of width
200.heightPercent  // What % is 200 of height
```

#### ResponsiveWidgetExtension (on `Widget`)

```dart
// Wrap widget with responsive sizing
Container()
  .responsive(
    width: 200,
    height: 100,
    padding: EdgeInsets.all(16),
  )
```

---

### 4. Real-time Extensions

Extensions that return widgets with real-time responsive updates.

#### RealtimeResponsiveExtension (on `num`)

```dart
// Real-time responsive width
100.rw((width) => Container(width: width))

// Real-time responsive height
50.rh((height) => Container(height: height))

// Real-time responsive font
16.rsp((fontSize) => Text('Hello', style: TextStyle(fontSize: fontSize)))

// Real-time widget size
24.rws((size) => Icon(Icons.home, size: size))

// Real-time percentage
50.rwp((width) => Container(width: width))
30.rhp((height) => Container(height: height))
```

---

### 5. Responsive Widgets

Pre-built widgets with automatic responsive behavior.

#### GetResponsiveText

```dart
GetResponsiveText(
  'Hello World',
  fontSize: 16,
  style: TextStyle(color: Colors.black),
  mode: ResponsiveMode.layoutBuilder,
  textAlign: TextAlign.center,
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
)
```

#### GetResponsiveContainer

```dart
GetResponsiveContainer(
  width: 200,
  height: 100,
  padding: EdgeInsets.all(16),
  margin: EdgeInsets.symmetric(horizontal: 8),
  decoration: BoxDecoration(color: Colors.blue),
  alignment: Alignment.center,
  mode: ResponsiveMode.layoutBuilder,
  child: YourWidget(),
)
```

#### GetResponsiveSizedBox

```dart
GetResponsiveSizedBox(
  width: 200,
  height: 100,
  mode: ResponsiveMode.layoutBuilder,
  child: YourWidget(),
)
```

#### GetResponsivePadding

```dart
GetResponsivePadding(
  padding: EdgeInsets.all(16),
  mode: ResponsiveMode.layoutBuilder,
  child: YourWidget(),
)
```

#### GetResponsiveIcon

```dart
GetResponsiveIcon(
  Icons.home,
  size: 24,
  color: Colors.blue,
  mode: ResponsiveMode.layoutBuilder,
)
```

#### GetResponsiveElevatedButton

```dart
GetResponsiveElevatedButton(
  onPressed: () {},
  width: 200,
  height: 50,
  fontSize: 16,
  style: ButtonStyle(...),
  mode: ResponsiveMode.layoutBuilder,
  child: Text('Click Me'),
)
```

#### GetSinglePageResponsive

```dart
GetSinglePageResponsive(
  builder: (data) {
    return Container(
      width: data.w(200),
      child: Text('Single Page'),
    );
  },
)
```

#### GetLayoutBuilderResponsive

```dart
GetLayoutBuilderResponsive(
  builder: (data) {
    return Container(
      width: data.w(200),
      child: Text('Layout Builder'),
    );
  },
)
```

---

## 📖 API Reference

### GetResponsiveHelper (Static Class)

A helper class for responsive calculations without context dependency.

#### Device Detection

```dart
GetResponsiveHelper.deviceType      // 'phone', 'tablet', 'laptop', 'desktop'
GetResponsiveHelper.isPhone         // bool
GetResponsiveHelper.isTablet        // bool
GetResponsiveHelper.isLaptop        // bool
GetResponsiveHelper.isDesktop       // bool
GetResponsiveHelper.isLandscape     // bool
GetResponsiveHelper.isPortrait      // bool
```

#### Sizing Methods

```dart
GetResponsiveHelper.w(200)          // Responsive width
GetResponsiveHelper.h(100)          // Responsive height
GetResponsiveHelper.wp(50)          // 50% of screen width
GetResponsiveHelper.hp(30)          // 30% of screen height
GetResponsiveHelper.ssp(16)         // Responsive font size
GetResponsiveHelper.ws(24)          // Widget size
GetResponsiveHelper.imgSize(100)    // Image size
GetResponsiveHelper.minDimension(50)// Min dimension based
GetResponsiveHelper.maxDimension(50)// Max dimension based
```

#### Percentage Calculations

```dart
GetResponsiveHelper.widthPercentage(100)  // What % is 100px of width
GetResponsiveHelper.heightPercentage(200) // What % is 200px of height
```

#### Screen Information

```dart
Map<String, dynamic> info = GetResponsiveHelper.screenInfo;
// Returns:
// {
//   'width': 375.0,
//   'height': 812.0,
//   'aspectRatio': 0.46,
//   'deviceType': 'phone',
//   'baseWidth': 375.0,
//   'baseHeight': 812.0,
//   'isTablet': false,
//   'isPhone': true,
//   'isLaptop': false,
//   'isDesktop': false,
//   'isLandscape': false,
//   'isPortrait': true,
//   'textScaleFactor': 1.0,
//   'widgetScaleFactor': 1.0,
//   'imageScaleFactor': 1.0,
// }
```

#### Responsive Values

```dart
// Static responsive value (updates on restart/hot reload)
final columns = GetResponsiveHelper.responsiveValue<int>(
  phone: 1,
  tablet: 2,
  laptop: 3,
  desktop: 4,
  tv: 5,
  defaultValue: 1,
);

// Real-time responsive value (updates on resize)
GetResponsiveHelper.responsiveValueRealtime<int>(
  builder: (value) => GridView.count(crossAxisCount: value),
  phone: 1,
  tablet: 2,
  laptop: 3,
  desktop: 4,
  tv: 5,
  defaultValue: 1,
)
```

---

### Widget Extensions

#### ResponsiveVisibilityExtension

```dart
// Show/hide based on device type
Container().responsiveVisibility(
  phone: true,
  tablet: true,
  laptop: true,
  desktop: true,
  tv: true,
  replacement: SizedBox.shrink(), // Widget to show when hidden
)

// Device-specific padding
Container().responsivePadding(
  phone: EdgeInsets.all(8),
  tablet: EdgeInsets.all(16),
  laptop: EdgeInsets.all(24),
  desktop: EdgeInsets.all(32),
  all: EdgeInsets.all(16), // Default for all
)
```

#### Widget.responsiveBuilder Extension

```dart
Container().responsiveBuilder(
  mode: ResponsiveMode.layoutBuilder,
  builder: (context, data, child) {
    return Container(
      width: data.w(200),
      child: child,
    );
  },
)
```

---

### GetRealtimeResponsiveHelper

```dart
GetRealtimeResponsiveHelper.responsiveValue<int>(
  builder: (value) => GridView.count(crossAxisCount: value!),
  phone: 1,
  tablet: 2,
  laptop: 3,
  desktop: 4,
  tv: 5,
  defaultValue: 1,
  mode: ResponsiveMode.layoutBuilder,
)
```

---

### GetRealtimeResponsiveMixin

A mixin for creating custom responsive widgets.

```dart
class MyResponsiveWidget extends StatelessWidget 
    with GetRealtimeResponsiveMixin {
  
  @override
  ResponsiveMode get responsiveMode => ResponsiveMode.layoutBuilder;
  
  @override
  Widget buildResponsive(BuildContext context, ResponsiveData data) {
    return Container(
      width: data.w(200),
      height: data.h(100),
      child: Text(
        'Responsive',
        style: TextStyle(fontSize: data.sp(16)),
      ),
    );
  }
}
```

---

## 📏 Device Breakpoints

### Width-Based Breakpoints

| Device Type | Width Range | Base Dimensions |
|-------------|-------------|-----------------|
| Phone | < 600px | 375 × 812 |
| Tablet | 600px - 900px | 768 × 1024 |
| Laptop | 900px - 1200px | 1024 × 768 |
| Desktop | 1200px - 1920px | 1366 × 768 |
| TV | ≥ 1920px | 1920 × 1080 |

### Detection Logic

```dart
String _getDeviceType(double width, double height) {
  if (width >= 1920 || height >= 1080) {
    return 'tv';
  } else if (width >= 1200) {
    return 'desktop';
  } else if (width >= 900) {
    return 'laptop';
  } else if (width >= 600 || (width >= 500 && width / height > 1.2)) {
    return 'tablet';
  } else {
    return 'phone';
  }
}
```

### Scale Factors by Device

| Device | Text Scale | Widget Scale | Image Scale |
|--------|------------|--------------|-------------|
| Phone | 1.0 | 1.0 | 1.0 |
| Tablet | 1.15 | 1.2 | 1.3 |
| Laptop | 1.25 | 1.4 | 1.6 |
| Desktop | 1.4 | 1.8 | 2.2 |

### Clamp Ranges

| Device | Min | Max |
|--------|-----|-----|
| Phone | 0.8 | 1.3 |
| Tablet | 0.9 | 1.4 |
| Laptop | 0.9 | 1.5 |
| Desktop | 1.0 | 2.0 |

---

## ✅ Best Practices

### 1. Choose the Right Approach

```dart
// ✅ Use extensions for simple, static layouts
Container(
  width: 200.w,
  height: 100.h,
)

// ✅ Use GetResponsiveBuilder for complex, real-time layouts
GetResponsiveBuilder(
  builder: (context, data) {
    return data.responsiveValue<Widget>(
      phone: MobileLayout(),
      tablet: TabletLayout(),
      desktop: DesktopLayout(),
    );
  },
)

// ✅ Use responsive widgets for common patterns
GetResponsiveText('Hello', fontSize: 16)
```

### 2. Consistent Base Design

```dart
// ✅ Design for phone first (375 × 812)
// Then let the system scale up

// ❌ Don't mix different base assumptions
Container(
  width: 200.w,  // Based on 375 base
  height: 100,   // Fixed pixels - inconsistent!
)
```

### 3. Use Device-Specific Values Wisely

```dart
// ✅ Good: Different layouts for different devices
data.responsiveValue<Widget>(
  phone: SingleColumnLayout(),
  tablet: TwoColumnLayout(),
  desktop: ThreeColumnLayout(),
)

// ❌ Bad: Too many device-specific values
data.responsiveValue<double>(
  phone: 16,
  tablet: 17,
  laptop: 18,
  desktop: 19,
  tv: 20,
)
// Better: Use .sp for automatic scaling
```

### 4. Handle Orientation Changes

```dart
GetResponsiveBuilder(
  builder: (context, data) {
    if (data.isLandscape) {
      return LandscapeLayout();
    }
    return PortraitLayout();
  },
)
```

### 5. Fallback Handling

```dart
// The system automatically handles fallbacks
// But you can also provide explicit defaults
data.responsiveValue<int>(
  phone: 1,
  defaultValue: 2, // Used if device type not matched
)
```

---

## 📚 Examples

### Complete Responsive Page

```dart
class ResponsivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetResponsiveBuilder(
      builder: (context, data) {
        return Scaffold(
          appBar: AppBar(
            title: GetResponsiveText('My App', fontSize: 20),
            toolbarHeight: data.h(56),
          ),
          body: SingleChildScrollView(
            padding: data.responsiveInsetsAll(16),
            child: Column(
              children: [
                // Responsive hero section
                Container(
                  width: data.wp(100),
                  height: data.h(200),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: data.responsiveBorderRadiusCircular(16),
                  ),
                  child: Center(
                    child: Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: data.sp(32),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: data.h(24)),
                
                // Responsive grid
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: data.responsiveValue<int>(
                    phone: 2,
                    tablet: 3,
                    desktop: 4,
                  )!,
                  crossAxisSpacing: data.w(16),
                  mainAxisSpacing: data.h(16),
                  children: List.generate(8, (index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: data.responsiveBorderRadiusCircular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Item $index',
                          style: TextStyle(fontSize: data.sp(14)),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
```

### Responsive Navigation

```dart
GetResponsiveBuilder(
  builder: (context, data) {
    return Scaffold(
      // Bottom nav for phone, side nav for larger
      bottomNavigationBar: data.isPhone
          ? BottomNavigationBar(
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
              ],
            )
          : null,
      body: Row(
        children: [
          // Side navigation for tablet+
          if (!data.isPhone)
            NavigationRail(
              destinations: [
                NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home')),
                NavigationRailDestination(icon: Icon(Icons.search), label: Text('Search')),
                NavigationRailDestination(icon: Icon(Icons.person), label: Text('Profile')),
              ],
              selectedIndex: 0,
            ),
          
          // Main content
          Expanded(
            child: YourContent(),
          ),
        ],
      ),
    );
  },
)
```

### Responsive Form

```dart
GetResponsiveBuilder(
  builder: (context, data) {
    return Form(
      child: Padding(
        padding: data.responsiveInsetsSymmetric(
          horizontal: data.responsiveValue<double>(
            phone: 16,
            tablet: 48,
            desktop: 120,
          )!,
          vertical: 24,
        ),
        child: Column(
          children: [
            TextFormField(
              style: TextStyle(fontSize: data.sp(16)),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(fontSize: data.sp(14)),
                contentPadding: data.responsiveInsetsSymmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
            
            SizedBox(height: data.h(16)),
            
            TextFormField(
              style: TextStyle(fontSize: data.sp(16)),
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(fontSize: data.sp(14)),
                contentPadding: data.responsiveInsetsSymmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              obscureText: true,
            ),
            
            SizedBox(height: data.h(24)),
            
            GetResponsiveElevatedButton(
              onPressed: () {},
              width: data.responsiveValue<double>(
                phone: double.infinity,
                tablet: 300,
                desktop: 200,
              ),
              height: 50,
              child: Text('Login', style: TextStyle(fontSize: data.sp(16))),
            ),
          ],
        ),
      ),
    );
  },
)
```

---

## 🔄 Migration Guide

### From flutter_screenutil

```dart
// Before (flutter_screenutil)
Container(
  width: 200.w,
  height: 100.h,
  child: Text('Hello', style: TextStyle(fontSize: 16.sp)),
)

// After (GetX Master Responsive)
Container(
  width: 200.w,  // Same syntax!
  height: 100.h,
  child: Text('Hello', style: TextStyle(fontSize: 16.sp)),
)
```

### From MediaQuery

```dart
// Before (MediaQuery)
final width = MediaQuery.of(context).size.width;
final height = MediaQuery.of(context).size.height;
Container(
  width: width * 0.5,
  height: height * 0.3,
)

// After (GetX Master Responsive)
Container(
  width: 50.wp,  // 50% of width
  height: 30.hp, // 30% of height
)
```

### From LayoutBuilder

```dart
// Before (LayoutBuilder)
LayoutBuilder(
  builder: (context, constraints) {
    final width = constraints.maxWidth;
    return Container(width: width * 0.5);
  },
)

// After (GetX Master Responsive)
GetResponsiveBuilder(
  builder: (context, data) {
    return Container(width: data.wp(50));
  },
)
```

---

## ❓ FAQ

### Q: Do I need to initialize anything?

**A:** No! The system works out of the box. It uses GetX internally but has fallbacks if GetX is not initialized.

### Q: Which approach should I use?

**A:** 
- **Extensions** (`.w`, `.h`, `.sp`): For simple, static layouts
- **GetResponsiveBuilder**: For complex layouts with real-time updates
- **Responsive Widgets**: For common patterns like text, containers, icons

### Q: How do I handle orientation changes?

**A:** Use `GetResponsiveBuilder` with `ResponsiveMode.layoutBuilder` - it automatically updates on orientation changes.

### Q: Can I customize breakpoints?

**A:** The current version uses fixed breakpoints. Custom breakpoints may be added in future versions.

### Q: What happens if GetX is not initialized?

**A:** The system uses fallback values (375×667 base dimensions) to ensure your app doesn't crash.

### Q: How does font scaling work?

**A:** Font scaling uses a combination of:
1. Screen size ratio to base dimensions
2. Device-specific scale factors
3. Clamping to prevent extreme sizes
4. Pixel ratio adjustments for high-DPI screens

### Q: Is this compatible with web?

**A:** Yes! The system works on all Flutter platforms including web, with real-time resize support.

---

## 📄 License

This responsive system is part of GetX Master and is licensed under the MIT License.

---

## 🤝 Contributing

Contributions are welcome! Please read the contributing guidelines before submitting a pull request.

---

<p align="center">
  Made with ❤️ for the Flutter community
</p>
