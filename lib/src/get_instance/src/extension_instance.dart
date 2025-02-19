import 'package:flutter/foundation.dart';
import 'package:get_x_master/src/get_core/src/get_interface.dart';

import 'get_instance.dart';

extension Inst on GetInterface {
  /// Creates a new Instance<S> lazily from the `<S>builder()` callback.
  ///
  /// The first time you call `Get.find()`, the `builder()` callback will create
  /// the Instance and persisted as a Singleton (like you would use
  /// `Get.put()`).
  ///
  /// Using `Get.smartManagement` as [SmartManagement.keepFactory] has
  /// the same outcome
  /// as using `fenix:true` :
  /// The internal register of `builder()` will remain in memory to recreate
  /// the Instance if the Instance has been removed with `Get.delete()`.
  /// Therefore, future calls to `Get.find()` will return the same Instance.
  ///
  /// If you need to make use of GetxController's life-cycle
  /// (`onInit(), onStart(), onClose()`)
  /// [fenix] is a great choice to mix with `GetBuilder` and `GetX` widgets,
  /// and/or [GetMaterialApp] Navigation.
  ///
  /// You could use `Get.lazyPut(fenix:true)` in your app's `main()` instead of
  /// `Bindings` for each [GetPage].
  /// And the memory management will be similar.
  ///
  /// Subsequent calls to `Get.lazyPut` with the same parameters
  /// (`<S>` and optionally [tag] will **not** override the original).
  void lazyPut<S>(InstanceBuilderCallback<S> builder,
      {String? tag, bool fenix = false}) {
    GetInstance().lazyPut<S>(builder, tag: tag, fenix: fenix);
  }

  // void printInstanceStack() {
  //   GetInstance().printInstanceStack();
  // }

  /// async version of `Get.put()`.
  /// Awaits for the resolution of the Future from `builder()`parameter and
  /// stores the Instance returned.
  Future<S> putAsync<S>(AsyncInstanceBuilderCallback<S> builder,
          {String? tag, bool permanent = false}) async =>
      GetInstance().putAsync<S>(builder, tag: tag, permanent: permanent);

  /// Creates a new Class Instance [S] from the builder callback[S].
  /// Every time `find<S>()` is used, it calls the builder method to generate
  /// a new Instance [S].
  /// It also registers each `instance.onClose()` with the current
  /// Route `GetConfig.currentRoute` to keep the lifecycle active.
  /// Is important to know that the instances created are only stored per Route.
  /// So, if you call `Get.delete<T>()` the "instance factory" used in this
  /// method (`Get.create<T>()`) will be removed, but NOT the instances
  /// already created by it.
  /// Uses `tag` as the other methods.
  ///
  /// Example:
  ///
  /// ```create(() => Repl());
  /// Repl a = find();
  /// Repl b = find();
  /// print(a==b); (false)```
  void create<S>(InstanceBuilderCallback<S> builder,
          {String? tag, bool permanent = true}) =>
      GetInstance().create<S>(builder, tag: tag, permanent: permanent);

  /// Finds a Instance of the required Class `<S>`(or [tag])
  /// In the case of using `Get.create()`, it will generate an Instance
  /// each time you call `Get.find()`.
  S find<S>({String? tag}) => GetInstance().find<S>(tag: tag);

  /// Injects an `Instance<S>` in memory.
  ///
  /// No need to define the generic type `<[S]>` as it's inferred
  /// from the [dependency] parameter.
  ///
  /// - [dependency] The Instance to be injected.
  /// - [tag] optionally, use a [tag] as an "id" to create multiple records
  /// of the same `Type<S>` the [tag] does **not** conflict with the same tags
  /// used by other dependencies Types.
  /// - [permanent] keeps the Instance in memory and persist it,
  /// not following `Get.smartManagement`
  /// rules. Although, can be removed by `GetInstance.reset()`
  /// and `Get.delete()`
  /// - [builder] If defined, the [dependency] must be returned from here
  S put<S>(S dependency,
          {String? tag,
          bool permanent = false,
          InstanceBuilderCallback<S>? builder}) =>
      GetInstance().put<S>(dependency, tag: tag, permanent: permanent);

  /// Clears all registered instances (and/or tags).
  /// Even the persistent ones.
  ///
  /// - `clearFactory` clears the callbacks registered by `Get.lazyPut()`
  /// - `clearRouteBindings` clears Instances associated with Routes when using
  ///   [GetMaterialApp].
  // bool reset(
  //         {@deprecated bool clearFactory = true,
  //         @deprecated bool clearRouteBindings = true}) =>
  //     GetInstance().reset(
  //         // ignore: deprecated_member_use_from_same_package
  //         clearFactory: clearFactory,
  //         // ignore: deprecated_member_use_from_same_package
  //         clearRouteBindings: clearRouteBindings);

  /// Deletes the `Instance<S>`, cleaning the memory and closes any open
  /// controllers (`DisposableInterface`).
  ///
  /// - [tag] Optional "tag" used to register the Instance
  /// - [force] Will delete an Instance even if marked as `permanent`.
  Future<bool> delete<S>({String? tag, bool force = false}) async =>
      GetInstance().delete<S>(tag: tag, force: force);

