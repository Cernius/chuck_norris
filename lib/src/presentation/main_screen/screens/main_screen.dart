import 'package:chuck_norris/src/common/app_module.dart';
import 'package:chuck_norris/src/domain/models/community_item.dart';
import 'package:chuck_norris/src/presentation/common/stateless_extensions.dart';
import 'package:chuck_norris/src/presentation/main_screen/bloc/animated_widget_bloc.dart';
import 'package:chuck_norris/src/presentation/main_screen/bloc/main_screen_bloc.dart';
import 'package:chuck_norris/src/presentation/main_screen/states/animated_widget_state.dart';
import 'package:chuck_norris/src/presentation/main_screen/states/main_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GlobalKey _widgetKey = GlobalKey();

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: Colors.grey[800],
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
        ),
      ),
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
                return Stack(
                  alignment: Alignment.center,
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
                    if (animatedState.startAnimation == true)
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 200),
                        top: animatedState.topOffset,
                        left: animatedState.animationStep2 == true ? 0 : 16,
                        right: animatedState.animationStep2 == true ? 0 : 16,
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
          height: 480,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getStrings().top10,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                  ),
                ),
                Text(
                  getStrings().topCommunitiesOnOutgrid,
                  style: const TextStyle(color: Colors.white38),
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: communities.length >= 4 ? 4 : communities.length,
                    itemBuilder: (BuildContext context, int index) {
                      final CommunityItem community = communities[index];
                      return _BuildCommunityRow(
                        item: community,
                        even: index % 2 == 0,
                      );
                    },
                  ),
                ),
                const Divider(
                  color: Colors.white24,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      getStrings().viewAll,
                      style: const TextStyle(color: Colors.white38),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BuildCommunityRow extends StatelessWidget {
  final CommunityItem item;
  final bool even;

  const _BuildCommunityRow({Key? key, required this.item, required this.even})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: even ? Colors.white10 : null,
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: item.imageUrl != null
                ? CircleAvatar(backgroundImage: NetworkImage(item.imageUrl!))
                : null,
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Text(
                "${item.usersCount} Members",
                style: const TextStyle(
                  color: Colors.white38,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
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
        BlocProvider.of<AnimatedWidgetBloc>(context).collapseWidget();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: getScreenSize(context).width,
        height: state.height,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(
            state.animationStep2 ? 0 : 10,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getStrings().top10,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
              Text(
                getStrings().topCommunitiesOnOutgrid,
                style: const TextStyle(color: Colors.white38),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: communities.length,
                  // padding to see last widget
                  padding: const EdgeInsets.only(bottom: 60),
                  itemBuilder: (BuildContext context, int index) {
                    final CommunityItem community = communities[index];
                    return _BuildCommunityRow(
                      item: community,
                      even: index % 2 == 0,
                    );
                  },
                ),
              ),
            ],
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
          color: Colors.grey[900],
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
