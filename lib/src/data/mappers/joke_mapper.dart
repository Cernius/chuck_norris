import 'package:chuck_norris/src/data/models/joke_dto.dart';
import 'package:chuck_norris/src/domain/mappers/mapper.dart';
import 'package:chuck_norris/src/domain/models/joke.dart';

class JokeMapper extends Mapper<JokeDTO, Joke> {
  @override
  Joke map(JokeDTO input) {
    return Joke(
      jokeValue: input.value,
      id: input.id,
      iconUrl: input.iconUrl,
    );
  }
}
