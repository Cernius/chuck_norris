import 'package:chuck_norris/src/common/app_module.dart';
import 'package:chuck_norris/src/common/navigation_service.dart';
import 'package:chuck_norris/src/domain/repositories/logger.dart';
import 'package:chuck_norris/src/presentation/common/localizations/strings.dart';
import 'package:flutter/material.dart';

extension StatelessWidgetExtensions on StatelessWidget {
  Logger getLogger() => injector.get<Logger>();

  NavigationService getNav() => injector.get<NavigationService>();

  Size getScreenSize(context) => MediaQuery.of(context).size;

  Strings getStrings() => injector.get<Strings>();
}
