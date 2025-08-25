# 🎨 Flutter Animation Library

A powerful and easy-to-use library for creating beautiful and smooth animations in Flutter with a simple and visual API.

## 📋 Table of Contents

- [Installation and Setup](#installation-and-setup)
- [Overview](#overview)
- [GetAnimatedBuilder](#getanimatedbuilder)
- [Animate Widget](#animate-widget)
- [Animation Extensions](#animation-extensions)
- [Practical Examples](#practical-examples)
- [Optimization Tips](#optimization-tips)
- [Troubleshooting](#troubleshooting)

## 🚀 Installation and Setup



### 2. Importing

```dart
import 'package:your_app/animations/animate.dart';
import 'package:your_app/animations/animations.dart';
```

## 🎯 Overview

This library consists of three main parts:

1. **GetAnimatedBuilder**: The core of the animation system
2. **Animate Widget**: A versatile widget for animations
3. **Animation Extensions**: Extension methods for a smooth API

## ⚙️ GetAnimatedBuilder

The core of the animation system that fully manages the animation lifecycle.

### Features

- ✅ **Automatic AnimationController management**
- ✅ **Delay support**
- ✅ **onStart and onComplete callbacks**
- ✅ **Hot Reload support**
- ✅ **Full Type Safety**
- ✅ **Optimized memory management**

### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `duration` | `Duration` | ✅ | Animation duration |
| `delay` | `Duration` | ✅ | Delay before start |
| `tween` | `Tween<T>` | ✅ | Range of changes |
| `idleValue` | `T` | ✅ | Value before start |
| `builder` | `ValueWidgetBuilder<T>` | ✅ | Widget builder |
| `child` | `Widget` | ✅ | Child widget |
| `curve` | `Curve` | ❌ | Animation curve |
| `onStart` | `ValueSetter<AnimationController>?` | ❌ | Start callback |
| `onComplete` | `ValueSetter<AnimationController>?` | ❌ | End callback |

### Usage Example

```dart
GetAnimatedBuilder<double>(
  duration: Duration(milliseconds: 500),
  delay: Duration(milliseconds: 200),
  tween: Tween<double>(begin: 0.0, end: 1.0),
  idleValue: 0.0,
  curve: Curves.easeInOut,
  onStart: (controller) => print('Animation started!'),
  onComplete: (controller) => print('Animation completed!'),
  builder: (context, value, child) {
    return Opacity(
      opacity: value,
      child: child,
    );
  },
  child: Text('Hello World!'),
)
```

## 🎭 Animate Widget

A versatile widget for applying various predefined animations.

### Animation Types (AnimationType)

#### 🌟 Basic Animations

| Type | Description | Example |
|------|-------------|---------|
| `fadeIn` | Fade in | Opacity from 0 to 1 |
| `fadeOut` | Fade out | Opacity from 1 to 0 |
| `scale` | Change size | From small to large |
| `rotate` | Rotation | 360-degree rotation |

#### 🎪 Advanced Animations

| Type | Description | Special Parameters |
|------|-------------|-------------------|
| `bounce` | Bounce and jump | curve: `Curves.bounceInOut` |
| `elastic` | Elastic | Custom elastic calculation |
| `shake` | Shake | Sinusoidal movement |
| `wobble` | Wobble | Slight rotation |
| `wave` | Wave | Vertical wave movement |

#### 📱 Slide Animations

| Type | Direction | Usage |
|------|-----------|-------|
| `slideInLeft` | Left to right | Entry from the side |
| `slideInRight` | Right to left | Entry from the side |
| `slideInUp` | Bottom to top | Entry from the bottom |
| `slideInDown` | Top to bottom | Entry from the top |
| `slideOutLeft` | Exit to the left | Exit from the side |
| `slideOutRight` | Exit to the right | Exit from the side |
| `slideOutUp` | Exit to the top | Exit from the top |
| `slideOutDown` | Exit to the bottom | Exit from the bottom |

#### 🎨 Special Animations

| Type | Description | Requirements |
|------|-------------|--------------|
| `blur` | Blur | `BackdropFilter` |
| `flip` | 3D rotation | Matrix4 transformation |
| `zoom` | Zoom | Scale change |
| `color` | Color change | `beginColor`, `endColor` |

### Factory Constructors

```dart
// Fade In
Animate.fadeIn(
  duration: Duration(seconds: 1),
  child: myWidget,
)

// Slide In
Animate.slideIn(
  duration: Duration(milliseconds: 600),
  direction: SlideDirection.left,
  customOffset: 200,
  child: myWidget,
)

// Scale
Animate.scale(
  duration: Duration(milliseconds: 800),
  begin: 0.5,
  end: 1.2,
  curve: Curves.elasticOut,
  child: myWidget,
)
```

### Complete Example

```dart
class AnimatedCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Animate(
      duration: Duration(milliseconds: 800),
      type: AnimationType.slideInLeft,
      customOffset: 100,
      curve: Curves.easeOutBack,
      onStart: (controller) {
        print('Card animation started');
      },
      onComplete: (controller) {
        print('Card animation completed');
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Text('Animated Card'),
        ),
      ),
    );
  }
}
```

## 🔗 Animation Extensions

Extension methods for easily applying animations with a smooth and chainable API.

### Common Parameters

```dart
Duration duration = Duration(seconds: 2) // Animation duration
Duration delay = Duration.zero // Delay
ValueSetter<AnimationController>? onComplete // End callback
bool isSequential = false // Sequential execution
```

### Basic Animations

```dart
// Fade
myWidget.fadeIn(duration: Duration(seconds: 1))
myWidget.fadeOut(duration: Duration(seconds: 1))

// Scale
myWidget.scale(
  begin: 0.8,
  end: 1.2,
  duration: Duration(milliseconds: 600),
)

// Rotate (turns)
myWidget.rotate(
  begin: 0.0, // Start
  end: 1.0, // One full turn
  duration: Duration(seconds: 2),
)

// Spin (full rotation)
myWidget.spin(duration: Duration(seconds: 1))
```

### Slide with SlideType

```dart
enum SlideType {
  left, // From left
  right, // From right
  top, // From top
  bottom, // From bottom
}

// Usage
myWidget.slideIn(
  type: SlideType.left,
  distance: 100.0,
  duration: Duration(milliseconds: 500),
)

myWidget.slideOut(
  type: SlideType.right,
  distance: 200.0,
  duration: Duration(milliseconds: 400),
)
```

### Special Animations

```dart
// Bounce
myWidget.bounce(
  begin: 1.0,
  end: 1.3,
  duration: Duration(milliseconds: 800),
)

// Blur
myWidget.blur(
  begin: 0.0,
  end: 10.0,
  duration: Duration(milliseconds: 1000),
)

// Flip
myWidget.flip(duration: Duration(milliseconds: 600))

// Wave
myWidget.wave(duration: Duration(seconds: 2))
```

### Sequential Animations

```dart
myWidget
  .fadeIn(
    duration: Duration(milliseconds: 500),
  )
  .slideIn(
    type: SlideType.left,
    duration: Duration(milliseconds: 600),
    isSequential: true, // Execute after fadeIn
  )
  .bounce(
    begin: 1.0,
    end: 1.1,
    duration: Duration(milliseconds: 300),
    isSequential: true, // Execute after slideIn
  );
```

## 💡 Practical Examples

### 1. Loading Animation

```dart
class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.refresh, size: 50)
            .spin(duration: Duration(seconds: 2)),

          SizedBox(height: 20),

          Text('Loading...')
            .fadeIn(duration: Duration(milliseconds: 800))
            .bounce(
              begin: 1.0,
              end: 1.1,
              duration: Duration(milliseconds: 500),
              isSequential: true,
            ),
        ],
      ),
    );
  }
}
```

### 2. Card List Animation

```dart
class AnimatedCardList extends StatelessWidget {
  final List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            title: Text(items[index]),
          ),
        )
        .fadeIn(
          duration: Duration(milliseconds: 600),
          delay: Duration(milliseconds: index * 100), // Staggered delay
        )
        .slideIn(
          type: SlideType.left,
          duration: Duration(milliseconds: 500),
          distance: 50,
          isSequential: true,
        );
      },
    );
  }
}
```

### 3. Button Interactions

```dart
class AnimatedButton extends StatefulWidget {
  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: _isPressed ? Colors.blue[700] : Colors.blue,
          borderRadius: BorderRadius.circular(8),
          boxShadow: _isPressed ? [] : [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          'Tap Me!',
          style: TextStyle(color: Colors.white),
        ),
      ),
    )
    .scale(
      begin: 1.0,
      end: _isPressed ? 0.95 : 1.0,
      duration: Duration(milliseconds: 100),
    );
  }
}
```

### 4. Page Transitions

```dart
class PageTransitionExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Welcome!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            )
            .slideIn(
              type: SlideType.top,
              duration: Duration(milliseconds: 600),
            ),

            // Content
            Expanded(
              child: Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text('Content goes here...'),
                    // ... more content
                  ],
                ),
              )
              .fadeIn(duration: Duration(milliseconds: 800))
              .scale(
                begin: 0.9,
                end: 1.0,
                duration: Duration(milliseconds: 600),
                isSequential: true,
              ),
            ),

            // Bottom Button
            Padding(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Get Started'),
              ),
            )
            .slideIn(
              type: SlideType.bottom,
              duration: Duration(milliseconds: 500),
              delay: Duration(milliseconds: 400),
            ),
          ],
        ),
      ),
    );
  }
}
```

## ⚡ Optimization Tips

### 1. Memory Management

```dart
// ✅ Correct - Using const
const Animate(
  duration: Duration(milliseconds: 500),
  type: AnimationType.fadeIn,
  child: Text('Static text'),
)

// ❌ Incorrect - Creating new object in each build
Animate(
  duration: Duration(milliseconds: 500),
  type: AnimationType.fadeIn,
  child: Text('Dynamic: ${DateTime.now()}'),
)
```

### 2. Choosing the Right Curve

```dart
// For UI elements
curve: Curves.easeInOut

// For attention-seeking animations
curve: Curves.bounceIn

// For natural movements
curve: Curves.decelerate

// For playful interactions
curve: Curves.elasticOut
```

### 3. Setting Duration

```dart
// Quick micro-interactions
duration: Duration(milliseconds: 150-300)

// Standard UI transitions
duration: Duration(milliseconds: 300-500)

// Attention-grabbing animations
duration: Duration(milliseconds: 500-1000)

// Background/ambient animations
duration: Duration(seconds: 2-5)
```

### 4. Using isSequential

```dart
// ✅ Correct - For sequential animations
myWidget
  .fadeIn(duration: Duration(milliseconds: 300))
  .slideIn(
    type: SlideType.left,
    isSequential: true, // Waits for fadeIn to finish
    duration: Duration(milliseconds: 400),
  )

// ❌ Incorrect - Inappropriate simultaneous animations
myWidget
  .fadeIn(duration: Duration(milliseconds: 300))
  .slideIn(
    type: SlideType.left,
    isSequential: false, // Executes simultaneously
    duration: Duration(milliseconds: 400),
  )
```

## 🔧 Troubleshooting

### Common Issues

#### 1. Animation Not Running

```dart
// Ensure the widget is mounted
if (mounted) {
  controller.forward();
}

// Ensure duration > 0
duration: Duration(milliseconds: 100) // Minimum
```

#### 2. Memory Leak

```dart
// Always dispose
@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
```

#### 3. Sequential Animations Not Working

```dart
// Ensure isSequential: true
myWidget
  .fadeIn(duration: Duration(milliseconds: 500))
  .slideIn(
    isSequential: true, // Here!
    type: SlideType.left,
    duration: Duration(milliseconds: 400),
  )
```

#### 4. Poor Performance

```dart
// Use AnimatedBuilder instead of setState
// The library automatically does this
// Make widgets const
const Text('Static content')

// Use RepaintBoundary
RepaintBoundary(
  child: myAnimatedWidget,
)
```

### Debug Mode

```dart
// For debugging animations
GetAnimatedBuilder(
  // ... other params
  onStart: (controller) {
    debugPrint('Animation started: ${controller.status}');
  },
  onComplete: (controller) {
    debugPrint('Animation completed: ${controller.status}');
  },
  // ...
)
```

## 🎉 Conclusion

This Flutter Animation Library is a powerful and flexible tool for creating beautiful and professional animations. With a simple API and advanced features, you can easily create visually appealing user experiences.

### Key Features:

- 🎯 **Simple and Visual API**
- ⚡ **High Performance and Optimized**
- 🔧 **Customizable and Flexible**
- 🛡️ **Type Safe and Stable**
- 🔄 **Full Hot Reload Support**
- 📱 **Compatible with All Flutter Platforms**

