import 'get_instance.dart';

/// [Bindings] should be extended or implemented.
/// When using `GetMaterialApp`, all `GetPage`s and navigation
/// methods (like Get.to()) have a `binding` property that takes an
/// instance of Bindings to manage the
/// dependencies() (via Get.put()) for the Route you are opening.
// ignore: one_member_abstracts
abstract class Bindings {
  void dependencies();
}

/// Simplifies Bindings generation from a single callback.
/// To avoid the creation of a custom Binding instance per route.
///
/// Example:
/// ```
/// GetPage(
///   name: '/',
///   page: () => Home(),
///   // This might cause you an error.
///   // binding: BindingsBuilder(() => Get.put(HomeController())),
///   binding: BindingsBuilder(() { Get.put(HomeController(); })),
///   // Using .lazyPut() works fine.
///   // binding: BindingsBuilder(() => Get.lazyPut(() => HomeController())),
///   // Using .smartLazyPut() is recommended for better lifecycle management.
///   // binding: BindingsBuilder(() => Get.smartLazyPut(() => HomeController())),
/// ),
/// ```
class BindingsBuilder<T> extends Bindings {
  /// Register your dependencies in the [builder] callback.
  final BindingBuilderCallback builder;

  /// Shortcut to register 1 Controller with Get.put(),
  /// Prevents the issue of the fat arrow function with the constructor.
  /// BindingsBuilder(() => Get.put(HomeController())),
  ///
  /// Sample:
  /// ```
  /// GetPage(
  ///   name: '/',
  ///   page: () => Home(),
  ///   binding: BindingsBuilder.put(() => HomeController()),
  /// ),
  /// ```
  factory BindingsBuilder.put(
    InstanceBuilderCallback<T> builder, {
    String? tag,
    bool permanent = false,
  }) {
    return BindingsBuilder(
      () => GetInstance().put<T>(builder(), tag: tag, permanent: permanent),
    );
  }

  /// Enhanced shortcut to register 1 Controller with Get.lazyPut(),
  /// Provides better memory management and lifecycle control.
  ///
  /// Sample:
  /// ```
  /// GetPage(
  ///   name: '/',
  ///   page: () => Home(),
  ///   binding: BindingsBuilder.lazyPut(() => HomeController()),
  /// ),
  /// ```
  factory BindingsBuilder.lazyPut(
    InstanceBuilderCallback<T> builder, {
    String? tag,
    bool? fenix,
    bool permanent = false,
  }) {
    return BindingsBuilder(
      () => GetInstance().lazyPut<T>(
        builder,
        tag: tag,
        fenix: fenix,
        permanent: permanent,
      ),
    );
  }

  /// Smart shortcut to register 1 Controller with Get.smartLazyPut(),
  /// Provides intelligent lifecycle management and automatic recreation.
  /// This is the recommended method for most use cases.
  ///
  /// Sample:
  /// ```
  /// GetPage(
  ///   name: '/',
  ///   page: () => Home(),
  ///   binding: BindingsBuilder.smartLazyPut(() => HomeController()),
  /// ),
  /// ```
  factory BindingsBuilder.smartLazyPut(
    InstanceBuilderCallback<T> builder, {
    String? tag,
    bool? fenix,
    bool autoRemove = true,
  }) {
    return BindingsBuilder(
      () => GetInstance().smartLazyPut<T>(
        builder,
        tag: tag,
        fenix: fenix,
        autoRemove: autoRemove,
      ),
    );
  }

  /// WARNING: don't use `()=> Get.put(Controller())`,
  /// if only passing 1 callback use `BindingsBuilder.put(Controller())`
  /// or `BindingsBuilder(()=> Get.lazyPut(Controller()))`
  /// or `BindingsBuilder.smartLazyPut(() => Controller())` (recommended)
  BindingsBuilder(this.builder);

  @override
  void dependencies() {
    builder();
  }
}

// abstract class INavigation {}
// typedef Snack = Function();
// typedef Modal = Function();
// typedef Route = Function();
typedef BindingBuilderCallback = void Function();
