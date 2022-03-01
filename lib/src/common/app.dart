import 'package:chuck_norris/src/presentation/categories/categories_screen.dart';
import 'package:chuck_norris/src/presentation/joke/joke_screen.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    CustomRoute(
      page: CategoriesScreen,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      initial: true,
      durationInMilliseconds: 100,
    ),
    CupertinoRoute<JokeScreen>(page: JokeScreen),
  ],
  dependencies: [
    LazySingleton<NavigationService>(classType: NavigationService),
  ],
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}

/// instructions
/// on change run on terminal
/// flutter pub run build_runner build --delete-conflicting-outputs
