import 'package:chuck_norris/src/domain/models/joke.dart';

abstract class JokeRepository {
  Future<Joke> getJoke(String categoryName);

  Future<List<Joke>> getRandomJokes(String searchQuery);
}
