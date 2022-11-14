import 'package:chuck_norris/src/common/app_module.dart';
import 'package:chuck_norris/src/common/navigation_service.dart';
import 'package:chuck_norris/src/common/router.dart';
import 'package:chuck_norris/src/domain/models/joke.dart';
import 'package:chuck_norris/src/domain/repositories/category_repository.dart';
import 'package:chuck_norris/src/domain/repositories/joke_repository.dart';
import 'package:chuck_norris/src/presentation/categories/categories_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesBloc extends Cubit<CategoriesData> {
  final CategoryRepository _categoryRepository;
  final JokeRepository _jokeRepository;

  CategoriesBloc(this._categoryRepository, this._jokeRepository)
      : super(
          CategoriesData(
            categories: [],
            textFieldFocused: false,
            loading: true,
            searchQuery: '',
            jokeList: [],
          ),
        );

  Future<void> getData() async {
    List<String> categories = await _categoryRepository.getAllCategories();
    if (!isClosed) emit(state.copyWith(categories: categories, loading: false));
  }

  Future<Joke> getJoke(String categoryName) async {
    emit(state.copyWith(loading: true));
    Joke joke = await _jokeRepository.getJoke(categoryName);
    emit(state.copyWith(jokeList: [], loading: false));
   return joke;
  }

  void searchQuery(String value) {
    emit(state.copyWith(searchQuery: value));
  }

  Future<void> getRandomJokes() async {
    emit(state.copyWith(loading: true));
    List<Joke> jokeList =
        await _jokeRepository.getRandomJokes(state.searchQuery);
    emit(state.copyWith(jokeList: [], loading: false));
    injector.get<NavigationService>().navigateTo(
          jokeScreen,
          arguments: JokeScreenArguments(
            categoryName: state.searchQuery,
            jokeList: jokeList,
            singleJoke: null,
          ),
        );
  }

  void focusChanged() {
    emit(state.copyWith(textFieldFocused: !state.textFieldFocused));
  }
}
