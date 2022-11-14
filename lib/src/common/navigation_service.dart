import 'package:chuck_norris/src/domain/repositories/logger.dart';
import 'package:flutter/material.dart';

class NavigationService {
  final Logger _logger;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigationService(this._logger);

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) async {
    if (navigatorKey.currentState == null) {
      _logger.w('Navigation key state is null!!!');
    }

    return await navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateToByReplace(String routeName, {dynamic arguments}) {
    if (navigatorKey.currentState == null) {
      _logger.w('Navigation key state is null!!!');
    }
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateToByReplaceAll(String routeName,
      {dynamic arguments}) {
    if (navigatorKey.currentState == null) {
      _logger.w('Navigation key state is null!!!');
    }
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  void goBack({dynamic result}) {
    return navigatorKey.currentState!.pop(result);
  }

  void goBackToMain() {
    return navigatorKey.currentState!.popUntil((route) {
      return route.isFirst;
    });
  }
}
