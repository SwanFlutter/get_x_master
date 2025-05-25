# Enhanced GetBuilder Guide

This guide explains the new enhanced widgets and extensions added to GetX for better state management and reactive programming.

## New Features

### 1. GetBuilderObs - Enhanced GetBuilder with Observable Support

`GetBuilderObs` combines the power of `GetBuilder` with `Obx`-like reactive capabilities, allowing you to observe multiple reactive variables while still having access to your controller.

#### Features:
- ✅ Access to controller instance (like GetBuilder)
- ✅ Observe multiple reactive variables (like Obx)
- ✅ Automatic lifecycle management
- ✅ Smart controller initialization
- ✅ Filter support

#### Basic Usage:

```dart
class MyController extends GetxController {
  final RxInt count = 0.obs;
  final RxString message = 'Hello'.obs;
  final RxBool isLoading = false.obs;
  
  void increment() {
    count.value++;
    message.value = 'Count: ${count.value}';
  }
}

// Usage in widget
GetBuilderObs<MyController>(
  init: MyController(),
  observables: [
    Get.find<MyController>().count,
    Get.find<MyController>().message,
    Get.find<MyController>().isLoading,
  ],
  builder: (controller) {
    return Column(
      children: [
        Text('Count: ${controller.count.value}'),
        Text(controller.message.value),
        if (controller.isLoading.value)
          CircularProgressIndicator(),
        ElevatedButton(
          onPressed: controller.increment,
          child: Text('Increment'),
        ),
      ],
    );
  },
)
```

#### Advanced Usage with Filter:

```dart
GetBuilderObs<MyController>(
  init: MyController(),
  observables: [controller.count, controller.message],
  filter: (controller) => controller.count.value, // Only rebuild when count changes
  builder: (controller) {
    return Text('Filtered Count: ${controller.count.value}');
  },
)
```

### 2. MultiObx - Multiple Observable Watcher

`MultiObx` allows you to watch multiple reactive variables without needing a controller.

#### Features:
- ✅ Watch multiple observables
- ✅ No controller required
- ✅ Lightweight and efficient
- ✅ Perfect for simple reactive UIs

#### Usage:

```dart
// Create standalone reactive variables
final RxString title = 'Hello'.obs;
final RxInt counter = 0.obs;
final RxBool isDarkMode = false.obs;

MultiObx(
  observables: [title, counter, isDarkMode],
  builder: () {
    return Column(
      children: [
        Text(title.value),
        Text('Counter: ${counter.value}'),
        Switch(
          value: isDarkMode.value,
          onChanged: (value) => isDarkMode.value = value,
        ),
      ],
    );
  },
)
```

### 3. Enhanced BuildContext Extensions

New extensions for `BuildContext` that provide easy access to GetX controllers and utilities.

#### Controller Access:

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Find controller
    final controller = context.find<MyController>();
    
    // Find controller safely (returns null if not found)
    final safeController = context.findOrNull<MyController>();
    
    // Check if controller is registered
    final isRegistered = context.isControllerRegistered<MyController>();
    
    // Observe controller (use within Obx or GetX widget)
    final observedController = context.obs<MyController>();
    
    return YourWidget();
  }
}
```

#### Navigation and UI Utilities:

```dart
// Show snackbar
context.showSnackbar('Hello World!');

// Navigate to page
context.push(NextPage());

