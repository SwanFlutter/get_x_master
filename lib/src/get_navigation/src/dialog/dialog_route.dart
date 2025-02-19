import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../router_report.dart';

/// A custom popup route for displaying modal dialogs with configurable transitions in Flutter.
///
/// This class extends [PopupRoute] to provide a flexible way to show dialogs with
/// customizable animations, barrier properties, and transition effects.
///
/// Example usage:
/// ```dart
/// // Show a simple dialog with default fade transition
/// Navigator.of(context).push(
///   GetDialogRoute(
///     pageBuilder: (context, animation, secondaryAnimation) {
///       return AlertDialog(
///         title: Text('Simple Dialog'),
///         content: Text('This is a basic dialog example'),
///       );
///     },
///   ),
/// );
///
/// // Show a dialog with custom slide transition
/// Navigator.of(context).push(
///   GetDialogRoute(
///     pageBuilder: (context, animation, secondaryAnimation) {
///       return CustomDialog();
///     },
///     transitionBuilder: (context, animation, secondaryAnimation, child) {
///       return SlideTransition(
///         position: Tween<Offset>(
///           begin: const Offset(0, 1),
///           end: Offset.zero,
///         ).animate(animation),
///         child: child,
///       );
///     },
///     transitionDuration: Duration(milliseconds: 300),
///   ),
/// );
/// ```
class GetDialogRoute<T> extends PopupRoute<T> {
  /// Creates a customizable dialog route.
  ///
  /// Required parameters:
  /// * [pageBuilder]: Builds the dialog's content. This should return the widget
  ///   that will be displayed in the dialog.
  ///
  /// Optional parameters:
  /// * [barrierDismissible]: When true, tapping outside the dialog dismisses it.
  ///   Defaults to true.
  /// * [barrierLabel]: Semantic label used for the dialog barrier.
  /// * [barrierColor]: Color of the background overlay. Defaults to 50% transparent
  ///   black.
  /// * [transitionDuration]: Length of the transition animation. Defaults to 200ms.
  /// * [transitionBuilder]: Custom transition animation builder. If null, defaults
  ///   to a fade transition.
  /// * [settings]: Route settings for navigation.
  GetDialogRoute({
    required RoutePageBuilder pageBuilder,
    bool barrierDismissible = true,
    String? barrierLabel,
    Color barrierColor = const Color(0x80000000),
    Duration transitionDuration = const Duration(milliseconds: 200),
    RouteTransitionsBuilder? transitionBuilder,
    super.settings,
  })  : _pageBuilder = pageBuilder,
        _barrierDismissible = barrierDismissible,
        _barrierLabel = barrierLabel,
        _barrierColor = barrierColor,
        _transitionDuration = transitionDuration,
        _transitionBuilder = transitionBuilder {
    // Report route creation for tracking purposes
    RouterReportManager.reportCurrentRoute(this);
  }

  /// The builder function that creates the dialog content.
  final RoutePageBuilder _pageBuilder;

  /// Controls whether tapping outside the dialog dismisses it.
  @override
  bool get barrierDismissible => _barrierDismissible;
  final bool _barrierDismissible;

  /// Semantic label for the dialog barrier.
  @override
  String? get barrierLabel => _barrierLabel;
  final String? _barrierLabel;

  /// Color of the background overlay behind the dialog.
  @override
  Color get barrierColor => _barrierColor;
  final Color _barrierColor;

  /// Duration of the dialog's transition animation.
  @override
  Duration get transitionDuration => _transitionDuration;
  final Duration _transitionDuration;

  /// Optional custom transition animation builder.
  /// If null, a default fade transition will be used.
  final RouteTransitionsBuilder? _transitionBuilder;

  /// Cleans up resources when the route is disposed.
  @override
  void dispose() {
    RouterReportManager.reportRouteDispose(this);
    super.dispose();
  }

  /// Builds the dialog's content with proper semantics wrapping.
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: _pageBuilder(context, animation, secondaryAnimation),
    );
  }

  /// Builds the transition for the dialog.
  ///
  /// If [_transitionBuilder] is null, provides a default fade transition.
  /// Otherwise, uses the custom transition builder.
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (_transitionBuilder == null) {
      return FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: Curves.linear,
        ),
        child: child,
      );
    }
    return _transitionBuilder(context, animation, secondaryAnimation, child);
  }
}
