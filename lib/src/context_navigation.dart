import 'package:flutter/material.dart';

extension BuildContextExtensionNavigation<T> on BuildContext {
  NavigatorState get _navigator => Navigator.of(this);

  void push(Widget page) =>
      _navigator.push(MaterialPageRoute(builder: (context) => page));

  void pushNamed(String name, {Object? arguments}) =>
      _navigator.pushNamed(name, arguments: arguments);

  void pushReplacement(Widget page) =>
      _navigator.pushReplacement(MaterialPageRoute(builder: (context) => page));

  void pushReplacementNamed(String name, {Object? arguments}) =>
      _navigator.pushReplacementNamed(name, arguments: arguments);

  void popUntil(String name) =>
      _navigator.popUntil((route) => route.settings.name == name);

  void pop([T? result]) => _navigator.pop(result);
}
