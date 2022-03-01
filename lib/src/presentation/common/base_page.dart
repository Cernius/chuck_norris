import 'package:chuck_norris/src/common/app.locator.dart';
import 'package:chuck_norris/src/common/app_module.dart';
import 'package:chuck_norris/src/presentation/common/dialogs/loading_dialog.dart';
import 'package:chuck_norris/src/presentation/common/localizations/strings.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

abstract class BasePage {
  late final NavigationService nav = locator<NavigationService>();

  Strings getStrings() => injector.get<Strings>();

  Size getScreenSize(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return screenSize;
  }

  void showLoaderDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return LoadingDialog();
      },
    );
  }


}
