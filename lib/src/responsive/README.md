# 📱 GetX Master Responsive Design

The most comprehensive responsive design system for Flutter, providing pixel-perfect adaptations across all devices (Mobile, Tablet, Desktop, TV).

## 🚀 Key Features

- **Context-Free**: No `BuildContext` required for responsive calculations
- **Real-Time Updates**: UI adapts instantly when window is resized
- **Percentage-Based Sizing**: Use `.wp` and `.hp` for relative sizing
- **Pixel-to-Responsive**: Convert design pixels to responsive units with `.w` and `.h`
- **Smart Font Scaling**: Text scales intelligently across devices with `.sp`
- **Device Detection**: Automatic detection of device type (Phone, Tablet, Laptop, Desktop, TV)
- **Responsive Widgets**: Ready-to-use widgets that handle responsiveness automatically

## 📦 Usage

### 1. Basic Extensions

Convert your design values to responsive values effortlessly:

```dart
// Width & Height
Container(
  width: 100.w,    // 100px adapted to screen width
  height: 50.h,    // 50px adapted to screen height
);

// Percentage
Container(
  width: 50.wp,    // 50% of screen width
  height: 30.hp,   // 30% of screen height
);

// Font Size
Text(
  'Responsive Text',
  style: TextStyle(fontSize: 16.sp), // 16px adapted to screen size
);

// Widget Size (Icons, etc.)
Icon(
  Icons.home,
  size: 24.ws, // 24px adapted for widgets
);
```

### 2. Responsive Widgets

GetX Master provides a suite of widgets that handle responsiveness for you. These widgets support different responsive modes (LayoutBuilder, MediaQuery, etc.).

#### GetResponsiveContainer
A container that automatically adapts its dimensions and padding.

```dart
GetResponsiveContainer(
  width: 200, // Will be converted to responsive width
  height: 100, // Will be converted to responsive height
  padding: EdgeInsets.all(16), // Padding also becomes responsive
  child: Text('Content'),
)
```

#### GetResponsiveText
Text that scales automatically.

```dart
GetResponsiveText(
  'Hello World',
  fontSize: 16, // Will be converted to 16.sp
)
```

#### GetResponsiveIcon
Icons that scale appropriately.

```dart
GetResponsiveIcon(
  Icons.star,
  size: 24, // Will be converted to 24.ws
)
```

#### GetResponsiveElevatedButton
Buttons with responsive sizing.

```dart
GetResponsiveElevatedButton(
  width: 200,
  height: 50,
  onPressed: () {},
  child: Text('Click Me'),
)
```

### 3. Responsive Builder

For more complex layouts that need to change structure based on device type:

```dart
GetResponsiveBuilder(
  builder: (context, data) {
    if (data.isDesktop) {
      return DesktopLayout();
    } else if (data.isTablet) {
      return TabletLayout();
    } else {
      return MobileLayout();
    }
  },
)
```

### 4. Device Type Detection

Access device information anywhere:

```dart
bool isPhone = GetResponsiveHelper.isPhone;
bool isTablet = GetResponsiveHelper.isTablet;
bool isDesktop = GetResponsiveHelper.isDesktop;

// Get specific device type
String type = GetResponsiveHelper.deviceType; // 'phone', 'tablet', 'laptop', 'desktop', 'tv'
```

## 🔧 Configuration

The system automatically detects the device type and sets appropriate base dimensions. However, you can customize the behavior if needed by modifying the `GetResponsiveHelper` configuration (advanced usage).

### Default Breakpoints

- **Phone**: < 600px
- **Tablet**: 600px - 1200px
- **Laptop**: 1200px - 1920px
- **Desktop/TV**: > 1920px

### Base Dimensions (Design Size)

- **Phone**: 375 x 812
- **Tablet**: 768 x 1024
- **Laptop**: 1366 x 768
- **Desktop**: 1920 x 1080
