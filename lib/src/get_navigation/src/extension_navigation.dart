// ignore_for_file: unused_catch_clause, prefer_conditional_assignment

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../get_core/get_core.dart';
import '../../get_instance/src/bindings_interface.dart';
import '../../get_utils/get_utils.dart';
import '../get_navigation.dart';
import 'dialog/dialog_route.dart';
import 'root/parse_route.dart';

/// It replaces the Flutter Navigator, but needs no context.
/// You can to use navigator.push(YourRoute()) rather
/// Navigator.push(context, YourRoute());
NavigatorState? get navigator => GetNavigation(Get).key.currentState;

extension ExtensionBottomSheet on GetInterface {
  /// Shows a standard Material Design bottom sheet.
  ///
  /// This method wraps the standard `showModalBottomSheet` functionality using GetX's navigation.
  ///
  ///  * [bottomsheet]: The widget to display inside the bottom sheet.
  ///  * [backgroundColor]: The background color of the bottom sheet.
  ///  * [elevation]: The elevation of the bottom sheet.
  ///  * [persistent]: Whether the bottom sheet is persistent (cannot be dismissed by tapping outside).
  ///  * [shape]: The shape of the bottom sheet.
  ///  * [clipBehavior]: The clip behavior of the bottom sheet.
  ///  * [barrierColor]: The color of the barrier that appears behind the bottom sheet.
  ///  * [ignoreSafeArea]: Whether to ignore the safe area.
  ///  * [isScrollControlled]: Whether the bottom sheet is scroll-controlled.
  ///  * [useRootNavigator]: Whether to use the root navigator.
  ///  * [isDismissible]: Whether the bottom sheet can be dismissed by tapping outside.
  ///  * [enableDrag]: Whether the bottom sheet can be dragged.
  ///  * [settings]: The route settings.
  ///  * [enterBottomSheetDuration]: The duration of the entrance animation.
  ///  * [exitBottomSheetDuration]: The duration of the exit animation.
  Future<T?> bottomSheet<T>(
    Widget bottomsheet, {

    /// The background color of the bottom sheet.
    Color? backgroundColor,

    /// The elevation of the bottom sheet.
    double? elevation,

    /// Whether the bottom sheet is persistent (cannot be dismissed by tapping outside).
    bool persistent = true,

    /// The shape of the bottom sheet.
    ShapeBorder? shape,

    /// The clip behavior of the bottom sheet.
    Clip? clipBehavior,

    /// The color of the barrier that appears behind the bottom sheet.
    Color? barrierColor,

    /// Whether to ignore the safe area.
    bool? ignoreSafeArea,

    /// Whether the bottom sheet is scroll-controlled.
    bool isScrollControlled = false,

    /// Whether to use the root navigator.
    bool useRootNavigator = false,

    /// Whether the bottom sheet can be dismissed by tapping outside.
    bool isDismissible = true,

    /// Whether the bottom sheet can be dragged.
    bool enableDrag = true,

    /// The route settings.
    RouteSettings? settings,

    /// The duration of the entrance animation.
    Duration? enterBottomSheetDuration,

    /// The duration of the exit animation.
    Duration? exitBottomSheetDuration,
  }) {
    final overlayCtx = overlayContext;
    if (overlayCtx == null) {
      throw Exception(
        'GetX overlay context is not available. Make sure you are using GetMaterialApp.',
      );
    }
    final keyCtx = key.currentContext;
    if (keyCtx == null) {
      throw Exception(
        'Navigator key context is not available. Make sure you are using GetMaterialApp.',
      );
    }
    return Navigator.of(overlayCtx, rootNavigator: useRootNavigator).push(
      GetModalBottomSheetRoute<T>(
        builder: (_) => bottomsheet,
        isPersistent: persistent,
        // theme: Theme.of(key.currentContext, shadowThemeOnly: true), //Consider removing this or making it optional
        theme: Theme.of(keyCtx),
        isScrollControlled: isScrollControlled,
        barrierLabel: MaterialLocalizations.of(keyCtx).modalBarrierDismissLabel,
        backgroundColor: backgroundColor ?? Colors.transparent,
        elevation: elevation,
        shape: shape,
        removeTop: ignoreSafeArea ?? true,
        clipBehavior: clipBehavior,
        isDismissible: isDismissible,
        modalBarrierColor: barrierColor,
        settings: settings,
        enableDrag: enableDrag,
        enterBottomSheetDuration:
            enterBottomSheetDuration ?? const Duration(milliseconds: 250),
        exitBottomSheetDuration:
            exitBottomSheetDuration ?? const Duration(milliseconds: 200),
      ),
    );
  }

  /// Shows a custom expandable bottom sheet that can open from the top or bottom.
  ///
  /// This method uses the [BottomSheetExpandableRoute] to display a highly customizable
  /// bottom sheet.
  Future<T?>? bottomSheetExpandable<T>({
    /// Required. A builder function that returns the widget tree for the bottom sheet content.
    required WidgetBuilder builder,

    /// The initial size of the bottom sheet (fraction of screen height). Defaults to 0.0 for top-down.
    double initialChildSize = 0.0,

    /// The minimum size of the bottom sheet (fraction of screen height). Defaults to 0.0 for top-down.
    double minChildSize = 0.0,

    /// The maximum size of the bottom sheet (fraction of screen height). Defaults to 1.0.
    double maxChildSize = 1.0,

    /// The radius of the rounded corners. Defaults to 15.0.
    double borderRadius = 15.0,

    /// Whether the bottom sheet can be dismissed by tapping the barrier. Defaults to true.
    bool isDismissible = true,

    /// Whether the bottom sheet can be dragged. Defaults to true.
    bool enableDrag = true,

    /// Whether the bottom sheet should snap to specific sizes. Defaults to false.
    bool snap = false,

    /// The background color of the bottom sheet.
    Color? backgroundColor = Colors.white,

    /// The elevation of the bottom sheet.
    double? elevation,

    /// The duration of the entrance animation.
    Duration? enterBottomSheetDuration,

    /// The duration of the exit animation.
    Duration? exitBottomSheetDuration,

    /// A theme to apply to the bottom sheet.
    ThemeData? theme,

    /// The animation curve.
    Curve? curve,

    /// The shape of the bottom sheet.
    ShapeBorder? shape,

    /// The label for the barrier.
    String? barrierLabel,

    /// The clip behavior.
    Clip? clipBehavior,

    /// Whether the bottom sheet is persistent (cannot be dismissed by tapping outside). Defaults to false.
    bool isPersistent = false,

    /// Whether the bottom sheet is scroll-controlled. Defaults to true.
    bool isScrollControlled = true,

    /// A key for accessing the ScaffoldMessengerState.
    GlobalKey<ScaffoldMessengerState>? messengerKey,

    /// The color of the modal barrier.
    Color? modalBarrierColor,

    /// A key for accessing the ScaffoldState.
    GlobalKey<ScaffoldState>? scaffoldKey,

    /// Route settings.
    RouteSettings? settings,

    /// Whether the bottom sheet should open from the top. Defaults to true.
    bool startFromTop = true,

    /// Whether to show close button
    bool isShowCloseBottom = false,

    /// Whether to show close button
    IconData closeIcon = Icons.close,

    /// [indicatorColor] The color of the indicatorColor.
    Color indicatorColor = const Color.fromRGBO(224, 224, 224, 1),
    double? itemPaddingTop = 60.0,
  }) {
    final context = Get.context;
    if (context == null) {
      throw Exception(
        'GetX context is not available. Make sure you are using GetMaterialApp.',
      );
    }
    return Navigator.of(context).push(
      BottomSheetExpandableRoute<T>(
        builder: builder,
        initialChildSize: initialChildSize,
        minChildSize: minChildSize,
        maxChildSize: maxChildSize,
        borderRadius: borderRadius,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        backgroundColor: backgroundColor,
        elevation: elevation,
        enterBottomSheetDuration:
            enterBottomSheetDuration ?? const Duration(milliseconds: 250),
        exitBottomSheetDuration:
            exitBottomSheetDuration ?? const Duration(milliseconds: 200),
        theme: theme,
        curve: curve,
        shape: shape,
        snap: snap,
        barrierLabel: barrierLabel,
        clipBehavior: clipBehavior,
        isPersistent: isPersistent,
        isScrollControlled: isScrollControlled,
        messengerKey: messengerKey,
        modalBarrierColor: modalBarrierColor,
        scaffoldKey: scaffoldKey,
        settings: settings,
        startFromTop: startFromTop,
        isShowCloseBottom: isShowCloseBottom,
        closeIcon: closeIcon,
        indicatorColor: indicatorColor,
        itemPaddingTop: itemPaddingTop!,
      ),
    );
  }
}

