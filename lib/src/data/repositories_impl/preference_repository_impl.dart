import 'package:chuck_norris/src/domain/repositories/preference_repository.dart';

class PreferenceRepositoryImpl extends PreferenceRepository {
  @override
  String getServerUrl() {
    return "api.chucknorris.io";
  }
}
