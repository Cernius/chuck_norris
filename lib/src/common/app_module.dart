import 'package:chuck_norris/src/common/navigation_service.dart';
import 'package:chuck_norris/src/data/mappers/joke_mapper.dart';
import 'package:chuck_norris/src/data/repositories_impl/category_repository_impl.dart';
import 'package:chuck_norris/src/data/repositories_impl/joke_repository_impl.dart';
import 'package:chuck_norris/src/data/repositories_impl/logger_impl.dart';
import 'package:chuck_norris/src/data/repositories_impl/preference_repository_impl.dart';
import 'package:chuck_norris/src/data/server_api.dart';
import 'package:chuck_norris/src/domain/repositories/category_repository.dart';
import 'package:chuck_norris/src/domain/repositories/joke_repository.dart';
import 'package:chuck_norris/src/domain/repositories/logger.dart';
import 'package:chuck_norris/src/domain/repositories/preference_repository.dart';
import 'package:chuck_norris/src/presentation/categories/bloc/categories_bloc.dart';
import 'package:chuck_norris/src/presentation/common/localizations/strings.dart';
import 'package:chuck_norris/src/presentation/common/localizations/strings_en.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class AppModule {
  Injector initialise(Injector injector) {
    injector.map<ServerApi>(
      (Injector i) => ServerApi(
        i.get<PreferenceRepository>(),
      ),
    );
    injector.map<PreferenceRepository>(
      (i) => PreferenceRepositoryImpl(),
      isSingleton: true,
    );
    injector.map<Logger>(
      (i) => LoggerImpl(),
      isSingleton: true,
    );
    injector.map<Strings>(
      (i) => StringsEn(),
    );
    injector.map<NavigationService>(
      (i) => NavigationService(i.get<Logger>()),
      isSingleton: true,
    );

    injector.map<JokeMapper>(
      (i) => JokeMapper(),
    );
    injector.map<CategoryRepository>(
      (i) => CategoryRepositoryImpl(
        i.get<ServerApi>(),
      ),
    );
    injector.map<JokeRepository>(
      (i) => JokeRepositoryImpl(
        i.get<ServerApi>(),
        i.get<JokeMapper>(),
      ),
    );
    injector.map<CategoriesBloc>(
      (i) => CategoriesBloc(
        i.get<CategoryRepository>(),
        i.get<JokeRepository>(),
      ),
    );
    return injector;
  }
}

Injector injector = AppModule().initialise(Injector());
