import 'package:flutter/material.dart';

import 'responsive_builder.dart';

/// Real-time responsive extensions that update instantly when screen size changes
/// These extensions work with GetResponsiveBuilder to provide live updates

/// Extension for real-time responsive values within GetResponsiveBuilder context
extension RealtimeResponsiveExtension on num {
  /// Real-time responsive width - updates instantly when screen size changes
  /// Must be used within GetResponsiveBuilder context
  Widget rw(Widget Function(double width) builder) {
    return GetResponsiveBuilder(
      mode: ResponsiveMode.layoutBuilder,
      builder: (context, data) {
        return builder(data.w(toDouble()));
      },
    );
  }

  /// Real-time responsive height - updates instantly when screen size changes
  /// Must be used within GetResponsiveBuilder context
  Widget rh(Widget Function(double height) builder) {
    return GetResponsiveBuilder(
      mode: ResponsiveMode.layoutBuilder,
      builder: (context, data) {
        return builder(data.h(toDouble()));
      },
    );
  }

  /// Real-time responsive font size - updates instantly when screen size changes
  /// Must be used within GetResponsiveBuilder context
  Widget rsp(Widget Function(double fontSize) builder) {
    return GetResponsiveBuilder(
      mode: ResponsiveMode.layoutBuilder,
      builder: (context, data) {
        return builder(data.sp(toDouble()));
      },
    );
  }

  /// Real-time responsive widget size - updates instantly when screen size changes
  /// Must be used within GetResponsiveBuilder context
  Widget rws(Widget Function(double size) builder) {
    return GetResponsiveBuilder(
      mode: ResponsiveMode.layoutBuilder,
      builder: (context, data) {
        return builder(data.ws(toDouble()));
      },
    );
  }

  /// Real-time width percentage - updates instantly when screen size changes
  /// Must be used within GetResponsiveBuilder context
  Widget rwp(Widget Function(double width) builder) {
    return GetResponsiveBuilder(
      mode: ResponsiveMode.layoutBuilder,
      builder: (context, data) {
        return builder(data.wp(toDouble()));
      },
    );
  }

  /// Real-time height percentage - updates instantly when screen size changes
  /// Must be used within GetResponsiveBuilder context
  Widget rhp(Widget Function(double height) builder) {
    return GetResponsiveBuilder(
      mode: ResponsiveMode.layoutBuilder,
      builder: (context, data) {
        return builder(data.hp(toDouble()));
      },
    );
  }
}

/// Single-page responsive widget that updates values in real-time
class GetSinglePageResponsive extends StatelessWidget {
  final Widget Function(ResponsiveData data) builder;

  const GetSinglePageResponsive({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return GetResponsiveBuilder(
      mode: ResponsiveMode.singlePage,
      builder: (context, data) => builder(data),
    );
  }
}

/// Layout builder responsive widget for real-time updates
class GetLayoutBuilderResponsive extends StatelessWidget {
  final Widget Function(ResponsiveData data) builder;

  const GetLayoutBuilderResponsive({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return GetResponsiveBuilder(
      mode: ResponsiveMode.layoutBuilder,
      builder: (context, data) => builder(data),
    );
  }
}

/// Responsive text that updates font size in real-time
class GetResponsiveText extends StatelessWidget {
  final String text;
  final double fontSize;
  final TextStyle? style;
  final ResponsiveMode mode;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const GetResponsiveText(
    this.text, {
    super.key,
    required this.fontSize,
    this.style,
    this.mode = ResponsiveMode.layoutBuilder,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return GetResponsiveBuilder(
      mode: mode,
      builder: (context, data) {
        return Text(
          text,
          style: (style ?? const TextStyle()).copyWith(
            fontSize: data.sp(fontSize),
          ),
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
        );
      },
    );
  }
}

/// Responsive container that updates dimensions in real-time
class GetResponsiveContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;
  final ResponsiveMode mode;
  final AlignmentGeometry? alignment;

  const GetResponsiveContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.decoration,
    this.mode = ResponsiveMode.layoutBuilder,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return GetResponsiveBuilder(
      mode: mode,
      builder: (context, data) {
        return Container(
          width: width != null ? data.w(width!) : null,
          height: height != null ? data.h(height!) : null,
          padding: padding != null ? _scaleEdgeInsets(padding!, data) : null,
          margin: margin != null ? _scaleEdgeInsets(margin!, data) : null,
          decoration: decoration,
          alignment: alignment,
          child: child,
        );
      },
    );
  }

