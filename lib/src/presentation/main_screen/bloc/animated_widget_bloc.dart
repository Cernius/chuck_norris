import 'package:chuck_norris/src/presentation/main_screen/states/animated_widget_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimatedWidgetBloc extends Cubit<AnimatedWidgetState> {
  AnimatedWidgetBloc()
      : super(
          AnimatedWidgetState(
            height: 400,
            topOffset: null,
            widgetStartOffset: null,
          ),
        );

  void expandWidget(BuildContext context, GlobalKey widgetKey) async {
    getWidgetInfo(widgetKey: widgetKey);
    await Future.delayed(const Duration(milliseconds: 50));
    //Step 1 Add animated widget on top on another

    emit(state.copyWith(topOffset: state.topOffset, startAnimation: true));

    emit(
      state.copyWith(
        topOffset: state.topOffset,
        isExpanded: !state.isExpanded,
      ),
    );
    await Future.delayed(const Duration(milliseconds: 200));
    //Step 2 Expand the animated widget
    emit(
      state.copyWith(
        topOffset: 0,
        animationStep2: true,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }

  void collapseWidget() async {
    emit(
      state.copyWith(
        topOffset: state.widgetStartOffset,
        height: 400,
        animationStep2: false,
      ),
    );
    await Future.delayed(const Duration(milliseconds: 200));

    emit(state.copyWith(
      topOffset: state.topOffset,
      startAnimation: false,
    ));
  }

  void getWidgetInfo({required GlobalKey widgetKey}) async {
    await Future.delayed(const Duration(milliseconds: 50));
    final RenderBox? renderBox =
        widgetKey.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox != null) {
      final Offset offset = renderBox.localToGlobal(Offset.zero);

      int appBarHeight = 50;

      emit(
        state.copyWith(
          topOffset: offset.dy - appBarHeight,
          widgetStartOffset: offset.dy - appBarHeight,
        ),
      );
    }
  }
}