extension ExtensionDialog on GetInterface {
  /// Show a dialog.
  /// You can pass a [transitionDuration] and/or [transitionCurve],
  /// overriding the defaults when the dialog shows up and closes.
  /// When the dialog closes, uses those animations in reverse.
  Future<T?> dialog<T>(
    Widget widget, {
    bool barrierDismissible = true,
    Color? barrierColor,
    bool useSafeArea = true,
    GlobalKey<NavigatorState>? navigatorKey,
    Object? arguments,
    Duration? transitionDuration,
    Curve? transitionCurve,
    String? name,
    RouteSettings? routeSettings,
  }) {
    final ctx = Get.context;
    if (ctx == null) {
      throw Exception(
        'GetX context is not available. Make sure you are using GetMaterialApp.',
      );
    }
    assert(debugCheckHasMaterialLocalizations(ctx));

    //  final theme = Theme.of(context, shadowThemeOnly: true);
    final theme = Theme.of(ctx);
    return generalDialog<T>(
      pageBuilder: (buildContext, animation, secondaryAnimation) {
        final pageChild = widget;
        Widget dialog = Builder(
          builder: (context) {
            return Theme(data: theme, child: pageChild);
          },
        );
        if (useSafeArea) {
          dialog = SafeArea(child: dialog);
        }
        return dialog;
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(ctx).modalBarrierDismissLabel,
      barrierColor: barrierColor ?? Colors.black54,
      transitionDuration: transitionDuration ?? defaultDialogTransitionDuration,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: transitionCurve ?? defaultDialogTransitionCurve,
          ),
          child: child,
        );
      },
      navigatorKey: navigatorKey,
      routeSettings:
          routeSettings ?? RouteSettings(arguments: arguments, name: name),
    );
  }

  /// Api from showGeneralDialog with no context
  Future<T?> generalDialog<T>({
    required RoutePageBuilder pageBuilder,
    bool barrierDismissible = false,
    String? barrierLabel,
    Color barrierColor = const Color(0x80000000),
    Duration transitionDuration = const Duration(milliseconds: 200),
    RouteTransitionsBuilder? transitionBuilder,
    GlobalKey<NavigatorState>? navigatorKey,
    RouteSettings? routeSettings,
  }) {
    assert(!barrierDismissible || barrierLabel != null);
    final overlayCtx = overlayContext;
    if (overlayCtx == null) {
      throw Exception(
        'GetX overlay context is not available. Make sure you are using GetMaterialApp.',
      );
    }
    final nav =
        navigatorKey?.currentState ??
        Navigator.of(
          overlayCtx,
          rootNavigator: true,
        ); //overlay context will always return the root navigator
    return nav.push<T>(
      GetDialogRoute<T>(
        pageBuilder: pageBuilder,
        barrierDismissible: barrierDismissible,
        barrierLabel: barrierLabel,
        barrierColor: barrierColor,
        transitionDuration: transitionDuration,
        transitionBuilder: transitionBuilder,
        settings: routeSettings,
      ),
    );
  }

  /// Custom UI Dialog.
  Future<T?> defaultDialog<T>({
    String title = "Alert",
    EdgeInsetsGeometry? titlePadding,
    TextStyle? titleStyle,
    Widget? content,
    EdgeInsetsGeometry? contentPadding,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    VoidCallback? onCustom,
    Color? cancelTextColor,
    Color? confirmTextColor,
    String? textConfirm,
    String? textCancel,
    String? textCustom,
    Widget? confirm,
    Widget? cancel,
    Widget? custom,
    Color? backgroundColor,
    bool barrierDismissible = true,
    Color? buttonColor,
    String middleText = "Dialog made in 3 lines of code",
    TextStyle? middleTextStyle,
    double radius = 20.0,
    //   ThemeData themeData,
    List<Widget>? actions,

    // onWillPop Scope
    void Function(bool, dynamic)? onWillPop,

    // the navigator used to push the dialog
    GlobalKey<NavigatorState>? navigatorKey,
  }) {
    var leanCancel = onCancel != null || textCancel != null;
    var leanConfirm = onConfirm != null || textConfirm != null;
    actions ??= [];

    if (cancel != null) {
      actions.add(cancel);
    } else {
      if (leanCancel) {
        actions.add(
          TextButton(
            style: TextButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: buttonColor ?? theme.colorScheme.secondary,
                  width: 2,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            onPressed: () {
              onCancel?.call();
              back();
            },
            child: Text(
              textCancel ?? "Cancel",
              style: TextStyle(
                color: cancelTextColor ?? theme.colorScheme.secondary,
              ),
            ),
          ),
        );
      }
    }
    if (confirm != null) {
      actions.add(confirm);
    } else {
      if (leanConfirm) {
        actions.add(
          TextButton(
            style: TextButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: buttonColor ?? theme.colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Text(
              textConfirm ?? "Ok",
              style: TextStyle(
                color: confirmTextColor ?? theme.colorScheme.surface,
              ),
            ),
            onPressed: () {
              onConfirm?.call();
            },
          ),
        );
      }
    }

    Widget baseAlertDialog = AlertDialog(
      titlePadding: titlePadding ?? const EdgeInsets.all(8),
      contentPadding: contentPadding ?? const EdgeInsets.all(8),

      backgroundColor: backgroundColor ?? theme.dialogTheme.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      title: Text(title, textAlign: TextAlign.center, style: titleStyle),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          content ??
              Text(
                middleText,
                textAlign: TextAlign.center,
                style: middleTextStyle,
              ),
          const SizedBox(height: 16),
          ButtonTheme(
            minWidth: 78.0,
            height: 34.0,
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: actions,
            ),
          ),
        ],
      ),
      // actions: actions, // ?? <Widget>[cancelButton, confirmButton],
      buttonPadding: EdgeInsets.zero,
    );

    return dialog<T>(
      onWillPop != null
          ? PopScope(onPopInvokedWithResult: onWillPop, child: baseAlertDialog)
          : baseAlertDialog,
      barrierDismissible: barrierDismissible,
      navigatorKey: navigatorKey,
    );
  }
}

