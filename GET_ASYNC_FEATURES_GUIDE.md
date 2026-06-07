# GetX Master: Async & State Management Enhancements

This guide explains the new professional widgets and utilities added to `get_x_master` for handling asynchronous operations and state transitions seamlessly.

## 1. GetAsyncBuilder

`GetAsyncBuilder` is a powerful alternative to Flutter's `FutureBuilder` and `StreamBuilder`. It automatically manages loading, success, error, and empty states.

### Key Features:
- **Unified API:** One widget for both Futures and Streams.
- **State Awareness:** Uses `RxStatus` internally.
- **Smooth UX:** `keepDataOnReload` allows showing existing data while fetching updates.
- **Manual Reload:** Easily trigger reloads via `GlobalKey`.
- **Empty State Support:** Built-in detection for empty lists/maps.

### Usage (Future):

```dart
GetAsyncBuilder<List<User>>.future(
  future: () => api.fetchUsers(),
  isEmpty: (data) => data.isEmpty,
  onSuccess: (context, users) => UserList(users),
  onLoading: (context) => ShimmerLoading(), // Optional
  onEmpty: (context) => EmptyPlaceholder(), // Optional
  onError: (context, error, reload) => CustomErrorWidget(error, reload), // Optional
)
```

### Usage (Stream):

```dart
GetAsyncBuilder<User>.stream(
  stream: () => database.watchUser(id),
  onSuccess: (context, user) => UserProfile(user),
)
```

---

## 2. GetStateView

`GetStateView` is a declarative wrapper for controllers using `StateMixin`. It's a cleaner alternative to `controller.obx()`.

### Usage:

```dart
class UserController extends GetxController with StateMixin<User> {
  void loadUser() => futurize(() => api.getUser());
}

// In UI:
GetStateView<UserController, User>(
  onSuccess: (context, user) => Text(user!.name),
  onLoading: (context) => CircularProgressIndicator(),
)
```

---

## 3. StateMixin.futurize()

The `futurize` method simplifies the process of executing a Future and updating the controller's state.

### Traditional way:
```dart
change(null, status: RxStatus.loading());
try {
  final data = await api.getData();
  change(data, status: RxStatus.success());
} catch (e) {
  change(null, status: RxStatus.error(e.toString()));
}
```

### New way with `futurize`:
```dart
void fetchData() {
  futurize(() => api.getData(), errorMessage: "Failed to load data");
}
```

---

## Comparison Table

| Feature | FutureBuilder | GetAsyncBuilder |
| :--- | :--- | :--- |
| **Boilerplate** | High (manual switch/if) | Low (declarative builders) |
| **Error Handling** | Manual | Automatic (with retry support) |
| **Empty State** | Manual | Automatic (`isEmpty` callback) |
| **Keep Data on Reload** | No (shows null/loading) | Yes (optional) |
| **GetX Integration** | No | Yes (`RxStatus`) |