// Go back
context.pop();
```

## Comparison with Existing Widgets

### GetBuilder vs GetBuilderObs

| Feature | GetBuilder | GetBuilderObs |
|---------|------------|---------------|
| Controller Access | ✅ | ✅ |
| Manual Updates | ✅ | ✅ |
| Reactive Variables | ❌ | ✅ |
| Multiple Observables | ❌ | ✅ |
| Performance | High | High |

### Obx vs MultiObx

| Feature | Obx | MultiObx |
|---------|-----|----------|
| Single Observable | ✅ | ✅ |
| Multiple Observables | Manual | ✅ |
| Controller Access | ❌ | ❌ |
| Simplicity | High | High |

## Best Practices

### 1. When to Use GetBuilderObs

Use `GetBuilderObs` when:
- You need both controller methods and reactive variables
- You want to observe multiple reactive variables
- You need complex state management with filters
- You want the benefits of both GetBuilder and Obx

```dart
// Good use case: Complex form with validation
GetBuilderObs<FormController>(
  observables: [
    controller.email,
    controller.password,
    controller.isValid,
    controller.isSubmitting,
  ],
  builder: (controller) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            onChanged: controller.setEmail,
            decoration: InputDecoration(
              errorText: controller.emailError.value,
            ),
          ),
          TextFormField(
            onChanged: controller.setPassword,
            obscureText: true,
            decoration: InputDecoration(
              errorText: controller.passwordError.value,
            ),
          ),
          ElevatedButton(
            onPressed: controller.isValid.value ? controller.submit : null,
            child: controller.isSubmitting.value
                ? CircularProgressIndicator()
                : Text('Submit'),
          ),
        ],
      ),
    );
  },
)
```

### 2. When to Use MultiObx

Use `MultiObx` when:
- You have simple reactive variables without a controller
- You want to watch multiple observables in a lightweight way
- You're building simple reactive UIs

```dart
// Good use case: Simple settings panel
final RxBool notifications = true.obs;
final RxBool darkMode = false.obs;
final RxDouble volume = 0.5.obs;

MultiObx(
  observables: [notifications, darkMode, volume],
  builder: () {
    return Column(
      children: [
        SwitchListTile(
          title: Text('Notifications'),
          value: notifications.value,
          onChanged: (value) => notifications.value = value,
        ),
        SwitchListTile(
          title: Text('Dark Mode'),
          value: darkMode.value,
          onChanged: (value) => darkMode.value = value,
        ),
        Slider(
          value: volume.value,
          onChanged: (value) => volume.value = value,
        ),
      ],
    );
  },
)
```

### 3. Performance Tips

1. **Specify only necessary observables**: Don't include observables that don't affect the UI
2. **Use filters when appropriate**: Filter updates to reduce unnecessary rebuilds
3. **Combine with GetBuilder**: Use regular GetBuilder for non-reactive parts

```dart
// Efficient: Only watch what you need
GetBuilderObs<MyController>(
  observables: [controller.count], // Only count, not all variables
  filter: (controller) => controller.count.value ~/ 10, // Only rebuild every 10 counts
  builder: (controller) => Text('Tens: ${controller.count.value ~/ 10}'),
)
```

## Migration Guide

### From GetBuilder to GetBuilderObs

```dart
// Before
GetBuilder<MyController>(
  builder: (controller) {
    return Obx(() => Text('${controller.count.value}')); // Nested Obx
  },
)

// After
GetBuilderObs<MyController>(
  observables: [controller.count],
  builder: (controller) {
    return Text('${controller.count.value}'); // Direct access
  },
)
```

### From Multiple Obx to MultiObx

```dart
// Before
Column(
  children: [
    Obx(() => Text(title.value)),
    Obx(() => Text('${counter.value}')),
    Obx(() => Switch(value: flag.value, onChanged: (v) => flag.value = v)),
  ],
)

// After
MultiObx(
  observables: [title, counter, flag],
  builder: () => Column(
    children: [
      Text(title.value),
      Text('${counter.value}'),
      Switch(value: flag.value, onChanged: (v) => flag.value = v),
    ],
  ),
)
```

## Troubleshooting

### Common Issues

1. **Controller not found**: Make sure to initialize the controller or use proper binding
2. **Observables not updating**: Ensure observables are included in the `observables` list
3. **Performance issues**: Check if you're watching too many observables or missing filters

### Debug Tips

```dart
GetBuilderObs<MyController>(
  observables: [controller.count],
  builder: (controller) {
    print('Rebuilding with count: ${controller.count.value}'); // Debug rebuilds
    return YourWidget();
  },
)
```

## Conclusion

The enhanced GetBuilder widgets provide more flexibility and power while maintaining the simplicity and performance that GetX is known for. Choose the right widget for your use case and enjoy better state management!