extension ExtensionSnackbar on GetInterface {
  SnackBarController rawSnackbar({
    String? title,
    String? message,
    Widget? titleText,
    Widget? messageText,
    Widget? icon,
    bool instantInit = true,
    bool shouldIconPulse = true,
    double? maxWidth,
    EdgeInsets margin = const EdgeInsets.all(0.0),
    EdgeInsets padding = const EdgeInsets.all(16),
    double borderRadius = 0.0,
    Color? borderColor,
    double borderWidth = 1.0,
    Color backgroundColor = const Color(0xFF303030),
    Color? leftBarIndicatorColor,
    List<BoxShadow>? boxShadows,
    Gradient? backgroundGradient,
    Widget? mainButton,
    OnTap? onTap,
    Duration? duration = const Duration(seconds: 3),
    bool isDismissible = true,
    DismissDirection? dismissDirection,
    bool showProgressIndicator = false,
    AnimationController? progressIndicatorController,
    Color? progressIndicatorBackgroundColor,
    Animation<Color>? progressIndicatorValueColor,
    SnackPosition snackPosition = SnackPosition.bottom,
    SnackStyle snackStyle = SnackStyle.floating,
    Curve forwardAnimationCurve = Curves.easeOutCirc,
    Curve reverseAnimationCurve = Curves.easeOutCirc,
    Duration animationDuration = const Duration(seconds: 1),
    SnackbarStatusCallback? snackbarStatus,
    double barBlur = 0.0,
    double overlayBlur = 0.0,
    Color? overlayColor,
    Form? userInputForm,
  }) {
    final getSnackBar = GetSnackBar(
      snackbarStatus: snackbarStatus,
      title: title,
      message: message,
      titleText: titleText,
      messageText: messageText,
      snackPosition: snackPosition,
      borderRadius: borderRadius,
      margin: margin,
      duration: duration,
      barBlur: barBlur,
      backgroundColor: backgroundColor,
      icon: icon,
      shouldIconPulse: shouldIconPulse,
      maxWidth: maxWidth,
      padding: padding,
      borderColor: borderColor,
      borderWidth: borderWidth,
      leftBarIndicatorColor: leftBarIndicatorColor,
      boxShadows: boxShadows,
      backgroundGradient: backgroundGradient,
      mainButton: mainButton,
      onTap: onTap,
      isDismissible: isDismissible,
      dismissDirection: dismissDirection,
      showProgressIndicator: showProgressIndicator,
      progressIndicatorController: progressIndicatorController,
      progressIndicatorBackgroundColor: progressIndicatorBackgroundColor,
      progressIndicatorValueColor: progressIndicatorValueColor,
      snackStyle: snackStyle,
      forwardAnimationCurve: forwardAnimationCurve,
      reverseAnimationCurve: reverseAnimationCurve,
      animationDuration: animationDuration,
      overlayBlur: overlayBlur,
      overlayColor: overlayColor,
      userInputForm: userInputForm,
    );

    final controller = SnackBarController(getSnackBar);

    if (instantInit) {
      controller.show();
    } else {
      ambiguate(SchedulerBinding.instance)?.addPostFrameCallback((_) {
        controller.show();
      });
    }
    return controller;
  }

  SnackBarController showSnackbar(GetSnackBar snackbar) {
    final controller = SnackBarController(snackbar);
    controller.show();
    return controller;
  }

