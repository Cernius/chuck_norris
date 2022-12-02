// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:chuck_norris/src/presentation/main_screen/screens/main_screen.dart';
import 'package:flutter/material.dart';

class MyRoute extends MaterialPageRoute {
  MyRoute({required WidgetBuilder builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(seconds: 0);
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case mainScreen:
      return MyRoute(
        builder: (context) => const MainScreen(),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}

const String mainScreen = '/';

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************
