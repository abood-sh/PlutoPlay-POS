import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  Future<void> pushNamed(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushNamed(routeName, arguments: arguments);

  Future<void> pushNamedAndRemoveUntil(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushNamedAndRemoveUntil(
        routeName,
        (route) => false,
        arguments: arguments,
      );

  Future<void> pushReplacementNamed(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushReplacementNamed(routeName, arguments: arguments);
  void pop() => Navigator.of(this).pop();

  void popUntil(String routeName) =>
      Navigator.of(this).popUntil(ModalRoute.withName(routeName));

  void popAndPushNamed(String routeName, {Object? arguments}) =>
      Navigator.of(this).popAndPushNamed(routeName, arguments: arguments);

  void popUntilAndPushNamed(String routeName, {Object? arguments}) {
    Navigator.of(this).popUntil(ModalRoute.withName(routeName));

    Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }
}

extension StringExtension on String? {
  bool isNullOrEmpty() => this == null || this!.isEmpty || this == '';
}

extension ListExtension<T> on List<T>? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}

extension MapExtension<K, V> on Map<K, V>? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;

}