  SnackBarController snackbar(
    String title,
    String message, {
    Color? colorText,
    Duration? duration = const Duration(seconds: 3),

    /// with instantInit = false you can put snackbar on initState
    bool instantInit = true,
    SnackPosition? snackPosition,
    Widget? titleText,
    Widget? messageText,
    Widget? icon,
    bool? shouldIconPulse,
    double? maxWidth,
    EdgeInsets? margin,
    EdgeInsets? padding,
    double? borderRadius,
    Color? borderColor,
    double? borderWidth,
    Color? backgroundColor,
    Color? leftBarIndicatorColor,
    List<BoxShadow>? boxShadows,
    Gradient? backgroundGradient,
    TextButton? mainButton,
    OnTap? onTap,
    bool? isDismissible,
    bool? showProgressIndicator,
    DismissDirection? dismissDirection,
    AnimationController? progressIndicatorController,
    Color? progressIndicatorBackgroundColor,
    Animation<Color>? progressIndicatorValueColor,
    SnackStyle? snackStyle,
    Curve? forwardAnimationCurve,
    Curve? reverseAnimationCurve,
    Duration? animationDuration,
    double? barBlur,
    double? overlayBlur,
    SnackbarStatusCallback? snackbarStatus,
    Color? overlayColor,
    Form? userInputForm,
  }) {
    final getSnackBar = GetSnackBar(
      snackbarStatus: snackbarStatus,
      titleText:
          titleText ??
          Text(
            title,
            style: TextStyle(
              color: colorText ?? iconColor ?? Colors.black,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
      messageText:
          messageText ??
          Text(
            message,
            style: TextStyle(
              color: colorText ?? iconColor ?? Colors.black,
              fontWeight: FontWeight.w300,
              fontSize: 14,
            ),
          ),
      snackPosition: snackPosition ?? SnackPosition.top,
      borderRadius: borderRadius ?? 15,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 10),
      duration: duration,
      barBlur: barBlur ?? 7.0,
      backgroundColor: backgroundColor ?? Colors.grey.withValues(alpha: 0.2),
      icon: icon,
      shouldIconPulse: shouldIconPulse ?? true,
      maxWidth: maxWidth,
      padding: padding ?? const EdgeInsets.all(16),
      borderColor: borderColor,
      borderWidth: borderWidth,
      leftBarIndicatorColor: leftBarIndicatorColor,
      boxShadows: boxShadows,
      backgroundGradient: backgroundGradient,
      mainButton: mainButton,
      onTap: onTap,
      isDismissible: isDismissible ?? true,
      dismissDirection: dismissDirection,
      showProgressIndicator: showProgressIndicator ?? false,
      progressIndicatorController: progressIndicatorController,
      progressIndicatorBackgroundColor: progressIndicatorBackgroundColor,
      progressIndicatorValueColor: progressIndicatorValueColor,
      snackStyle: snackStyle ?? SnackStyle.floating,
      forwardAnimationCurve: forwardAnimationCurve ?? Curves.easeOutCirc,
      reverseAnimationCurve: reverseAnimationCurve ?? Curves.easeOutCirc,
      animationDuration: animationDuration ?? const Duration(seconds: 1),
      overlayBlur: overlayBlur ?? 0.0,
      overlayColor: overlayColor ?? Colors.transparent,
      userInputForm: userInputForm,
    );

    final controller = SnackBarController(getSnackBar);

    if (instantInit) {
      controller.show();
    } else {
      //routing.isSnackbar = true;
      ambiguate(SchedulerBinding.instance)?.addPostFrameCallback((_) {
        controller.show();
      });
    }
    return controller;
  }
}

extension GetNavigation on GetInterface {
  /// **Navigation.push()** shortcut.<br><br>
  ///
  /// Pushes a new `page` to the stack
  ///
  /// It has the advantage of not needing context,
  /// so you can call from your business logic
  ///
  /// You can set a custom [transition], and a transition [duration].
  ///
  /// You can send any type of value to the other route in the [arguments].
  ///
  /// Just like native routing in Flutter, you can push a route
  /// as a [fullscreenDialog],
  ///
  /// [id] is for when you are using nested navigation,
  /// as explained in documentation
  ///
  /// If you want the same behavior of ios that pops a route when the user drag,
  /// you can set [popGesture] to true
  ///
  /// If you're using the [Bindings] api, you must define it here
  ///
  /// By default, GetX will prevent you from push a route that you already in,
  /// if you want to push anyway, set [preventDuplicates] to false
  ///
  /// Example:
  /// ```dart
  /// // Basic navigation
  /// Get.to(() => HomePage());
  ///
  /// // Conditional navigation based on login status
  /// Get.to(
  ///   () => HomePage(),
  ///   condition: ConditionalNavigation(
  ///     condition: () => AuthService.isLoggedIn,
  ///     truePage: () => HomePage(),
  ///     falsePage: () => LoginPage(),
  ///   ),
  /// );
  ///
  /// // Conditional navigation with custom transition
  /// Get.to(
  ///   () => SettingsPage(),
  ///   condition: ConditionalNavigation(
  ///     condition: () => UserPermissions.hasAccess,
  ///     truePage: () => SettingsPage(),
  ///     falsePage: () => AccessDeniedPage(),
  ///   ),
  ///   transition: Transition.rightToLeft,
  ///   duration: Duration(milliseconds: 500),
  /// );
  ///
  /// // Conditional navigation with arguments
  /// Get.to(
  ///   () => ProfilePage(),
  ///   condition: ConditionalNavigation(
  ///     condition: () => UserService.hasProfile,
  ///     truePage: () => ProfilePage(),
  ///     falsePage: () => CreateProfilePage(),
  ///   ),
  ///   arguments: {'userId': 123},
  /// );
  /// ```
  Future<T?>? to<T>(
    dynamic page, {
    bool? opaque,
    Transition? transition,
    Curve? curve,
    Duration? duration,
    int? id,
    String? routeName,
    bool fullscreenDialog = false,
    dynamic arguments,
    Bindings? binding,
    bool preventDuplicates = true,
    bool? popGesture,
    double Function(BuildContext context)? gestureWidth,
    ConditionalNavigation? condition,
  }) {
    if (condition != null) {
      page = condition.evaluate();
    }

    routeName ??= "/${page.runtimeType}";
    routeName = _cleanRouteName(routeName);
    if (preventDuplicates && routeName == currentRoute) {
      return null;
    }
    return global(id).currentState?.push<T>(
      GetPageRoute<T>(
        opaque: opaque ?? true,
        page: _resolvePage(page, 'to'),
        routeName: routeName,
        gestureWidth: gestureWidth,
        settings: RouteSettings(name: routeName, arguments: arguments),
        popGesture: popGesture ?? defaultPopGesture,
        transition: transition ?? defaultTransition,
        curve: curve ?? defaultTransitionCurve,
        fullscreenDialog: fullscreenDialog,
        binding: binding,
        transitionDuration: duration ?? defaultTransitionDuration,
      ),
    );
  }

  GetPageBuilder _resolvePage(dynamic page, String method) {
    if (page is GetPageBuilder) {
      return page;
    } else if (page is Widget) {
      Get.log(
        '''WARNING, consider using: "Get.$method(() => Page())" instead of "Get.$method(Page())".
Using a widget function instead of a widget fully guarantees that the widget and its controllers will be removed from memory when they are no longer used.
      ''',
      );
      return () => page;
    } else if (page is String) {
      throw '''Unexpected String,
use toNamed() instead''';
    } else {
      throw '''Unexpected format,
you can only use widgets and widget functions here''';
    }
  }

  /// **Navigation.pushNamed()** shortcut.<br><br>
  ///
  /// Pushes a new named `page` to the stack.
  ///
  /// It has the advantage of not needing context, so you can call
  /// from your business logic.
  ///
  /// You can send any type of value to the other route in the [arguments].
  ///
  /// [id] is for when you are using nested navigation,
  /// as explained in documentation
  ///
  /// By default, GetX will prevent you from push a route that you already in,
  /// if you want to push anyway, set [preventDuplicates] to false
  ///
  /// Note: Always put a slash on the route ('/page1'), to avoid unnexpected errors
  Future<T?>? toNamed<T>(
    String page, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) {
    if (preventDuplicates && page == currentRoute) {
      return null;
    }

    if (parameters != null) {
      final uri = Uri(path: page, queryParameters: parameters);
      page = uri.toString();
    }

    return global(id).currentState?.pushNamed<T>(page, arguments: arguments);
  }

