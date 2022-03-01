import 'package:chuck_norris/src/common/app.locator.dart';
import 'package:chuck_norris/src/common/app.router.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

void main() async {
  setupLocator();
  runApp(const MyApp());
}

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}