  /// Deletes all Instances, cleaning the memory and closes any open
  /// controllers (`DisposableInterface`).
  ///
  /// - [force] Will delete the Instances even if marked as `permanent`.
  Future<void> deleteAll({bool force = false}) async =>
      GetInstance().deleteAll(force: force);

  void reloadAll({bool force = false}) => GetInstance().reloadAll(force: force);

  void reload<S>({String? tag, String? key, bool force = false}) =>
      GetInstance().reload<S>(tag: tag, key: key, force: force);

  /// Checks if a Class `Instance<S>` (or [tag]) is registered in memory.
  /// - [tag] optional, if you use a [tag] to register the Instance.
  bool isRegistered<S>({String? tag}) =>
      GetInstance().isRegistered<S>(tag: tag);

  /// Checks if an `Instance<S>` (or [tag]) returned from a factory builder
  /// `Get.lazyPut()`, is registered in memory.
  /// - [tag] optional, if you use a [tag] to register the Instance.
  bool isPrepared<S>({String? tag}) => GetInstance().isPrepared<S>(tag: tag);

  /// Replace a parent instance of a class in dependency management
  /// with a [child] instance
  /// - [tag] optional, if you use a [tag] to register the Instance.
  void replace<P>(P child, {String? tag}) {
    final info = GetInstance().getInstanceInfo<P>(tag: tag);
    final permanent = (info.isPermanent ?? false);
    delete<P>(tag: tag, force: permanent);
    put(child, tag: tag, permanent: permanent);
  }

  /// Replaces a parent instance with a new Instance<P> lazily from the
  /// `<P>builder()` callback.
  /// - [tag] optional, if you use a [tag] to register the Instance.
  /// - [fenix] optional
  ///
  ///  Note: if fenix is not provided it will be set to true if
  /// the parent instance was permanent
  void lazyReplace<P>(InstanceBuilderCallback<P> builder,
      {String? tag, bool? fenix}) {
    final info = GetInstance().getInstanceInfo<P>(tag: tag);
    final permanent = (info.isPermanent ?? false);
    delete<P>(tag: tag, force: permanent);
    lazyPut(builder, tag: tag, fenix: fenix ?? permanent);
  }
}

extension SmartLazyPut on GetInterface {
  /// Enhanced version of lazyPut that handles controller recreation.
  ///
  /// Use this method to register a controller with GetX, ensuring that
  /// the controller is only created if it hasn't been registered before
  /// or if it has been removed. It also checks if the builder for the
  /// controller has been prepared before proceeding.
  ///
  /// Example:
  /// ```
  /// Get.smartLazyPut<MyController>(() => MyController());
  /// ```
  ///
  /// Parameters:
  ///   - [builder]: A callback function that returns an instance of the controller.
  ///   - [tag]: An optional tag to identify the controller instance.
  ///   - [fenix]: If true (default), the controller instance will remain in memory even when not in use.
  ///   - [autoRemove]: If true, the controller instance will be automatically removed when not in use.
  void smartLazyPut<S>(
    InstanceBuilderCallback<S> builder, {
    String? tag,
    bool? fenix,
    bool autoRemove = true,
  }) {
    // If it is not registered previously or has been removed
    if (!isRegistered<S>(tag: tag)) {
      // Check if the builder has been prepared before
      if (!isPrepared<S>(tag: tag)) {
        lazyPut<S>(
          builder,
          tag: tag,
          // If fenix is not specified, default to true
          fenix: fenix ?? true,
        );
      }
    }
  }

  /// Enhanced version of find that ensures the controller exists.
  ///
  /// Use this method to retrieve a registered controller from GetX. If the
  /// controller is not found and its builder is prepared, a new instance
  /// of the controller will be created.
  ///
  /// Example:
  /// ```
  /// MyController myController = Get.smartFind<MyController>();
  /// ```
  ///
  /// Parameters:
  ///   - [tag]: An optional tag to identify the controller instance.
  ///
  /// Returns:
  ///   - The controller instance.
  ///
  /// Throws:
  ///   - An exception if the controller is not found and its builder is not prepared.
  S smartFind<S>({String? tag}) {
    try {
      return find<S>(tag: tag);
    } catch (e) {
      // If the controller was not found and its builder is prepared
      if (isPrepared<S>(tag: tag)) {
        // Create a new instance
        return find<S>(tag: tag);
      }
      rethrow;
    }
  }
}

