import 'package:flutter/material.dart';
import 'package:get_x_master/get_x_master.dart';

import '../router_report.dart'; // Make sure this import is correct for your project

/// A highly customizable expandable bottom sheet route that can be opened from the top or bottom.
///
/// This class provides a `PopupRoute` that displays a bottom sheet which can expand and contract
/// based on user interaction or programmatic control.  It supports opening from both the top
/// and the bottom of the screen, and offers extensive customization options for appearance and behavior.
class CustomExpandableBottomSheetRoute<T> extends PopupRoute<T> {
  /// Creates a customizable expandable bottom sheet route.
  ///
  /// The [builder] argument is required and must return the content of the bottom sheet.
  CustomExpandableBottomSheetRoute({
    required this.builder,
    this.theme,
    this.barrierLabel,
    this.backgroundColor,
    this.isPersistent = false,
    this.elevation,
    this.shape,
    this.clipBehavior,
    this.modalBarrierColor,
    this.isDismissible = true,
    this.enableDrag = true,
    this.isScrollControlled = true,
    this.scaffoldKey,
    this.messengerKey,
    super.settings,
    this.enterBottomSheetDuration = const Duration(milliseconds: 250),
    this.exitBottomSheetDuration = const Duration(milliseconds: 200),
    this.curve,
    this.initialChildSize = 0.5,
    this.minChildSize = 0.03,
    this.maxChildSize = 1.0,
    this.borderRadius = 15.0,
    this.startFromTop = false,
    this.snap = false,
    this.isShowCloseBottom = true,
    this.closeIcon = Icons.close,
    this.indicatorColor = const Color.fromRGBO(224, 224, 224, 1),
    this.itemPaddingTop = 60,
  }) {
    RouterReportManager.reportCurrentRoute(this);
  }

  /// {@template custom_expandable_bottom_sheet.builder}
  /// A builder function that returns the widget tree representing the content of the bottom sheet.
  ///
  /// This is typically a `Column` or other layout widget containing the desired content.
  /// {@endtemplate}
  final WidgetBuilder builder;

  /// {@template custom_expandable_bottom_sheet.scaffoldKey}
  /// A key to access the `ScaffoldState` of the internal `Scaffold` used to display the bottom sheet.
  ///
  /// This can be used to programmatically control the scaffold, such as showing snackbars.
  /// {@endtemplate}
  final GlobalKey<ScaffoldState>? scaffoldKey;

  /// {@template custom_expandable_bottom_sheet.messengerKey}
  /// A key to access the `ScaffoldMessengerState`.
  ///
  ///  This can be used, for example, to easily display SnackBar messages.
  /// {@endtemplate}
  final GlobalKey<ScaffoldMessengerState>? messengerKey;

  /// {@template custom_expandable_bottom_sheet.initialChildSize}
  /// The initial size of the bottom sheet, expressed as a fraction of the screen height.
  ///
  /// Defaults to 0.5 (half the screen height).  When [startFromTop] is true, this represents
  /// the *hidden* portion of the sheet, so a value of 0.5 means it starts half-way down the screen.
  /// {@endtemplate}
  final double initialChildSize;

  /// {@template custom_expandable_bottom_sheet.minChildSize}
  /// The minimum size of the bottom sheet, expressed as a fraction of the screen height.
  ///
  /// The user cannot drag the bottom sheet smaller than this size. Defaults to 0.03.
  /// {@endtemplate}
  final double minChildSize;

  /// {@template custom_expandable_bottom_sheet.maxChildSize}
  /// The maximum size of the bottom sheet, expressed as a fraction of the screen height.
  ///
  /// The user cannot drag the bottom sheet larger than this size. Defaults to 1.0 (full screen).
  /// {@endtemplate}
  final double maxChildSize;

  /// {@template custom_expandable_bottom_sheet.borderRadius}
  /// The radius of the top corners of the bottom sheet (when [startFromTop] is false)
  /// or the bottom corners (when [startFromTop] is true).
  ///
  /// Defaults to 15.0.
  /// {@endtemplate}
  final double borderRadius;

  /// {@template custom_expandable_bottom_sheet.startFromTop}
  /// Whether the bottom sheet should open from the top of the screen instead of the bottom.
  ///
  /// Defaults to false. If true, the sheet will expand *downwards*.
  /// {@endtemplate}
  final bool startFromTop;