  /// **Navigation.pushReplacementNamed()** shortcut.<br><br>
  ///
  /// Pop the current named `page` in the stack and push a new one in its place
  ///
  /// It has the advantage of not needing context, so you can call
  /// from your business logic.
  ///
  /// You can send any type of value to the other route in the [arguments].
  ///
  /// [id] is for when you are using nested navigation,
  /// as explained in documentation
  ///
  /// By default, GetX will prevent you from push a route that you already in,
  /// if you want to push anyway, set [preventDuplicates] to false
  ///
  /// Note: Always put a slash on the route ('/page1'), to avoid unnexpected errors
  Future<T?>? offNamed<T>(
    String page, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) {
    if (preventDuplicates && page == currentRoute) {
      return null;
    }

    if (parameters != null) {
      final uri = Uri(path: page, queryParameters: parameters);
      page = uri.toString();
    }
    return global(
      id,
    ).currentState?.pushReplacementNamed(page, arguments: arguments);
  }

  /// **Navigation.popUntil()** shortcut.<br><br>
  ///
  /// Calls pop several times in the stack until [predicate] returns true
  ///
  /// [id] is for when you are using nested navigation,
  /// as explained in documentation
  ///
  /// [predicate] can be used like this:
  /// `Get.until((route) => Get.currentRoute == '/home')`so when you get to home page,
  ///
  /// or also like this:
  /// `Get.until((route) => !Get.isDialogOpen())`, to make sure the
  /// dialog is closed
  void until(RoutePredicate predicate, {int? id}) {
    // if (key.currentState.mounted) // add this if appear problems on future with route navigate
    // when widget don't mounted
    return global(id).currentState?.popUntil(predicate);
  }

  /// **Navigation.pushAndRemoveUntil()** shortcut.<br><br>
  ///
  /// Push the given `page`, and then pop several pages in the stack until
  /// [predicate] returns true
  ///
  /// [id] is for when you are using nested navigation,
  /// as explained in documentation
  ///
  /// Obs: unlike other get methods, this one you need to send a function
  /// that returns the widget to the page argument, like this:
  /// Get.offUntil(GetPageRoute(page: () => HomePage()), predicate)
  ///
  /// [predicate] can be used like this:
  /// `Get.offUntil(page, (route) => (route as GetPageRoute).routeName == '/home')`
  /// to pop routes in stack until home,
  /// or also like this:
  /// `Get.until((route) => !Get.isDialogOpen())`, to make sure the dialog
  /// is closed
  Future<T?>? offUntil<T>(Route<T> page, RoutePredicate predicate, {int? id}) {
    // if (key.currentState.mounted) // add this if appear problems on future with route navigate
    // when widget don't mounted
    return global(id).currentState?.pushAndRemoveUntil<T>(page, predicate);
  }

  /// **Navigation.pushNamedAndRemoveUntil()** shortcut.<br><br>
  ///
  /// Push the given named `page`, and then pop several pages in the stack
  /// until [predicate] returns true
  ///
  /// You can send any type of value to the other route in the [arguments].
  ///
  /// [id] is for when you are using nested navigation,
  /// as explained in documentation
  ///
  /// [predicate] can be used like this:
  /// `Get.offNamedUntil(page, ModalRoute.withName('/home'))`
  /// to pop routes in stack until home,
  /// or like this:
  /// `Get.offNamedUntil((route) => !Get.isDialogOpen())`,
  /// to make sure the dialog is closed
  ///
  /// Note: Always put a slash on the route name ('/page1'), to avoid unexpected errors
  Future<T?>? offNamedUntil<T>(
    String page,
    RoutePredicate predicate, {
    int? id,
    dynamic arguments,
    Map<String, String>? parameters,
  }) {
    if (parameters != null) {
      final uri = Uri(path: page, queryParameters: parameters);
      page = uri.toString();
    }

    return global(id).currentState?.pushNamedAndRemoveUntil<T>(
      page,
      predicate,
      arguments: arguments,
    );
  }

  /// **Navigation.popAndPushNamed()** shortcut.<br><br>
  ///
  /// Pop the current named page and pushes a new `page` to the stack
  /// in its place
  ///
  /// You can send any type of value to the other route in the [arguments].
  /// It is very similar to `offNamed()` but use a different approach
  ///
  /// The `offNamed()` pop a page, and goes to the next. The
  /// `offAndToNamed()` goes to the next page, and removes the previous one.
  /// The route transition animation is different.
  Future<T?>? offAndToNamed<T>(
    String page, {
    dynamic arguments,
    int? id,
    dynamic result,
    Map<String, String>? parameters,
  }) {
    if (parameters != null) {
      final uri = Uri(path: page, queryParameters: parameters);
      page = uri.toString();
    }
    return global(
      id,
    ).currentState?.popAndPushNamed(page, arguments: arguments, result: result);
  }

  /// **Navigation.removeRoute()** shortcut.<br><br>
  ///
  /// Remove a specific [route] from the stack
  ///
  /// [id] is for when you are using nested navigation,
  /// as explained in documentation
  void removeRoute(Route<dynamic> route, {int? id}) {
    return global(id).currentState?.removeRoute(route);
  }

  /// **Navigation.pushNamedAndRemoveUntil()** shortcut.<br><br>
  ///
  /// Push a named `page` and pop several pages in the stack
  /// until [predicate] returns true. [predicate] is optional
  ///
  /// It has the advantage of not needing context, so you can
  /// call from your business logic.
  ///
  /// You can send any type of value to the other route in the [arguments].
  ///
  /// [predicate] can be used like this:
  /// `Get.until((route) => Get.currentRoute == '/home')`so when you get to home page,
  /// or also like
  /// `Get.until((route) => !Get.isDialogOpen())`, to make sure the dialog
  /// is closed
  ///
  /// [id] is for when you are using nested navigation,
  /// as explained in documentation
  ///
  /// Note: Always put a slash on the route ('/page1'), to avoid unexpected errors
  Future<T?>? offAllNamed<T>(
    String newRouteName, {
    RoutePredicate? predicate,
    dynamic arguments,
    int? id,
    Map<String, String>? parameters,
  }) {
    if (parameters != null) {
      final uri = Uri(path: newRouteName, queryParameters: parameters);
      newRouteName = uri.toString();
    }

    return global(id).currentState?.pushNamedAndRemoveUntil<T>(
      newRouteName,
      predicate ?? (_) => false,
      arguments: arguments,
    );
  }

  /// Returns true if a Snackbar, Dialog or BottomSheet is currently OPEN
  bool get isOverlaysOpen =>
      (isSnackbarOpen || isDialogOpen! || isBottomSheetOpen!);

  /// Returns true if there is no Snackbar, Dialog or BottomSheet open
  bool get isOverlaysClosed =>
      (!isSnackbarOpen && !isDialogOpen! && !isBottomSheetOpen!);

