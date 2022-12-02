import 'package:chuck_norris/src/common/navigation_service.dart';
import 'package:chuck_norris/src/data/mappers/community_mapper.dart';
import 'package:chuck_norris/src/data/repositories_impl/community_repository_impl.dart';
import 'package:chuck_norris/src/data/repositories_impl/logger_impl.dart';
import 'package:chuck_norris/src/data/repositories_impl/preference_repository_impl.dart';
import 'package:chuck_norris/src/data/server_api.dart';
import 'package:chuck_norris/src/domain/repositories/community_repository.dart';
import 'package:chuck_norris/src/domain/repositories/logger.dart';
import 'package:chuck_norris/src/domain/repositories/preference_repository.dart';
import 'package:chuck_norris/src/presentation/common/localizations/strings.dart';
import 'package:chuck_norris/src/presentation/common/localizations/strings_en.dart';
import 'package:chuck_norris/src/presentation/main_screen/bloc/main_screen_bloc.dart';
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

    injector.map<CommunityRepository>(
      (i) => CommunityRepositoryImpl(
        i.get<CommunityMapper>(),
        i.get<ServerApi>(),
      ),
    );
    injector.map<CommunityMapper>(
      (i) => CommunityMapper(),
    );
    injector.map<MainScreenBloc>(
      (i) => MainScreenBloc(
        i.get<CommunityRepository>(),
      ),
    );

    return injector;
  }
}

Injector injector = AppModule().initialise(Injector());
