import 'package:chuck_norris/src/domain/models/joke.dart';

class JokeData {
  final List<Joke> jokeList;
  final Joke? currentJoke;
  final int currentJokeIndex;

  JokeData({
    required this.jokeList,
    required this.currentJoke,
    required this.currentJokeIndex,
  });

  JokeData copyWith({
    List<Joke>? jokeList,
    Joke? currentJoke,
    int? currentJokeIndex,
  }) {
    return JokeData(
      jokeList: jokeList ?? this.jokeList,
      currentJoke: currentJoke ?? this.currentJoke,
      currentJokeIndex: currentJokeIndex ?? this.currentJokeIndex,
    );
  }
}
