import 'package:chuck_norris/src/presentation/main_screen/states/animated_widget_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimatedWidgetBloc extends Cubit<AnimatedWidgetState> {
  final double primaryWidgetHeight = 420;

  AnimatedWidgetBloc()
      : super(
          AnimatedWidgetState(
            height: 420,
            topOffset: null,
            widgetStartOffset: null,
          ),
        );

  void expandWidget(BuildContext context, GlobalKey widgetKey) async {
    getWidgetInfo(widgetKey: widgetKey);
    //Delay to get widget info
    await Future.delayed(const Duration(milliseconds: 50));
    //Step 1 Add animated widget on top on another
    emit(
      state.copyWith(
        topOffset: state.topOffset,
        isExpanded: !state.isExpanded,
        startAnimation: true,
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
    //Step 1 collapse animated Widget
    emit(
      state.copyWith(
        topOffset: state.widgetStartOffset,
        height: primaryWidgetHeight,
        animationStep2: false,
      ),
    );
    await Future.delayed(const Duration(milliseconds: 200));

    //Step 2 remove animated Widget
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
