import 'package:chuck_norris/src/presentation/main_screen/states/animated_widget_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimatedWidgetBloc extends Cubit<AnimatedWidgetState> {
  AnimatedWidgetBloc()
      : super(
          AnimatedWidgetState(
            height: 400,
            isExpanded: false,
            animationStep2: false,
            topOffset: null,
          ),
        );

  void expandWidget(BuildContext context, GlobalKey widgetKey) async {
    getWidgetInfo(widgetKey: widgetKey);
    await Future.delayed(const Duration(milliseconds: 100));
    emit(
      state.copyWith(
        topOffset: state.isExpanded == false ? state.topOffset : null,
        isExpanded: !state.isExpanded,
      ),
    );
    await Future.delayed(const Duration(milliseconds: 100));
    emit(
      state.copyWith(
        topOffset: state.topOffset,
        height: !state.isExpanded == true
            ? MediaQuery.of(context).size.height
            : 400,
      ),
    );
    await Future.delayed(const Duration(milliseconds: 100));
    emit(
      state.copyWith(
        topOffset: state.isExpanded == false ? 0 : null,
        animationStep2: true,
      ),
    );
  }

  void getWidgetInfo({required GlobalKey widgetKey}) async {
    if (state.topOffset == null) {
      await Future.delayed(const Duration(milliseconds: 50));
      final RenderBox? renderBox =
          widgetKey.currentContext?.findRenderObject() as RenderBox?;

      if (renderBox != null) {
        final Offset offset = renderBox.localToGlobal(Offset.zero);

        emit(state.copyWith(topOffset: offset.dy));
      }
    }
  }
}