/// Extension for advanced dependency management with intelligent injection strategies
extension SmartDependencyManagement on GetInterface {
  /// Smartly manages dependency injection with advanced conditional logic
  ///
  /// [S] is the type of instance to be managed
  ///
  /// Parameters:
  /// - [builder]: Callback to create the instance
  /// - [condition]: Optional condition to check before instance creation
  /// - [validityCheck]: Optional function to validate existing instance
  /// - [tag]: Optional tag for multiple instances of same type
  /// - [permanent]: Whether the instance should persist
  /// - [fenix]: Enable lazy initialization with recreation capability
  ///
  /// Returns the managed instance of type [S]
  ///
  /// Example:
  /// ```dart
  /// // Create a database service only if network is available
  /// final dbService = smartPut<DatabaseService>(
  ///   builder: () => DatabaseService(),
  ///   condition: () => NetworkManager.isConnected,
  ///   validityCheck: (service) => service.isConnectionValid(),
  ///   permanent: true
  /// );
  /// ```
  S smartPut<S>({
    required InstanceBuilderCallback<S> builder,
    bool Function()? condition,
    bool Function(S instance)? validityCheck,
    String? tag,
    bool permanent = false,
    bool fenix = false,
  }) {
    // Check if instance is already registered
    if (isRegistered<S>(tag: tag)) {
      final existingInstance = find<S>(tag: tag);

      // Validate existing instance if a validity check is provided
      if (validityCheck != null && !validityCheck(existingInstance)) {
        // Delete invalid instance
        delete<S>(tag: tag, force: true);
      } else {
        // Return existing valid instance
        return existingInstance;
      }
    }

    // Check creation condition if provided
    if (condition != null && !condition()) {
      throw ArgumentError('Instance creation condition not met for $S');
    }

    // Create new instance
    final instance = builder();

    // Register instance based on fenix flag
    if (fenix) {
      lazyPut(() => instance, tag: tag, fenix: true);
    } else {
      put(instance, tag: tag, permanent: permanent);
    }

    return instance;
  }

  /// Advanced version of smartPut with more flexible dependency management
  ///
  /// Provides enhanced control over instance creation and fallback mechanisms
  ///
  /// Parameters:
  /// - [primaryCondition]: Main condition for instance creation
  /// - [builder]: Primary instance creation callback
  /// - [secondaryValidation]: Additional validation for existing instances
  /// - [fallbackBuilder]: Alternative instance creation if primary fails
  /// - [tag]: Optional tag for multiple instances of same type
  /// - [permanent]: Whether the instance should persist
  /// - [enableLogging]: Enable detailed logging for debugging
  ///
  /// Returns the managed instance of type [S]
  ///
  /// Example:
  /// ```dart
  /// final userService = smartPutIf<UserService>(
  ///   primaryCondition: () => AuthManager.isLoggedIn,
  ///   builder: () => UserService(),
  ///   fallbackBuilder: () => GuestUserService(),
  ///   secondaryValidation: (service) => service.hasValidPermissions(),
  ///   enableLogging: true
  /// );
  /// ```
  S smartPutIf<S>({
    required bool Function() primaryCondition,
    required InstanceBuilderCallback<S> builder,
    bool Function(S instance)? secondaryValidation,
    InstanceBuilderCallback<S>? fallbackBuilder,
    String? tag,
    bool permanent = false,
    bool enableLogging = false,
  }) {
    // Logging utility for debugging
    void log(String message) {
      if (enableLogging) {
        debugPrint('[SmartPutIf] $message');
      }
    }

    // Check for existing registered instance
    if (isRegistered<S>(tag: tag)) {
      final existingInstance = find<S>(tag: tag);

      // Perform secondary validation if provided
      if (secondaryValidation != null) {
        if (secondaryValidation(existingInstance)) {
          log('Using existing validated instance of $S');
          return existingInstance;
        } else {
          log('Existing instance of $S failed validation');
          delete<S>(tag: tag, force: true);
        }
      } else {
        log('Returning existing instance of $S');
        return existingInstance;
      }
    }

    // Check primary condition for instance creation
    if (!primaryCondition()) {
      // Use fallback builder if provided
      if (fallbackBuilder != null) {
        log('Primary condition failed. Using fallback builder for $S');
        return put(fallbackBuilder(), tag: tag, permanent: permanent);
      }

      log('Primary condition failed. Skipping instance creation for $S');
      throw ArgumentError('Instance creation condition not met for $S');
    }

    // Create and register new instance
    final instance = builder();
    log('Creating and registering new instance of $S');
    return put(instance, tag: tag, permanent: permanent);
  }

  /// Utility method to create a managed lazy dependency
  ///
  /// Simplifies lazy initialization with optional creation conditions
  ///
  /// Parameters:
  /// - [builder]: Instance creation callback
  /// - [initCondition]: Optional condition for initialization
  /// - [tag]: Optional tag for multiple instances of same type
  /// - [permanent]: Whether the instance should persist
  ///
  /// Returns the lazily managed instance of type [S]
  ///
  /// Example:
  /// ```dart
  /// final expensiveService = lazyManage<ExpensiveService>(
  ///   builder: () => ExpensiveService(),
  ///   initCondition: () => FeatureFlags.isServiceEnabled,
  ///   permanent: true
  /// );
  /// ```
  S lazyManage<S>({
    required InstanceBuilderCallback<S> builder,
    bool Function()? initCondition,
    String? tag,
    bool permanent = false,
  }) {
    return smartPut<S>(
      builder: builder,
      condition: initCondition,
      tag: tag,
      permanent: permanent,
      fenix: true,
    );
  }
}
