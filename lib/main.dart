import 'package:chuck_norris/src/common/app_module.dart';
import 'package:chuck_norris/src/common/navigation_service.dart';
import 'package:chuck_norris/src/common/router.dart';
import 'package:flutter/material.dart';
import 'package:chuck_norris/src/common/router.dart' as router;

void main() async {
  print(injector.get<NavigationService>().navigatorKey);
  WidgetsFlutterBinding.ensureInitialized();


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
      initialRoute: categoriesScreen,
      navigatorKey: injector.get<NavigationService>().navigatorKey,
      onGenerateRoute: router.generateRoute,
    );
  }
}
