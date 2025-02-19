import 'package:flutter/material.dart';

/// OptimizedListView
/// @Description: A ListView that is optimized for performance by using a CustomScrollView with a SliverList.

///
class OptimizedListView<T> extends StatelessWidget {
  /// @Description: A ListView that is optimized for performance by using a CustomScrollView with a SliverList.

  /// @required list: The list of items to display in the ListView.
  final List<T> list;

  /// @required builder: A function that returns a widget for each item in the list.
  final Axis scrollDirection;

  /// [reverse] Whether the list should be displayed in reverse order.
  final bool reverse;

  /// [controller] An optional ScrollController for the ListView.
  final ScrollController? controller;

  /// [primary] Whether the ListView is the primary scroll view in the widget tree.
  final bool? primary;

  /// [physics] The physics of the ListView.
  final ScrollPhysics? physics;

  /// [shrinkWrap] Whether the ListView should shrink-wrap its contents.
  final bool shrinkWrap;

  /// [onEmpty] A widget to display when the list is empty.
  final Widget onEmpty;

  /// [keyGenerator] A function that generates a key for each item in the list.
  final Widget Function(BuildContext context, ValueKey key, T item) builder;

  /// [key] The key for the ListView.
  final Key? Function(T item)? keyGenerator;

  const OptimizedListView({
    super.key,
    required this.list,
    required this.builder,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.onEmpty = const SizedBox.shrink(),
    this.shrinkWrap = false,
    this.keyGenerator,
  });

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) return onEmpty;

    return CustomScrollView(
      controller: controller,
      reverse: reverse,
      scrollDirection: scrollDirection,
      primary: primary,
      physics: physics,
      shrinkWrap: shrinkWrap,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, i) {
              final item = list[i];
              final key =
                  keyGenerator != null ? keyGenerator!(item) : ValueKey(item);
              return builder(context, key as ValueKey, item);
            },
            childCount: list.length,
            addAutomaticKeepAlives: true,
            findChildIndexCallback: (key) {
              return list.indexWhere((m) => m == (key as ValueKey<T>).value);
            },
          ),
        ),
      ],
    );
  }
}
