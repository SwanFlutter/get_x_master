
# Animation Library Documentation

This library provides a set of Flutter widgets and extensions for creating various animations easily. It consists of three main files:

1.  **`animate.dart`**: Contains the `Animate` widget, a versatile widget for applying different animation types.
2.  **`animations.dart`**: Provides extension methods on `Widget` for a fluent animation API.
3.  **`get_animated_builder.dart`**:  A generic animated builder that handles the animation lifecycle (controller, animation, status updates).

## 1. `animate.dart`

This file defines the `Animate` widget and the `AnimationType` enum.

### `Animate` Widget

The `Animate` widget is a general-purpose animation widget that allows you to apply different animation types to its child widget.  It uses `GetAnimatedBuilder` internally to manage the animation.

**Constructor:**

```dart
const Animate({
  super.key,
  required this.duration,
  this.delay,
  required this.child,
  this.onComplete,
  required this.type,
  this.begin = 0.0,
  this.end = 1.0,
  this.curve = Curves.linear,
});
```

**Parameters:**

*   **`duration`** (required, `Duration`):  The length of time the animation should take.
*   **`delay`** (optional, `Duration`):  The amount of time to wait before starting the animation.  Defaults to zero (no delay).
*   **`child`** (required, `Widget`): The widget to which the animation will be applied.
*   **`onComplete`** (optional, `ValueSetter<AnimationController>`): A callback function that's called when the animation completes.  It receives the `AnimationController` as an argument.
*   **`type`** (required, `AnimationType`): The type of animation to apply (see the `AnimationType` enum below).
*   **`begin`** (optional, `double`): The starting value of the animation. Defaults to 0.0. The type can change based on the animation type
*   **`end`** (optional, `double`): The ending value of the animation. Defaults to 1.0. The type can change based on the animation type
*   **`curve`** (optional, `Curve`): The curve to use for the animation. Defaults to `Curves.linear`.

**`AnimationType` Enum:**

Defines the available animation types:

*   `fadeIn`:  Fades the child in (from transparent to opaque).
*   `fadeOut`: Fades the child out (from opaque to transparent).
*   `rotate`: Rotates the child.
*   `scale`:  Scales the child.
*   `bounce`: Applies a bounce effect (similar to scaling with a bounce curve).
*   `spin`:  Continuously rotates the child (360 degrees).
*   `size`: Animates the size of the child (effectively a scale animation).
*   `blur`: Applies a blur effect to the child.
*   `flip`:  Flips the child (3D rotation around the Y-axis).
*   `wave`:  Moves the child up and down in a wave-like motion.
    *   `wobble`:  Applies a wobble effect, a slight rotational distortion.
*   `slideInLeft`: Slides the child in from the left.
*   `slideInRight`: Slides the child in from the right.
*   `slideInUp`: Slides the child in from the bottom.
*   `slideInDown`: Slides the child in from the top.
*   `zoom`: Zooms in or out on the child, starting from scale 1.
    *`color`: colors begin and end

**Example Usage:**

```dart
// Fade-in animation
Animate(
  duration: Duration(seconds: 2),
  type: AnimationType.fadeIn,
  child: Text('Hello, world!'),
)

// Rotate animation
Animate(
  duration: Duration(seconds: 1),
  type: AnimationType.rotate,
  begin: 0.0, // Start at 0 radians
  end: 2.0,   // End at 4π radians (two full rotations)
  child: Icon(Icons.refresh),
)

// Slide-in from left animation
Animate(
  duration: Duration(milliseconds: 500),
);
```

--- 

# Flutter Animations Documentation



## Core Concept: `GetAnimatedBuilder`

All animations in this library extend `GetAnimatedBuilder<T>`, which itself is a generic class that uses flutter `AnimatedBuilder`.  It handles the animation lifecycle, value updates, and rebuilding of the widget tree.  You don't interact with `GetAnimatedBuilder` directly, but understanding its role is important:

*   **`tween`**: Defines the range of values the animation will produce (e.g., from 0.0 to 1.0 for opacity).
*   **`builder`**: A function that's called every time the animation value changes.  It receives the current animation value and the child widget, and it returns the *transformed* widget (e.g., a widget with adjusted opacity, scale, or position).
*   **`duration`**:  How long the animation takes to complete.
*   **`delay`**:  How long to wait before starting the animation.
*   **`onComplete`**:  A callback function that's executed when the animation finishes.
*  **`idleValue`**: The value of tween when the animation is not active.
*   **`curve`**: An optional parameter to specify the animation curve, influencing the rate of change over time (e.g., `Curves.easeOut`, `Curves.bounceIn`).