  /// **Navigation.popUntil()** shortcut.<br><br>
  ///
  /// Pop the current page, snackbar, dialog or bottomsheet in the stack
  ///
  /// if your set [closeOverlays] to true, Get.back() will close the
  /// currently open snackbar/dialog/bottomsheet AND the current page
  ///
  /// [id] is for when you are using nested navigation,
  /// as explained in documentation
  ///
  /// It has the advantage of not needing context, so you can call
  /// from your business logic.
  void back<T>({
    T? result,
    bool closeOverlays = false,
    bool canPop = true,
    int? id,
  }) {
    if (isSnackbarOpen && !closeOverlays) {
      closeCurrentSnackbar();
      return;
    }

    if (closeOverlays && isOverlaysOpen) {
      if (isSnackbarOpen) {
        closeAllSnackbars();
      }
      navigator?.popUntil((route) {
        return (!isDialogOpen! && !isBottomSheetOpen!);
      });
    }
    if (canPop) {
      if (global(id).currentState?.canPop() == true) {
        global(id).currentState?.pop<T>(result);
      }
    } else {
      global(id).currentState?.pop<T>(result);
    }
  }

  /// **Navigation.popUntil()** (with predicate) shortcut .<br><br>
  ///
  /// Close as many routes as defined by [times]
  ///
  /// [id] is for when you are using nested navigation,
  /// as explained in documentation
  void close(int times, [int? id]) {
    if (times < 1) {
      times = 1;
    }
    var count = 0;
    var back = global(id).currentState?.popUntil((route) => count++ == times);

    return back;
  }

  /// **Navigation.pushReplacement()** shortcut .<br><br>
  ///
  /// Pop the current page and pushes a new `page` to the stack
  ///
  /// It has the advantage of not needing context,
  /// so you can call from your business logic
  ///
  /// You can set a custom [transition], define a Tween [curve],
  /// and a transition [duration].
  ///
  /// You can send any type of value to the other route in the [arguments].
  ///
  /// Just like native routing in Flutter, you can push a route
  /// as a [fullscreenDialog],
  ///
  /// [id] is for when you are using nested navigation,
  /// as explained in documentation
  ///
  /// If you want the same behavior of ios that pops a route when the user drag,
  /// you can set [popGesture] to true
  ///
  /// If you're using the [Bindings] api, you must define it here
  ///
  /// By default, GetX will prevent you from push a route that you already in,
  /// if you want to push anyway, set [preventDuplicates] to false
  ///
  /// Example:
  /// ```dart
  /// // Basic replacement navigation
  /// Get.off(() => HomePage());
  ///
  /// // Conditional replacement navigation
  /// Get.off(
  ///   () => HomePage(),
  ///   condition: ConditionalNavigation(
  ///     condition: () => AuthService.isLoggedIn,
  ///     truePage: () => HomePage(),
  ///     falsePage: () => LoginPage(),
  ///   ),
  /// );
  /// ```
  Future<T?>? off<T>(
    dynamic page, {
    bool opaque = false,
    Transition? transition,
    Curve? curve,
    bool? popGesture,
    int? id,
    String? routeName,
    dynamic arguments,
    Bindings? binding,
    bool fullscreenDialog = false,
    bool preventDuplicates = true,
    Duration? duration,
    double Function(BuildContext context)? gestureWidth,
    ConditionalNavigation? condition,
  }) {
    if (condition != null) {
      page = condition.evaluate();
    }

    routeName ??= "/${page.runtimeType.toString()}";
    routeName = _cleanRouteName(routeName);
    if (preventDuplicates && routeName == currentRoute) {
      return null;
    }
    return global(id).currentState?.pushReplacement(
      GetPageRoute(
        opaque: opaque,
        gestureWidth: gestureWidth,
        page: _resolvePage(page, 'off'),
        binding: binding,
        settings: RouteSettings(arguments: arguments, name: routeName),
        routeName: routeName,
        fullscreenDialog: fullscreenDialog,
        popGesture: popGesture ?? defaultPopGesture,
        transition: transition ?? defaultTransition,
        curve: curve ?? defaultTransitionCurve,
        transitionDuration: duration ?? defaultTransitionDuration,
      ),
    );
  }

  ///
  /// Push a `page` and pop several pages in the stack
  /// until [predicate] returns true. [predicate] is optional
  ///
  /// It has the advantage of not needing context,
  /// so you can call from your business logic
  ///
  /// You can set a custom [transition], a [curve] and a transition [duration].
  ///
  /// You can send any type of value to the other route in the [arguments].
  ///
  /// Just like native routing in Flutter, you can push a route
  /// as a [fullscreenDialog],
  ///
  /// [predicate] can be used like this:
  /// `Get.until((route) => Get.currentRoute == '/home')`so when you get to home page,
  /// or also like
  /// `Get.until((route) => !Get.isDialogOpen())`, to make sure the dialog
  /// is closed
  ///
  /// [id] is for when you are using nested navigation,
  /// as explained in documentation
  ///
  /// If you want the same behavior of ios that pops a route when the user drag,
  /// you can set [popGesture] to true
  ///
  /// If you're using the [Bindings] api, you must define it here
  ///
  /// By default, GetX will prevent you from push a route that you already in,
  /// if you want to push anyway, set [preventDuplicates] to false
  ///
  /// Example:
  /// ```dart
  /// // Basic navigation removing all previous routes
  /// Get.offAll(() => HomePage());
  ///
  /// // Conditional navigation
  /// Get.offAll(
  ///   () => HomePage(),
  ///   condition: ConditionalNavigation(
  ///     condition: () => UserService.isFirstTime,
  ///     truePage: () => OnboardingPage(),
  ///     falsePage: () => HomePage(),
  ///   ),
  /// );
  /// ```
  Future<T?>? offAll<T>(
    dynamic page, {
    RoutePredicate? predicate,
    bool opaque = false,
    bool? popGesture,
    int? id,
    String? routeName,
    dynamic arguments,
    Bindings? binding,
    bool fullscreenDialog = false,
    Transition? transition,
    Curve? curve,
    Duration? duration,
    double Function(BuildContext context)? gestureWidth,
    ConditionalNavigation? condition,
  }) {
    if (condition != null) {
      page = condition.evaluate();
    }

    routeName ??= "/${page.runtimeType.toString()}";
    routeName = _cleanRouteName(routeName);
    return global(id).currentState?.pushAndRemoveUntil<T>(
      GetPageRoute<T>(
        opaque: opaque,
        popGesture: popGesture ?? defaultPopGesture,
        page: _resolvePage(page, 'offAll'),
        binding: binding,
        gestureWidth: gestureWidth,
        settings: RouteSettings(name: routeName, arguments: arguments),
        fullscreenDialog: fullscreenDialog,
        routeName: routeName,
        transition: transition ?? defaultTransition,
        curve: curve ?? defaultTransitionCurve,
        transitionDuration: duration ?? defaultTransitionDuration,
      ),
      predicate ?? (route) => false,
    );
  }

  /// Takes a route [name] String generated by [to], [off], [offAll]
  /// (and similar context navigation methods), cleans the extra chars and
  /// accommodates the format.