  /// {@template custom_expandable_bottom_sheet.snap}
  /// Whether the bottom sheet should snap to [initialChildSize], [minChildSize] or [maxChildSize].
  ///
  /// Defaults to false.
  /// {@endtemplate}
  final bool snap;

  /// {@template custom_expandable_bottom_sheet.theme}
  /// The theme to apply to the bottom sheet.
  ///
  /// If null, the overall theme's `BottomSheetThemeData` is used.
  /// {@endtemplate}
  final ThemeData? theme;

  /// {@template custom_expandable_bottom_sheet.backgroundColor}
  /// The background color of the bottom sheet.
  ///
  /// If null, the `BottomSheetThemeData`'s `backgroundColor` is used.
  /// {@endtemplate}
  final Color? backgroundColor;

  /// {@template custom_expandable_bottom_sheet.elevation}
  /// The elevation of the bottom sheet.
  ///
  /// This controls the shadow displayed beneath the sheet.
  /// {@endtemplate}
  final double? elevation;

  /// {@template custom_expandable_bottom_sheet.shape}
  /// The shape of the bottom sheet.
  ///
  /// If null, the `BottomSheetThemeData`'s `shape` is used.
  /// {@endtemplate}
  final ShapeBorder? shape;

  /// {@template custom_expandable_bottom_sheet.clipBehavior}
  /// The clipping behavior of the bottom sheet.
  ///
  /// Defaults to null.
  /// {@endtemplate}
  final Clip? clipBehavior;

  /// {@template custom_expandable_bottom_sheet.modalBarrierColor}
  /// The color of the modal barrier that darkens the background behind the bottom sheet.
  ///
  /// If null, `Colors.black54` is used.
  /// {@endtemplate}
  final Color? modalBarrierColor;

  /// {@template custom_expandable_bottom_sheet.isPersistent}
  /// Whether the bottom sheet should be persistent.
  ///
  /// If false (the default), the bottom sheet can be dismissed by tapping outside of it.
  /// If true, the bottom sheet cannot be dismissed by tapping outside. See also [isDismissible].
  /// {@endtemplate}
  final bool isPersistent;

  /// {@template custom_expandable_bottom_sheet.isScrollControlled}
  /// Whether the bottom sheet's height is determined by its content.
  ///
  /// Defaults to true.  If set to false, the bottom sheet will be a fixed size,
  /// as determined by [initialChildSize], [minChildSize], and [maxChildSize].
  /// {@endtemplate}
  final bool isScrollControlled;

  /// {@template custom_expandable_bottom_sheet.isDismissible}
  /// Whether the bottom sheet can be dismissed by tapping on the modal barrier.
  ///
  /// Defaults to true.  If set to false, the bottom sheet will not be dismissed when the
  /// barrier is tapped.  This is different from [isPersistent]; if [isPersistent] is true,
  /// there is no way to dismiss the sheet via tapping.  If [isDismissible] is false
  /// (and [isPersistent] is false), the user can still dismiss the sheet by dragging,
  /// but *not* by tapping.
  ///
  /// **To make the bottom sheet truly non-dismissible (by any means), set both [isPersistent] and [isDismissible] to false.**
  /// {@endtemplate}
  final bool isDismissible;

  /// {@template custom_expandable_bottom_sheet.enableDrag}
  /// Whether the bottom sheet can be dragged by the user.
  ///
  /// Defaults to true.
  /// {@endtemplate}
  final bool enableDrag;

  /// {@template custom_expandable_bottom_sheet.enterBottomSheetDuration}
  /// The duration of the animation that slides the bottom sheet into view.
  ///
  /// Defaults to 250 milliseconds.
  /// {@endtemplate}
  final Duration enterBottomSheetDuration;

  /// {@template custom_expandable_bottom_sheet.exitBottomSheetDuration}
  /// The duration of the animation that slides the bottom sheet out of view.
  ///
  /// Defaults to 200 milliseconds.
  /// {@endtemplate}
  final Duration exitBottomSheetDuration;

  /// {@template custom_expandable_bottom_sheet.curve}
  /// The curve to use for the animation that slides the bottom sheet into and out of view.
  ///
  /// If null, a linear curve is used.
  /// {@endtemplate}
  final Curve? curve;

  /// {@macro flutter.widgets.ModalRoute.barrierLabel}
  @override
  final String? barrierLabel;

