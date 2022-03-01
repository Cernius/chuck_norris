// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../domain/models/joke.dart';
import '../presentation/categories/categories_screen.dart';
import '../presentation/joke/joke_screen.dart';

class Routes {
  static const String categoriesScreen = '/';
  static const String jokeScreen = '/joke-screen';
  static const all = <String>{
    categoriesScreen,
    jokeScreen,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.categoriesScreen, page: CategoriesScreen),
    RouteDef(Routes.jokeScreen, page: JokeScreen),
  ];

  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    CategoriesScreen: (data) {
      var args = data.getArgs<CategoriesScreenArguments>(
        orElse: () => CategoriesScreenArguments(),
      );
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            CategoriesScreen(key: args.key),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        transitionDuration: const Duration(milliseconds: 100),
      );
    },
    JokeScreen: (data) {
      var args = data.getArgs<JokeScreenArguments>(nullOk: false);
      return CupertinoPageRoute<JokeScreen>(
        builder: (context) => JokeScreen(
          key: args.key,
          categoryName: args.categoryName,
          jokeList: args.jokeList,
          singleJoke: args.singleJoke,
        ),
        settings: data,
      );
    },
  };
}

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
