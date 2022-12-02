class AnimatedWidgetState {
  final double height;
  final bool isExpanded;
  final bool animationStep2;
  final double? topOffset;

  AnimatedWidgetState({
    required this.height,
    required this.isExpanded,
    required this.topOffset,
    required this.animationStep2,
  });

  AnimatedWidgetState copyWith({
    double? height,
    required double? topOffset,
    bool? isExpanded,
    bool? animationStep2,
  }) {
    return AnimatedWidgetState(
      height: height ?? this.height,
      isExpanded: isExpanded ?? this.isExpanded,
      animationStep2: animationStep2 ?? this.animationStep2,
      topOffset: topOffset,
    );
  }
}
