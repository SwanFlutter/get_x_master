# 📱 GetX Master Responsive Design

The most comprehensive responsive design system for Flutter, providing pixel-perfect adaptations across all devices (Mobile, Tablet, Desktop, TV).

## 🚀 Key Features

- **Unified API**: Access all responsive features through `GetResponsiveBuilder` and `ResponsiveData`
- **Context-Free**: No `BuildContext` required for responsive calculations (extensions)
- **Real-Time Updates**: UI adapts instantly when window is resized
- **Percentage-Based Sizing**: Use `.wp` and `.hp` for relative sizing
- **Pixel-to-Responsive**: Convert design pixels to responsive units with `.w` and `.h`
- **Smart Font Scaling**: Text scales intelligently across devices with `.sp`, `.ssp`, and `.hsp`
- **Device Detection**: Automatic detection of device type (Phone, Tablet, Laptop, Desktop, TV)
- **Responsive Widgets**: Ready-to-use widgets that handle responsiveness automatically

## 📦 Usage

### 1. Unified Responsive API (Recommended)

The most powerful way to build responsive UIs in GetX Master is using `GetResponsiveBuilder`. It provides a `data` object that gives you access to all responsive utilities in one place, ensuring your UI updates in real-time.

```dart
GetResponsiveBuilder(
  builder: (context, data) {
    return Container(
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
      child: data.responsiveValue(
        phone: Text('Mobile View', style: TextStyle(fontSize: data.sp(14))),
        tablet: Text('Tablet View', style: TextStyle(fontSize: data.sp(16))),
        desktop: Text('Desktop View', style: TextStyle(fontSize: data.sp(20))),
      ),
    );
  },
)
```

### 2. Responsive Extensions (Context-Free)

For quick conversions anywhere in your app (even outside widgets), use the direct extensions:

```dart
// Width & Height
double width = 100.w;    // 100px adapted to screen width
double height = 50.h;    // 50px adapted to screen height

// Percentage
double widthPct = 50.wp; // 50% of screen width
double heightPct = 30.hp;// 30% of screen height

// Font Size
double fontSize = 16.sp; // 16px adapted to screen size

// Widget Size (Icons, etc.)
double iconSize = 24.ws; // 24px adapted for widgets
double imgSize = 100.imgSize; // Adapted image size
```

### 3. Device-Specific Values

Easily define different values for different device types:

```dart
// Using Unified API (inside GetResponsiveBuilder)
final columns = data.responsiveValue<int>(
  phone: 1,
  tablet: 2,
  laptop: 3,
  desktop: 4,
);

// Using Extensions
Widget widget = Container().responsiveVisibility(
  phone: false,    // Hide on phone
  tablet: true,    // Show on tablet
  desktop: true,   // Show on desktop
);

Widget padded = Container().responsivePadding(
  phone: EdgeInsets.all(8),
  tablet: EdgeInsets.all(16),
  desktop: EdgeInsets.all(24),
);
```

### 4. Device Type Detection

Access device information globally:

```dart
bool isPhone = GetResponsiveHelper.isPhone;
bool isTablet = GetResponsiveHelper.isTablet;
bool isDesktop = GetResponsiveHelper.isDesktop;
bool isLandscape = GetResponsiveHelper.isLandscape;

// Get detailed screen info
Map<String, dynamic> info = GetResponsiveHelper.screenInfo;
```

## 🛠️ ResponsiveData API Reference

When using `GetResponsiveBuilder`, the `data` object provides:

### Sizing Methods
- `w(double)`: Responsive width
- `h(double)`: Responsive height
- `sp(double)`: Responsive font size
- `ssp(double)`: Scalable font size (enhanced)
- `hsp(double)`: Header font size (enhanced)
- `ws(double)`: Widget size
- `imgSize(double)`: Image size
- `widthPercent(double)`: % of current width
- `heightPercent(double)`: % of current height

### Helper Methods
- `responsiveValue(...)`: Return different values based on device
- `responsiveInsets(...)`: Responsive EdgeInsets
- `responsiveInsetsAll(double)`: Responsive EdgeInsets.all
- `responsiveBorderRadius(...)`: Responsive BorderRadius
- `responsiveBorderRadiusCircular(double)`: Responsive BorderRadius.circular

### Device Properties
- `isPhone`, `isTablet`, `isLaptop`, `isDesktop`, `isTv`
- `isLandscape`, `isPortrait`
- `width`, `height`, `aspectRatio`, `pixelRatio`

## 🔧 Configuration

The system uses default breakpoints and base dimensions that work for most apps, but you can customize them:

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