  /// `() => MyHomeScreenView` becomes `/my-home-screen-view`.
  String _cleanRouteName(String name) {
    name = name.replaceAll('() => ', '');

    /// uncommonent for URL styling.
    // name = name.paramCase!;
    if (!name.startsWith('/')) {
      name = '/$name';
    }
    return Uri.tryParse(name)?.toString() ?? name;
  }

  /// change default config of Get
  void config({
    bool? enableLog,
    LogWriterCallback? logWriterCallback,
    bool? defaultPopGesture,
    bool? defaultOpaqueRoute,
    Duration? defaultDurationTransition,
    bool? defaultGlobalState,
    Transition? defaultTransition,
  }) {
    if (enableLog != null) {
      Get.isLogEnable = enableLog;
    }
    if (logWriterCallback != null) {
      Get.log = logWriterCallback;
    }
    if (defaultPopGesture != null) {
      _getxController.defaultPopGesture = defaultPopGesture;
    }
    if (defaultOpaqueRoute != null) {
      _getxController.defaultOpaqueRoute = defaultOpaqueRoute;
    }
    if (defaultTransition != null) {
      _getxController.defaultTransition = defaultTransition;
    }

    if (defaultDurationTransition != null) {
      _getxController.defaultTransitionDuration = defaultDurationTransition;
    }
  }

  Future<void> updateLocale(Locale l) async {
    Get.locale = l;
    await forceAppUpdate();
  }

  /// As a rule, Flutter knows which widget to update,
  /// so this command is rarely needed. We can mention situations
  /// where you use const so that widgets are not updated with setState,
  /// but you want it to be forcefully updated when an event like
  /// language change happens. using context to make the widget dirty
  /// for performRebuild() is a viable solution.
  /// However, in situations where this is not possible, or at least,
  /// is not desired by the developer, the only solution for updating
  /// widgets that Flutter does not want to update is to use reassemble
  /// to forcibly rebuild all widgets. Attention: calling this function will
  /// reconstruct the application from the sketch, use this with caution.
  /// Your entire application will be rebuilt, and touch events will not
  /// work until the end of rendering.
  Future<void> forceAppUpdate() async {
    await engine.performReassemble();
  }

  void appUpdate() => _getxController.update();

  void changeTheme(ThemeData theme) {
    _getxController.setTheme(theme);
  }

  void changeThemeMode(ThemeMode themeMode) {
    _getxController.setThemeMode(themeMode);
  }

  GlobalKey<NavigatorState>? addKey(GlobalKey<NavigatorState> newKey) {
    return _getxController.addKey(newKey);
  }

  GlobalKey<NavigatorState>? nestedKey(dynamic key) {
    keys.putIfAbsent(
      key,
      () => GlobalKey<NavigatorState>(
        debugLabel: 'Getx nested key: ${key.toString()}',
      ),
    );
    return keys[key];
  }

  GlobalKey<NavigatorState> global(int? k) {
    GlobalKey<NavigatorState> newKey;
    if (k == null) {
      newKey = key;
    } else {
      if (!keys.containsKey(k)) {
        throw 'Route id ($k) not found';
      }
      newKey = keys[k]!;
    }

    if (newKey.currentContext == null && !testMode) {
      throw """You are trying to use contextless navigation without
      a GetMaterialApp or Get.key.
      If you are testing your app, you can use:
      [Get.testMode = true], or if you are running your app on
      a physical device or emulator, you must exchange your [MaterialApp]
      for a [GetMaterialApp].
      """;
    }

    return newKey;
  }

  /// give current arguments
  dynamic get arguments => routing.args;

  /// give name from current route
  String get currentRoute => routing.current;

  /// give name from previous route
  String get previousRoute => routing.previous;

  /// check if snackbar is open
  bool get isSnackbarOpen =>
      SnackBarController.isSnackBarBeingShown; //routing.isSnackbar;

  void closeAllSnackbars() {
    SnackBarController.cancelAllSnackbars();
  }

  Future<void> closeCurrentSnackbar() async {
    await SnackBarController.closeCurrentSnackbar();
  }

  /// check if dialog is open
  bool? get isDialogOpen => routing.isDialog;

  /// check if bottomsheet is open
  bool? get isBottomSheetOpen => routing.isBottomSheet;

  /// check a raw current route
  Route<dynamic>? get rawRoute => routing.route;

  /// check if popGesture is enable
  bool get isPopGestureEnable => defaultPopGesture;

  /// check if default opaque route is enable
  bool get isOpaqueRouteDefault => defaultOpaqueRoute;

  /// give access to currentContext
  BuildContext? get context => key.currentContext;

  /// give access to current Overlay Context
  BuildContext? get overlayContext {
    BuildContext? overlay;

    // First try to get overlay from navigator key
    final navigatorState = key.currentState;
    if (navigatorState != null) {
      final overlayState = navigatorState.overlay;
      if (overlayState != null) {
        overlayState.context.visitChildElements((element) {
          overlay = element;
        });
      }
    }

    // If overlay is still null, try to use the navigator context directly
    // This handles cases where the overlay hasn't been built yet
    if (overlay == null) {
      overlay = key.currentContext;
    }

    return overlay;
  }

  /// give access to Theme.of(context)
  ThemeData get theme {
    var theme = ThemeData.fallback();
    final ctx = context;
    if (ctx != null) {
      theme = Theme.of(ctx);
    }
    return theme;
  }

  ///The current [WidgetsBinding]
  WidgetsBinding get engine {
    return WidgetsFlutterBinding.ensureInitialized();
  }

  /// The window to which this binding is bound.
  FlutterView? get window {
    final ctx = context;
    if (ctx == null) return PlatformDispatcher.instance.views.first;
    return View.of(ctx);
  }

  Locale? get deviceLocale => PlatformDispatcher.instance.locale;

  ///The number of device pixels for each logical pixel.
  double get pixelRatio => window?.devicePixelRatio ?? 1.0;

  Size get size {
    final currentWindow = window;
    if (currentWindow == null) return Size.zero;
    return currentWindow.physicalSize / currentWindow.devicePixelRatio;
  }

  ///The horizontal extent of this size.
  double get width => size.width;

  ///The vertical extent of this size
  double get height => size.height;

  ///The distance from the top edge to the first unpadded pixel,
  ///in physical pixels.
  double get statusBarHeight => window?.padding.top ?? 0;

  ///The distance from the bottom edge to the first unpadded pixel,
  ///in physical pixels.
  double get bottomBarHeight => window?.padding.bottom ?? 0;

  ///The system-reported text scale.
  double get textScaleFactor => PlatformDispatcher.instance.textScaleFactor;

  /// give access to TextTheme.of(context)
  TextTheme get textTheme => theme.textTheme;

