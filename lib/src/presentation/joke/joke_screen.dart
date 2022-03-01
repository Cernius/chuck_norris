import 'package:chuck_norris/src/domain/models/joke.dart';
import 'package:chuck_norris/src/presentation/common/base_page.dart';
import 'package:chuck_norris/src/presentation/common/theme/colors.dart';
import 'package:chuck_norris/src/presentation/common/theme/font_sizes.dart';
import 'package:chuck_norris/src/presentation/common/theme/paddings.dart';
import 'package:chuck_norris/src/presentation/common/theme/sizes.dart';
import 'package:chuck_norris/src/presentation/joke/bloc/joke_bloc.dart';
import 'package:chuck_norris/src/presentation/joke/joke_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JokeScreen extends StatelessWidget with BasePage {
  final String? categoryName;
  final List<Joke> jokeList;
  final Joke? singleJoke;

  JokeScreen({
    Key? key,
    this.categoryName,
    required this.jokeList,
    required this.singleJoke,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              nav.back();
            },
            icon: const Icon(
              Icons.close,
              color: Colors.black,
              size: Sizes.iconSize,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Random joke: $categoryName",
            style: const TextStyle(
                color: Colors.black, fontSize: FontSizes.font_17),
          ),
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: BlocProvider<JokeBloc>(
          create: (context) {
            JokeBloc bloc = JokeBloc();
            bloc.initJokeList(jokeList, singleJoke);
            return bloc;
          },
          child: BlocBuilder<JokeBloc, JokeData>(
            builder: (context, data) {
              if (data.jokeList.isEmpty && data.currentJoke == null) {
                return _BuildNoJokesScreen();
              }
              return _BuildJoke(
                data: data,
              );
            },
          ),
        ));
  }
}

class _BuildNoJokesScreen extends StatelessWidget with BasePage {
  _BuildNoJokesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      getStrings().sorryNoJokes,
      style: const TextStyle(
        fontSize: FontSizes.font_16,
        fontWeight: FontWeight.w400,
      ),
    ));
  }
}

class _BuildJoke extends StatelessWidget {
  final JokeData data;

  const _BuildJoke({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(GetPadding.padding_20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _BuildIcon(
            iconPath: data.currentJoke!.iconUrl,
          ),
          _BuildJokeText(text: data.currentJoke!.jokeValue),
          const Spacer(),
          _BuildNextRandomJokeButton(
            data: data,
          ),
          const SizedBox(
            height: Sizes.space_44,
          )
        ],
      ),
    );
  }
}

class _BuildIcon extends StatelessWidget {
  final String iconPath;

  const _BuildIcon({Key? key, required this.iconPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: GetPadding.padding_23),
      child: Image.network(
        iconPath,
        height: Sizes.imageSize,
        width: Sizes.imageSize,
      ),
    );
  }
}

class _BuildJokeText extends StatelessWidget {
  final String text;

  const _BuildJokeText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "\"$text\"",
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: FontSizes.font_16,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class _BuildNextRandomJokeButton extends StatelessWidget with BasePage {
  final JokeData data;

  _BuildNextRandomJokeButton({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            BlocProvider.of<JokeBloc>(context).nextJoke();
          },
          child: Container(
            height: Sizes.buttonHeight_48,
            margin:
                const EdgeInsets.symmetric(horizontal: GetPadding.padding_20),
            decoration: BoxDecoration(
              color: GetColors.orange,
              borderRadius: BorderRadius.circular(Sizes.buttonRadius),
            ),
            child: Center(
                child: Text(
              getStrings().anotherJoke,
              style: const TextStyle(
                color: Colors.white,
                fontSize: FontSizes.font_16,
                fontWeight: FontWeight.w600,
              ),
            )),
          ),
        ),
        if (data.jokeList.length - 1 <= data.currentJokeIndex)
          Container(
            color: Colors.white.withOpacity(0.6),
            height: Sizes.buttonHeight_48,
          )
      ],
    );
  }
}
