class AnimatedWidgetState {
  final double height;
  final bool isExpanded;
  final bool animationStep2;
  final double? topOffset;
  final bool startAnimation;
  final double? widgetStartOffset;

  AnimatedWidgetState({
    required this.height,
    this.startAnimation = false,
    this.isExpanded = false,
    required this.topOffset,
    required this.widgetStartOffset,
    this.animationStep2 = false,
  });

  AnimatedWidgetState copyWith({
    double? height,
    required double? topOffset,
     double? widgetStartOffset,
    bool? isExpanded,
    bool? startAnimation,
    bool? animationStep2,
  }) {
    return AnimatedWidgetState(
      height: height ?? this.height,
      widgetStartOffset: widgetStartOffset ?? this.widgetStartOffset,
      isExpanded: isExpanded ?? this.isExpanded,
      animationStep2: animationStep2 ?? this.animationStep2,
      topOffset: topOffset,
      startAnimation: startAnimation ?? this.startAnimation,
    );
  }
}