## Available Animations

The following animation widgets are provided, each with specific parameters and usage examples:

### 1. `OpacityAnimation`

Changes the opacity of a widget.

*   **`begin`**:  Starting opacity (0.0 = transparent, 1.0 = opaque).
*   **`end`**: Ending opacity.
* **`idleValue`**: Default value of opacity for the animation.

```dart
OpacityAnimation(
  duration: const Duration(seconds: 1),
  delay: const Duration(milliseconds: 500),
  begin: 0.0,
  end: 1.0,
  idleValue: 0,
  child: Container(
    width: 100,
    height: 100,
    color: Colors.blue,
    width: 200,
    height: 200,
))

// color animation
Animate(
    duration: const Duration(seconds: 1),
    type: AnimationType.color,
    begin: Colors.red,
    end: Colors.green,
    child: Container(
    color: Colors.blue,
    width: 200,
    height: 200,
))
```



---




## 2. `animations.dart`

This file provides extension methods on the `Widget` class, allowing you to apply animations using a fluent style.

**Extension Methods:**

All extension methods return a `GetAnimatedBuilder` instance, allowing for chaining of animations.  They all share similar parameters:

*   **`duration`** (optional, `Duration`):  The duration of the animation. Defaults to 2 seconds (`_defaultDuration`).
*   **`delay`** (optional, `Duration`):  The delay before the animation starts. Defaults to 0 seconds (`_defaultDelay`).
*   **`onComplete`** (optional, `ValueSetter<AnimationController>`): A callback called when the animation completes.
*   **`isSequential`** (optional, `bool`):  If `true`, the animation will start *after* any previous animation on the same widget has finished. Defaults to `false`.
*   **`begin`** begin value for the animation
*   **`end`** end value for the animation

**Available Extension Methods:**

*   **`fadeIn(...)`**:  Fades the widget in.
*   **`fadeOut(...)`**: Fades the widget out.
*   **`rotate({required double begin, required double end, ...})`**: Rotates the widget.  `begin` and `end` specify the start and end rotation in *turns* (0 to 1 is a full rotation).
*   **`scale({required double begin, required double end, ...})`**:  Scales the widget. `begin` and `end` specify the start and end scale factors.
*   **`slide({required OffsetBuilder offset, double begin = 0, double end = 1, ...})`**: Slides the widget.  `offset` is a function that takes the `BuildContext` and the animation value (0.0 to 1.0) and returns an `Offset`.
*   **`bounce({required double begin, required double end, ...})`**: Applies a bounce effect (scales with a `Curves.bounceInOut` curve).
*   **`spin(...)`**: Rotates the widget a full 360 degrees.
*   **`size({required double begin, required double end, ...})`**: Animates the size of the widget (effectively a scale animation).
*   **`blur({double begin = 0, double end = 15, ...})`**:  Applies a blur effect.
*   **`flip({double begin = 0, double end = 1, ...})`**: Flips the widget.
*   **`wave({double begin = 0, double end = 1, ...})`**:  Creates a vertical wave-like motion.
*   **`wobble(...)`**:  A wobble effect, a slight rotational distortion.

**`_getDelay(bool isSequential, Duration delay)`:**

*   A private helper method to calculate the delay.  If `isSequential` is true, it adds the total duration of any preceding animation (obtained via `_currentAnimation`) to the given `delay`.
    *   Asserts that if a delay is manually specified, sequential animation is not used

**Example Usage:**

```dart
// Fade-in and then scale up
Text('Animated Text')
  .fadeIn(duration: Duration(seconds: 1))
  .scale(begin: 1.0, end: 2.0, duration: Duration(seconds: 1), isSequential: true);

// Slide in from the left
Container(width: 100, height: 100, color: Colors.red)
  .slide(offset: (context, value) => Offset(-value, 0));

// Bounce
Icon(Icons.star)
  .bounce(begin: 0.5, end: 1.5);

// Spin, then fade out sequentially
Icon(Icons.autorenew)
  .spin(duration: Duration(seconds: 1))
  .fadeOut(duration: Duration(seconds: 1), isSequential: true);
  
//Example of wobble

Text("Wobble")
    .wobble(begin: 0, end: 2)
```



---



## 3. `get_animated_builder.dart`

This file defines the `GetAnimatedBuilder` widget, which is the core of the animation system.  It handles creating and managing the `AnimationController` and `Animation`, and rebuilding the widget tree based on the animation's value.

**`GetAnimatedBuilder<T>` Widget:**

