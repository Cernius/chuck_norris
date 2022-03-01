import 'package:chuck_norris/src/data/server_api.dart';
import 'package:chuck_norris/src/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final ServerApi _serverApi;

  CategoryRepositoryImpl(this._serverApi);

  @override
  Future<List<String>> getAllCategories() async {
    return await _serverApi.getAllCategories();
  }
}
