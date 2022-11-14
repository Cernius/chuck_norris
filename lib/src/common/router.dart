// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:chuck_norris/src/domain/models/joke.dart';
import 'package:chuck_norris/src/presentation/categories/categories_screen.dart';
import 'package:chuck_norris/src/presentation/joke/joke_screen.dart';
import 'package:flutter/material.dart';

class MyRoute extends MaterialPageRoute {
  MyRoute({required WidgetBuilder builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(seconds: 0);
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case categoriesScreen:
      final args = settings.arguments as CategoriesScreenArguments?;
      return MyRoute(
        builder: (context) => CategoriesScreen(
          key: args?.key,
        ),
      );
    case jokeScreen:
      final args = settings.arguments as JokeScreenArguments;
      return MyRoute(
        builder: (context) => JokeScreen(
          key: args.key,
          categoryName: args.categoryName,
          jokeList: args.jokeList,
          singleJoke: args.singleJoke,
        ),
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

const String jokeScreen = '/joke-screen';
const String categoriesScreen = '/';

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// CategoriesScreen arguments holder class
class CategoriesScreenArguments {
  final Key? key;

  CategoriesScreenArguments({this.key});
}

/// JokeScreen arguments holder class
class JokeScreenArguments {
  final Key? key;
  final String? categoryName;
  final List<Joke> jokeList;
  final Joke? singleJoke;

  JokeScreenArguments(
      {this.key,
      this.categoryName,
      required this.jokeList,
      required this.singleJoke});
}
