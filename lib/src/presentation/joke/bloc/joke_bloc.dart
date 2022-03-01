import 'package:chuck_norris/src/domain/models/joke.dart';
import 'package:chuck_norris/src/presentation/joke/joke_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JokeBloc extends Cubit<JokeData> {
  JokeBloc()
      : super(JokeData(
          currentJoke: null,
          jokeList: [],
          currentJokeIndex: 0,
        ));

  void initJokeList(List<Joke> jokeList, Joke? singleJoke) {
    if (jokeList.isNotEmpty || singleJoke != null) {
      emit(state.copyWith(
          jokeList: jokeList, currentJoke: singleJoke ?? jokeList.first));
    }
  }

  void nextJoke() {
    emit(
      state.copyWith(
        currentJoke: state.jokeList[state.currentJokeIndex + 1],
        currentJokeIndex: state.currentJokeIndex + 1,
      ),
    );
  }
}
