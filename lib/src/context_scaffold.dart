import 'package:flutter/material.dart';

extension ContextScaffoldExtension<T> on BuildContext {
  void openDrawer() => Scaffold.of(this).openDrawer();

  void closeDrawer() => Scaffold.of(this).closeDrawer();

  void openEndDrawer() => Scaffold.of(this).openEndDrawer();

  void closeEndDrawer() => Scaffold.of(this).closeEndDrawer();

  /// Open Bottom sheet
  void showBottomSheet(
    WidgetBuilder builder, {
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    bool? enableDrag,
    AnimationController? transitionAnimationController,
  }) =>
      Scaffold.of(this).showBottomSheet(builder,
          backgroundColor: backgroundColor,
          elevation: elevation,
          shape: shape,
          clipBehavior: clipBehavior,
          constraints: constraints,
          enableDrag: enableDrag,
          transitionAnimationController: transitionAnimationController);
}