  /// give access to Mediaquery.of(context)
  MediaQueryData get mediaQuery {
    final ctx = context;
    if (ctx == null) {
      throw Exception(
        'GetX context is not available. Make sure you are using GetMaterialApp.',
      );
    }
    return MediaQuery.of(ctx);
  }

  /// Check if dark mode theme is enable
  bool get isDarkMode => (theme.brightness == Brightness.dark);

  /// Check if dark mode theme is enable on platform on android Q+
  bool get isPlatformDarkMode =>
      (PlatformDispatcher.instance.platformBrightness == Brightness.dark);

  /// give access to Theme.of(context).iconTheme.color
  Color? get iconColor => theme.iconTheme.color;

  /// give access to FocusScope.of(context)
  FocusNode? get focusScope => FocusManager.instance.primaryFocus;

  // /// give access to Immutable MediaQuery.of(context).size.height
  // double get height => MediaQuery.of(context).size.height;

  // /// give access to Immutable MediaQuery.of(context).size.width
  // double get width => MediaQuery.of(context).size.width;

  GlobalKey<NavigatorState> get key => _getxController.key;

  Map<dynamic, GlobalKey<NavigatorState>> get keys => _getxController.keys;

  GetMaterialController get rootController => _getxController;

  bool get defaultPopGesture => _getxController.defaultPopGesture;
  bool get defaultOpaqueRoute => _getxController.defaultOpaqueRoute;

  Transition? get defaultTransition => _getxController.defaultTransition;

  Duration get defaultTransitionDuration {
    return _getxController.defaultTransitionDuration;
  }

  Curve get defaultTransitionCurve => _getxController.defaultTransitionCurve;

  Curve get defaultDialogTransitionCurve {
    return _getxController.defaultDialogTransitionCurve;
  }

  Duration get defaultDialogTransitionDuration {
    return _getxController.defaultDialogTransitionDuration;
  }

  Routing get routing => _getxController.routing;

  Map<String, String?> get parameters => _getxController.parameters;
  set parameters(Map<String, String?> newParameters) =>
      _getxController.parameters = newParameters;

  CustomTransition? get customTransition => _getxController.customTransition;
  set customTransition(CustomTransition? newTransition) =>
      _getxController.customTransition = newTransition;

  bool get testMode => _getxController.testMode;
  set testMode(bool isTest) => _getxController.testMode = isTest;

  void resetRootNavigator() {
    _getxController = GetMaterialController();
  }

  static GetMaterialController _getxController = GetMaterialController();
}

extension NavTwoExt on GetInterface {
  void addPages(List<GetPage> getPages) {
    routeTree.addRoutes(getPages);
  }

  void clearRouteTree() {
    _routeTree.routes.clear();
  }

  static final _routeTree = ParseRouteTree(routes: []);

  ParseRouteTree get routeTree => _routeTree;
  void addPage(GetPage getPage) {
    routeTree.addRoute(getPage);
  }

  /// Casts the stored router delegate to a desired type
  TDelegate? delegate<TDelegate extends RouterDelegate<TPage>, TPage>() =>
      routerDelegate as TDelegate?;

  // // ignore: use_setters_to_change_properties
  // void setDefaultDelegate(RouterDelegate? delegate) {
  //   _routerDelegate = delegate;
  // }

  // GetDelegate? getDelegate() => delegate<GetDelegate, GetNavConfig>();

  GetInformationParser createInformationParser({String initialRoute = '/'}) {
    if (routeInformationParser == null) {
      return routeInformationParser = GetInformationParser(
        initialRoute: initialRoute,
      );
    } else {
      return routeInformationParser as GetInformationParser;
    }
  }

  // static GetDelegate? _delegate;

  GetDelegate get rootDelegate => createDelegate();

  GetDelegate createDelegate({
    GetPage<dynamic>? notFoundRoute,
    List<NavigatorObserver>? navigatorObservers,
    TransitionDelegate<dynamic>? transitionDelegate,
    PopMode backButtonPopMode = PopMode.History,
    PreventDuplicateHandlingMode preventDuplicateHandlingMode =
        PreventDuplicateHandlingMode.ReorderRoutes,
  }) {
    if (routerDelegate == null) {
      return routerDelegate = GetDelegate(
        notFoundRoute: notFoundRoute,
        navigatorObservers: navigatorObservers,
        transitionDelegate: transitionDelegate,
        backButtonPopMode: backButtonPopMode,
        preventDuplicateHandlingMode: preventDuplicateHandlingMode,
      );
    } else {
      return routerDelegate as GetDelegate;
    }
  }
}

extension OverlayExt on GetInterface {
  /// Displays an overlay with a loading indicator while an asynchronous function is executed.
  ///
  /// Parameters:
  /// - `asyncFunction`: The asynchronous function to be executed.
  /// - `opacityColor`: The color of the overlay background. Default is black.
  /// - `loadingWidget`: The widget to be displayed while loading. Default is a centered text saying 'Loading...'.
  /// - `opacity`: The opacity level of the overlay background. Default is 0.5.
  ///
  /// Returns the result of the asynchronous function.
  Future<T> showOverlay<T>({
    required Future<T> Function() asyncFunction,
    Color opacityColor = Colors.black,
    Widget? loadingWidget,
    double opacity = 0.5,
  }) async {
    // Get the current navigator and overlay state
    final overlayCtx = Get.overlayContext;
    if (overlayCtx == null) {
      throw Exception(
        'GetX overlay context is not available. Make sure you are using GetMaterialApp.',
      );
    }
    final navigatorState = Navigator.of(overlayCtx, rootNavigator: false);
    final overlayState = navigatorState.overlay!;

    // Create an overlay entry for the background opacity
    final overlayEntryOpacity = OverlayEntry(
      builder: (context) {
        return Opacity(
          opacity: opacity,
          child: Container(color: opacityColor),
        );
      },
    );

    // Create an overlay entry for the loading widget
    final overlayEntryLoader = OverlayEntry(
      builder: (context) {
        return loadingWidget ??
            const Center(
              child: SizedBox(
                height: 90,
                width: 90,
                child:
                    CircularProgressIndicator(), // Improved loading indicator
              ),
            );
      },
    );

    // Insert the overlay entries into the overlay state
    overlayState.insert(overlayEntryOpacity);
    overlayState.insert(overlayEntryLoader);

    T data;

    try {
      // Execute the asynchronous function
      data = await asyncFunction();
    } on Exception catch (e) {
      // Remove the overlay entries in case of an exception
      overlayEntryLoader.remove();
      overlayEntryOpacity.remove();
      // Rethrow the exception after cleanup
      rethrow;
    }

    // Remove the overlay entries after the function completes
    overlayEntryLoader.remove();
    overlayEntryOpacity.remove();

    return data;
  }
}