  EdgeInsetsGeometry _scaleEdgeInsets(
    EdgeInsetsGeometry insets,
    ResponsiveData data,
  ) {
    if (insets is EdgeInsets) {
      return EdgeInsets.only(
        left: data.w(insets.left),
        top: data.h(insets.top),
        right: data.w(insets.right),
        bottom: data.h(insets.bottom),
      );
    }
    return insets;
  }
}

/// Responsive sized box that updates dimensions in real-time
class GetResponsiveSizedBox extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final ResponsiveMode mode;

  const GetResponsiveSizedBox({
    super.key,
    this.child,
    this.width,
    this.height,
    this.mode = ResponsiveMode.layoutBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return GetResponsiveBuilder(
      mode: mode,
      builder: (context, data) {
        return SizedBox(
          width: width != null ? data.w(width!) : null,
          height: height != null ? data.h(height!) : null,
          child: child,
        );
      },
    );
  }
}

/// Responsive padding that updates in real-time
class GetResponsivePadding extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final ResponsiveMode mode;

  const GetResponsivePadding({
    super.key,
    required this.child,
    required this.padding,
    this.mode = ResponsiveMode.layoutBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return GetResponsiveBuilder(
      mode: mode,
      builder: (context, data) {
        return Padding(padding: _scaleEdgeInsets(padding, data), child: child);
      },
    );
  }

  EdgeInsetsGeometry _scaleEdgeInsets(
    EdgeInsetsGeometry insets,
    ResponsiveData data,
  ) {
    if (insets is EdgeInsets) {
      return EdgeInsets.only(
        left: data.w(insets.left),
        top: data.h(insets.top),
        right: data.w(insets.right),
        bottom: data.h(insets.bottom),
      );
    }
    return insets;
  }
}

/// Responsive icon that updates size in real-time
class GetResponsiveIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color? color;
  final ResponsiveMode mode;

  const GetResponsiveIcon(
    this.icon, {
    super.key,
    required this.size,
    this.color,
    this.mode = ResponsiveMode.layoutBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return GetResponsiveBuilder(
      mode: mode,
      builder: (context, data) {
        return Icon(icon, size: data.ws(size), color: color);
      },
    );
  }
}

/// Responsive elevated button that updates dimensions in real-time
class GetResponsiveElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final double? width;
  final double? height;
  final double? fontSize;
  final ResponsiveMode mode;
  final ButtonStyle? style;

  const GetResponsiveElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.width,
    this.height,
    this.fontSize,
    this.mode = ResponsiveMode.layoutBuilder,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return GetResponsiveBuilder(
      mode: mode,
      builder: (context, data) {
        Widget button = ElevatedButton(
          onPressed: onPressed,
          style: style,
          child: child,
        );

        if (width != null || height != null) {
          button = SizedBox(
            width: width != null ? data.w(width!) : null,
            height: height != null ? data.h(height!) : null,
            child: button,
          );
        }

        return button;
      },
    );
  }
}

/// Mixin for widgets that need real-time responsive capabilities
mixin GetRealtimeResponsiveMixin<T extends StatelessWidget> on StatelessWidget {
  ResponsiveMode get responsiveMode => ResponsiveMode.layoutBuilder;

  Widget buildResponsive(BuildContext context, ResponsiveData data);

  @override
  Widget build(BuildContext context) {
    return GetResponsiveBuilder(
      mode: responsiveMode,
      builder: (context, data) => buildResponsive(context, data),
    );
  }
}

/// Helper class for creating responsive values that update in real-time
class GetRealtimeResponsiveHelper {
  /// Create a responsive value that updates in real-time
  static Widget responsiveValue<T>({
    Widget Function(T? value)? builder,
    T? phone,
    T? tablet,
    T? laptop,
    T? desktop,
    T? tv,
    T? defaultValue,
    ResponsiveMode mode = ResponsiveMode.layoutBuilder,
  }) {
    return GetResponsiveBuilder(
      mode: mode,
      builder: (context, data) {
        final value = data.responsiveValue<T>(
          phone: phone,
          tablet: tablet,
          laptop: laptop,
          desktop: desktop,
          tv: tv,
          defaultValue: defaultValue,
        );
        return builder!(value);
      },
    );
  }
}
