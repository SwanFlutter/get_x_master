import 'package:flutter/widgets.dart';

import '../../../../get_x_master.dart';

/// Mixin to provide responsive behavior for widgets.
mixin GetResponsiveMixin on Widget {
  /// Provides information about the screen size and type.
  ResponsiveScreen get screen;

  /// Determines whether to always use the `builder` method.
  bool get alwaysUseBuilder;

  @protected
  Widget build(BuildContext context) {
    screen.context = context;
    Widget? widget;

    // Always use builder if specified
    if (alwaysUseBuilder) {
      widget = builder();
      if (widget != null) return widget;
    }

    // Check screen type and return corresponding widget
    if (screen.isTV) {
      widget =
          tv() ?? largeDesktop() ?? desktop() ?? tablet() ?? phone() ?? watch();
      if (widget != null) return widget;
    }

    if (screen.isLargeDesktop) {
      widget = largeDesktop() ?? desktop() ?? tablet() ?? phone() ?? watch();
      if (widget != null) return widget;
    }

    if (screen.isDesktop) {
      widget = desktop() ?? tablet() ?? phone() ?? watch();
      if (widget != null) return widget;
    }

    if (screen.isLargeTablet) {
      widget = largeTablet() ?? tablet() ?? phone() ?? watch();
      if (widget != null) return widget;
    }

    if (screen.isTablet) {
      widget = tablet() ?? phone() ?? watch();
      if (widget != null) return widget;
    }

    if (screen.isPhone) {
      widget = phone() ?? watch();
      if (widget != null) return widget;
    }

    // Fallback to watch or builder
    return watch() ??
        phone() ??
        tablet() ??
        largeTablet() ??
        desktop() ??
        largeDesktop() ??
        tv() ??
        builder()!;
  }

  /// Default builder method. Override this to provide a default widget.
  Widget? builder() => null;

  /// Widget to be displayed on TV screens.
  Widget? tv() => null;

  /// Widget to be displayed on large desktop screens.
  Widget? largeDesktop() => null;

  /// Widget to be displayed on desktop screens.
  Widget? desktop() => null;

  /// Widget to be displayed on large tablet screens.
  Widget? largeTablet() => null;

  /// Widget to be displayed on tablet screens.
  Widget? tablet() => null;

  /// Widget to be displayed on phone screens.
  Widget? phone() => null;

  /// Widget to be displayed on watch screens.
  Widget? watch() => null;
}

/// A responsive view widget that adapts to different screen sizes, integrated with GetX.
class GetResponsiveView<T> extends GetView<T> with GetResponsiveMixin {
  @override
  final bool alwaysUseBuilder;

  @override
  final ResponsiveScreen screen;

  GetResponsiveView({
    this.alwaysUseBuilder = false,
    ResponsiveScreenSettings settings = const ResponsiveScreenSettings(),
    super.key,
  }) : screen = ResponsiveScreen(settings);

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }
}

/// A responsive widget that adapts to different screen sizes, integrated with GetX.
class GetResponsiveWidget<T extends GetLifeCycleBase?> extends StatelessWidget
    with GetResponsiveMixin {
  @override
  final bool alwaysUseBuilder;

  @override
  final ResponsiveScreen screen;

  GetResponsiveWidget({
    this.alwaysUseBuilder = false,
    ResponsiveScreenSettings settings = const ResponsiveScreenSettings(),
    super.key,
  }) : screen = ResponsiveScreen(settings);

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }
}

/// Settings for defining breakpoints for different screen types.
class ResponsiveScreenSettings {
  /// Breakpoint for TV screens.
  final double tvChangePoint;

  /// Breakpoint for large desktop screens.
  final double largeDesktopChangePoint;

  /// Breakpoint for desktop screens.
  final double desktopChangePoint;

  /// Breakpoint for large tablet screens.
  final double largeTabletChangePoint;

  /// Breakpoint for tablet screens.
  final double tabletChangePoint;

  /// Breakpoint for phone screens.
  final double phoneChangePoint;

  /// Breakpoint for watch screens.
  final double watchChangePoint;

  const ResponsiveScreenSettings({
    this.tvChangePoint = 1920,
    this.largeDesktopChangePoint = 1600,
    this.desktopChangePoint = 1200,
    this.largeTabletChangePoint = 720,
    this.tabletChangePoint = 600,
    this.phoneChangePoint = 300,
    this.watchChangePoint = 150,
  });
}

/// Provides information about the screen size and type, using ContextExt.
class ResponsiveScreen {
  late BuildContext context;
  final ResponsiveScreenSettings settings;

  late bool _isPlatformDesktop;

  ResponsiveScreen(this.settings) {
    _isPlatformDesktop = GetPlatform.isDesktop;
  }

  /// Returns the height of the screen.
  double get height => context.height;

  /// Returns the width of the screen.
  double get width => context.width;

  /// Checks if the screen type is TV.
  bool get isTV => screenType == ScreenType.tv;

  /// Checks if the screen type is large desktop.
  bool get isLargeDesktop => screenType == ScreenType.largeDesktop;

  /// Checks if the screen type is desktop.
  bool get isDesktop => screenType == ScreenType.desktop;

  /// Checks if the screen type is large tablet.
  bool get isLargeTablet => screenType == ScreenType.largeTablet;

  /// Checks if the screen type is tablet.
  bool get isTablet => screenType == ScreenType.tablet;

  /// Checks if the screen type is phone.
  bool get isPhone => screenType == ScreenType.phone;

  /// Checks if the screen type is watch.
  bool get isWatch => screenType == ScreenType.watch;

  /// Returns the device width based on the platform.
  double get _deviceWidth {
    if (_isPlatformDesktop) {
      return width;
    }
    return context.shortestSide;
  }

  /// Determines the screen type based on the device width.
  ScreenType get screenType {
    final deviceWidth = _deviceWidth;
    if (deviceWidth >= settings.tvChangePoint) return ScreenType.tv;
    if (deviceWidth >= settings.largeDesktopChangePoint)
      return ScreenType.largeDesktop;
    if (deviceWidth >= settings.desktopChangePoint) return ScreenType.desktop;
    if (deviceWidth >= settings.largeTabletChangePoint)
      return ScreenType.largeTablet;
    if (deviceWidth >= settings.tabletChangePoint) return ScreenType.tablet;
    if (deviceWidth >= settings.phoneChangePoint) return ScreenType.phone;
    return ScreenType.watch;
  }

  /// Returns a value based on the screen type.
  T? responsiveValue<T>({
    T? watch,
    T? phone,
    T? tablet,
    T? largeTablet,
    T? desktop,
    T? largeDesktop,
    T? tv,
  }) {
    if (isTV && tv != null) return tv;
    if (isLargeDesktop && largeDesktop != null) return largeDesktop;
    if (isDesktop && desktop != null) return desktop;
    if (isLargeTablet && largeTablet != null) return largeTablet;
    if (isTablet && tablet != null) return tablet;
    if (isPhone && phone != null) return phone;
    return watch;
  }
}

/// Enum representing different screen types.
enum ScreenType { watch, phone, tablet, largeTablet, desktop, largeDesktop, tv }