A generic widget that builds its child based on the value of an animation.

**Constructor:**

```dart
const GetAnimatedBuilder({
  super.key,
  this.curve = Curves.linear,
  this.onComplete,
  this.onStart, // Added onStart
  required this.duration,
  required this.tween,
  required this.idleValue, // Now required
  required this.builder,
  required this.child,
  required this.delay,
});
```

**Parameters:**

*   **`duration`** (required, `Duration`): The duration of the animation.
*   **`delay`** (required, `Duration`): The delay before the animation starts.
*   **`child`** (required, `Widget`): The child widget.
*   **`onComplete`** (optional, `ValueSetter<AnimationController>`): Callback when the animation completes.
*    **`onStart`** (optional, `ValueSetter<AnimationController>`): Optional onStart callback
*   **`tween`** (required, `Tween<T>`): The tween that defines the range of the animation.
*   **`idleValue`** (required, `T`):  The value to use when the animation hasn't started yet (before the delay).
*   **`builder`** (required, `ValueWidgetBuilder<T>`): A function that builds the widget tree based on the current animation value. It takes the `BuildContext`, the animation value (`T`), and the `child` widget as arguments.
*   **`curve`** (optional, `Curve`): The animation curve. Defaults to `Curves.linear`.

**`GetAnimatedBuilderState<T>` Class:**

The state class for `GetAnimatedBuilder`.

*   **`_controller`**:  The `AnimationController` that drives the animation.
*   **`_animation`**: The `Animation<T>` object, created from the `tween` and the `controller`.
*   **`_wasStarted`**:  A boolean flag indicating whether the animation has started (after the delay).
*    **`_idleValue`**: The value to use when the animation hasn't started
*   **`_listener(AnimationStatus status)`**:  A listener attached to the `AnimationController`'s status.  It calls `onComplete` when the animation finishes.
*   **`initState()`**: Initializes the `AnimationController`, adds the status listener, creates the `Animation`, and starts the animation after the specified `delay`.
*   **`didUpdateWidget(...)`**:  Handles changes to the widget's properties (duration, delay, tween, curve) during hot reload.  It restarts the animation if any of these change.
*   **`dispose()`**:  Removes the status listener and disposes of the `AnimationController`.
*   **`build(...)`**: Builds the widget tree using the provided `builder` function, passing in the current animation value (or the `idleValue` if the animation hasn't started). Uses an `AnimatedBuilder` internally.

**Example (Internal Use):**

`GetAnimatedBuilder` is used internally by `Animate` and the extension methods. Here's a simplified example of how it's used within `fadeIn`:

```dart
// Inside animations.dart, simplified fadeIn implementation
GetAnimatedBuilder<double>(
  duration: duration,
  delay: delay,
  tween: Tween<double>(begin: 0.0, end: 1.0),
  idleValue: 0.0, // Start transparent
  builder: (context, value, child) => Opacity(opacity: value, child: child),
  child: this, // 'this' refers to the widget the extension method is called on
);
```

## Key Improvements and Explanations:

*   **Comprehensive Documentation:**  Provides clear explanations of each class, method, and parameter, including examples.
*   **`idleValue`:** The `GetAnimatedBuilder` now *requires* an `idleValue`. This is crucial for correctly handling the state *before* the animation starts (after the delay).  Without it, the widget might briefly show the "end" state of the animation before the delay is over.
*   **Generic Type `T`:**  `GetAnimatedBuilder` is generic (`<T>`), making it type-safe and flexible for different animation types (e.g., `double`, `Offset`, `Color`).
*    **`onStart` added:** `GetAnimatedBuilder` has onStart callback
*   **Sequential Animations:**  The `isSequential` flag and the `_getDelay` method in `animations.dart` correctly handle sequential animations.  The delay of a sequential animation is calculated by adding the total duration of the *previous* animation on the same widget.
* **Error Handling**: Asserts are used to help users of the animation extension to specify correct parameters.
*   **Hot Reload Support:**  `GetAnimatedBuilder`'s `didUpdateWidget` method correctly handles changes to animation parameters during hot reload, restarting the animation as needed.
*   **Fluent API:**  The extension methods in `animations.dart` make it very easy to chain animations together.
*   **`OffsetBuilder` Typedef:** Added type alias for Offset function.
*  **Internal workings of** `GetAnimatedBuilder` are described.

This comprehensive documentation and the improved code provide a robust and easy-to-use animation library for Flutter developers. The examples demonstrate various animation types and how to combine them. The use of `GetAnimatedBuilder` ensures proper animation management, and the extension methods provide a clean and concise API.
