import 'package:chuck_norris/src/data/mappers/joke_mapper.dart';
import 'package:chuck_norris/src/data/models/joke_dto.dart';
import 'package:chuck_norris/src/data/server_api.dart';
import 'package:chuck_norris/src/domain/models/joke.dart';
import 'package:chuck_norris/src/domain/repositories/joke_repository.dart';

class JokeRepositoryImpl extends JokeRepository {
  final ServerApi _serverApi;
  final JokeMapper _jokeMapper;

  JokeRepositoryImpl(this._serverApi, this._jokeMapper);

  @override
  Future<Joke> getJoke(String categoryName) async {
    JokeDTO joke = await _serverApi.getJoke(categoryName);

    return _jokeMapper.map(joke);
  }

  @override
  Future<List<Joke>> getRandomJokes(String searchQuery) async {
    List<JokeDTO> jokes = await _serverApi.getRandomJokes(searchQuery);
    return jokes.map((e) => _jokeMapper.map(e)).toList();
  }
}
