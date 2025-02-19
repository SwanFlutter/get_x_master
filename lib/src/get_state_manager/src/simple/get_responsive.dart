

import 'package:flutter/widgets.dart';

import '../../../../get_x_master.dart';

/// A mixin to make widgets responsive based on screen size.
mixin GetResponsiveMixin on Widget {
  /// Provides information about the screen size and type.
  ResponsiveScreen get screen;

  /// Determines whether to always use the `builder` method.
  bool get alwaysUseBuilder;

  @protected
  Widget build(BuildContext context) {
    screen.context = context;
    Widget? widget;

    if (alwaysUseBuilder) {
      widget = builder();
      if (widget != null) return widget;
    }

    if (screen.isDesktop) {
      widget = desktop() ?? widget;
      if (widget != null) return widget;
    }

    if (screen.isTablet) {
      widget = tablet() ?? desktop();
      if (widget != null) return widget;
    }

    if (screen.isPhone) {
      widget = phone() ?? tablet() ?? desktop();
      if (widget != null) return widget;
    }

    return watch() ?? phone() ?? tablet() ?? desktop() ?? builder()!;
  }

  /// Default builder method. Override this to provide a default widget.
  Widget? builder() => null;

  /// Widget to be displayed on desktop screens.
  Widget? desktop() => null;

  /// Widget to be displayed on phone screens.
  Widget? phone() => null;

  /// Widget to be displayed on tablet screens.
  Widget? tablet() => null;

  /// Widget to be displayed on watch screens.
  Widget? watch() => null;
}

/// A responsive view widget that adapts to different screen sizes.
class GetResponsiveView<T> extends GetView<T> with GetResponsiveMixin {
  @override
  final bool alwaysUseBuilder;

  @override
  final ResponsiveScreen screen;

  GetResponsiveView(
      {this.alwaysUseBuilder = false,
      ResponsiveScreenSettings settings = const ResponsiveScreenSettings(),
      super.key})
      : screen = ResponsiveScreen(settings);

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }
}

/// A responsive widget that adapts to different screen sizes.
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
  /// Breakpoint for desktop screens.
  final double desktopChangePoint;

  /// Breakpoint for tablet screens.
  final double tabletChangePoint;

  /// Breakpoint for watch screens.
  final double watchChangePoint;

  const ResponsiveScreenSettings({
    this.desktopChangePoint = 1200,
    this.tabletChangePoint = 600,
    this.watchChangePoint = 300,
  });
}

/// Provides information about the screen size and type.
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

  /// Checks if the screen type is desktop.
  bool get isDesktop => screenType == ScreenType.desktop;

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
    return context.mediaQueryShortestSide;
  }

  /// Determines the screen type based on the device width.
  ScreenType get screenType {
    final deviceWidth = _deviceWidth;
    if (deviceWidth >= settings.desktopChangePoint) return ScreenType.desktop;
    if (deviceWidth >= settings.tabletChangePoint) return ScreenType.tablet;
    if (deviceWidth < settings.watchChangePoint) return ScreenType.watch;
    return ScreenType.phone;
  }

  /// Returns a value based on the screen type.
  T? responsiveValue<T>({
    T? mobile,
    T? tablet,
    T? desktop,
    T? watch,
  }) {
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    if (isPhone && mobile != null) return mobile;
    return watch;
  }
}

/// Enum representing different screen types.
enum ScreenType {
  watch,
  phone,
  tablet,
  desktop,
}
