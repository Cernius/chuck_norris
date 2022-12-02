import 'package:chuck_norris/src/common/app_module.dart';
import 'package:chuck_norris/src/domain/models/community_item.dart';
import 'package:chuck_norris/src/presentation/common/stateless_extensions.dart';
import 'package:chuck_norris/src/presentation/main_screen/bloc/animated_widget_bloc.dart';
import 'package:chuck_norris/src/presentation/main_screen/bloc/main_screen_bloc.dart';
import 'package:chuck_norris/src/presentation/main_screen/states/animated_widget_state.dart';
import 'package:chuck_norris/src/presentation/main_screen/states/main_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GlobalKey _widgetKey = GlobalKey();

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              final bloc = injector.get<MainScreenBloc>();
              bloc.getData();
              return bloc;
            },
          ),
          BlocProvider(
            create: (context) => AnimatedWidgetBloc(),
          ),
        ],
        child: BlocBuilder<MainScreenBloc, MainScreenState>(
          builder: (context, state) {
            return BlocBuilder<AnimatedWidgetBloc, AnimatedWidgetState>(
              builder: (context, animatedState) {
                print(animatedState.topOffset);
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    ListView(
                      children: [
                        const _SomeWidget(height: 100),
                        const _SomeWidget(height: 200),
                        _MyPrimaryWidget(
                          height: 200,
                          communities: state.communities,
                          state: animatedState,
                        ),
                        const _SomeWidget(height: 300),
                        const _SomeWidget(height: 200),
                      ],
                    ),
                    if (animatedState.isExpanded == true)
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 1000),
                        top: animatedState.topOffset,
                        // bottom: 0,
                        child: _MyAnimatedWidget(
                          communities: state.communities,
                          state: animatedState,
                          height: 0,
                        ),
                      ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _MyPrimaryWidget extends StatelessWidget {
  final double? height;
  final List<CommunityItem> communities;
  final AnimatedWidgetState state;

  const _MyPrimaryWidget({
    Key? key,
    required this.height,
    required this.communities,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<AnimatedWidgetBloc>(context)
            .expandWidget(context, _widgetKey);
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          key: _widgetKey,
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.blue[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                margin: const EdgeInsets.symmetric(vertical: 10),
                color: Colors.red,
              );
            },
          ),
        ),
      ),
    );
  }
}

class _MyAnimatedWidget extends StatelessWidget {
  final double? height;
  final List<CommunityItem> communities;
  final AnimatedWidgetState state;

  const _MyAnimatedWidget({
    Key? key,
    required this.state,
    required this.height,
    required this.communities,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<AnimatedWidgetBloc>(context).expandWidget(
          context,
          _widgetKey,
        );
      },
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 1000),
        padding: EdgeInsets.all(state.animationStep2 ? 0 : 16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 1000),
          width: getScreenSize(context).width,
          height: state.height,
          decoration: BoxDecoration(
            color: Colors.blue[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListView.builder(
            itemCount: communities.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                margin: const EdgeInsets.symmetric(vertical: 10),
                color: Colors.red,
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SomeWidget extends StatelessWidget {
  final double height;

  const _SomeWidget({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class MyPageRouteBuilder<T> extends PageRouteBuilder<T> {
  final ZoomPageTransitionsBuilder zoomPageTransitionsBuilder;

  MyPageRouteBuilder({
    required RoutePageBuilder pageBuilder,
    required this.zoomPageTransitionsBuilder,
  }) : super(pageBuilder: pageBuilder);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return zoomPageTransitionsBuilder.buildTransitions(
      this,
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}
