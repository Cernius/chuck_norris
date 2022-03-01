import 'package:chuck_norris/src/domain/models/joke.dart';

class CategoriesData {
  final List<String> categories;
  final List<Joke> jokeList;
  final bool loading;
  final String searchQuery;
  final bool textFieldFocused;

  CategoriesData({
    required this.categories,
    required this.loading,
    required this.searchQuery,
    required this.jokeList,
    required this.textFieldFocused,
  });

  CategoriesData copyWith({
    List<String>? categories,
    List<Joke>? jokeList,
    bool? loading,
    bool? textFieldFocused,
    String? searchQuery,
    Joke? currentJoke,
    int? currentJokeIndex,
  }) {
    return CategoriesData(
      categories: categories ?? this.categories,
      loading: loading ?? this.loading,
      textFieldFocused: textFieldFocused ?? this.textFieldFocused,
      searchQuery: searchQuery ?? this.searchQuery,
      jokeList: jokeList ?? this.jokeList,
    );
  }
}