  /// The duration of the transition when the bottom sheet is pushed onto the navigation stack.
  @override
  Duration get transitionDuration => const Duration(milliseconds: 700);

  /// Whether tapping on the modal barrier should dismiss the bottom sheet. This is linked to [isDismissible].
  @override
  bool get barrierDismissible => isDismissible;

  /// The color of the modal barrier that darkens the background behind the bottom sheet.
  @override
  Color get barrierColor => modalBarrierColor ?? Colors.black54;

  late final AnimationController _animationController;

  /// Creates the animation for the bottom sheet's entrance and exit transitions.

  /// [isShowCloseBottom] - Whether to show the close button at the bottom.
  final bool isShowCloseBottom;

  /// [closeIcon] - The icon to use for the close button.
  final IconData closeIcon;

  /// [indicatorColor] - The color of the indicator.
  final Color indicatorColor;

  final double? itemPaddingTop;

  @override
  Animation<double> createAnimation() {
    return curve != null
        ? CurvedAnimation(curve: curve!, parent: _animationController.view)
        : _animationController.view;
  }

  /// Creates the animation controller for managing the bottom sheet's animations.
  @override
  AnimationController createAnimationController() {
    _animationController = BottomSheet.createAnimationController(
      navigator!.overlay!,
    );
    _animationController.duration = enterBottomSheetDuration;
    _animationController.reverseDuration = exitBottomSheetDuration;
    return _animationController;
  }

  /// Builds the bottom sheet's UI.
  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final sheetTheme =
        theme?.bottomSheetTheme ?? Theme.of(context).bottomSheetTheme;

    Widget content = SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AnimatedBuilder(
          // Use AnimatedBuilder for smooth transitions
          animation: animation,
          builder: (context, child) {
            return Align(
              alignment:
                  startFromTop
                      ? Alignment.topCenter
                      : Alignment.bottomCenter, // Align to top or bottom
              child: Container(
                decoration: BoxDecoration(
                  // Box decoration for background color
                  color:
                      backgroundColor ??
                      sheetTheme.modalBackgroundColor ??
                      sheetTheme.backgroundColor,
                  boxShadow:
                      elevation != null
                          ? [
                            BoxShadow(
                              blurRadius: elevation!,
                              color: Colors.black26,
                            ),
                          ]
                          : null,
                  borderRadius: BorderRadius.vertical(
                    top:
                        startFromTop
                            ? Radius.zero
                            : Radius.circular(
                              borderRadius,
                            ), // No BorderRadius at the top when startFromTop is true.
                    bottom:
                        startFromTop
                            ? Radius.circular(borderRadius)
                            : Radius.zero,
                  ), // No BorderRadius at the bottom when startFromTop is false
                ),
                clipBehavior:
                    Clip.antiAlias, // Use clipBehavior to properly apply borderRadius.
                child: DraggableScrollableSheet(
                  snap: snap,
                  snapAnimationDuration: const Duration(milliseconds: 200),
                  initialChildSize: initialChildSize, // Now it's dynamic
                  minChildSize: minChildSize, // Dynamic min size
                  maxChildSize: maxChildSize, // Dynamic max size
                  expand: false,
                  builder: (context, scrollController) {
                    return SingleChildScrollView(
                      controller: scrollController,
                      child: Stack(
                        alignment:
                            startFromTop
                                ? Alignment.bottomCenter
                                : Alignment
                                    .topCenter, // تغییر alignment بر اساس startFromTop
                        children: [
                          builder(context).paddingOnly(top: itemPaddingTop!),
                          // Container handle
                          Positioned(
                            top: startFromTop ? null : 0,
                            bottom: startFromTop ? 0 : null,
                            child: Container(
                              width: 40,
                              height: 4,
                              margin: EdgeInsets.only(
                                top: startFromTop ? 0 : 20,
                                bottom: startFromTop ? 20 : 0,
                              ),
                              decoration: BoxDecoration(
                                color: indicatorColor,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                          // Close button
                          if (isShowCloseBottom)
                            Positioned(
                              top: startFromTop ? null : 10,
                              bottom: startFromTop ? 10 : null,
                              right: 10,
                              child: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );

    if (theme != null) {
      content = Theme(data: theme!, child: content);
    }

    return content;
  }

  /// Disposes of the animation controller and reports the route disposal.
  @override
  void dispose() {
    RouterReportManager.reportRouteDispose(this);
    // Dispose of the animation controller
    super.dispose();
  }
}
