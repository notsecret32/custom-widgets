import 'package:flutter/material.dart';

/// An abbreviated version of the method for [ListView].
typedef CallbackFunction<T> = T Function(BuildContext context, int index);

/// The extension of the basic [ListView] allows you to choose
/// when to build using [buildWhen].
extension CustomListView on ListView {
  /// Creates a [ListView] with the ability to choose under
  /// what conditions the widget will be built at each iteration.
  static ListView builder<T extends Object>({
    required int itemCount,
    required CallbackFunction<Widget> itemBuilder,
    bool enable = true,
    CallbackFunction<bool>? buildWhen,
  }) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        if (!enable || (buildWhen != null && !buildWhen(context, index))) {
          return Container();
        }
        return itemBuilder(context, index);
      },
    );
  }

  /// Creates a [ListView] with separation and the ability to choose under
  /// what conditions the widget will be built at each iteration.
  ///
  /// Widgets are separated automatically.
  static ListView separated<T extends Object>({
    required int itemCount,
    required CallbackFunction<Widget> itemBuilder,
    required CallbackFunction<Widget> separatorBuilder,
    bool enable = true,
    CallbackFunction<bool>? condition,
  }) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        if (!enable || (condition != null && !condition(context, index))) {
          return Container();
        }
        return itemBuilder(context, index);
      },
      separatorBuilder: (BuildContext context, int index) {
        if ((condition != null && !condition(context, index))) {
          return Container();
        }

        if (index < itemCount - 1) {
          return separatorBuilder(context, index);
        }

        return Container();
      },
    );
  }
}
