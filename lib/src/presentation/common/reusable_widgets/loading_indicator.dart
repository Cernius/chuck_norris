import 'package:chuck_norris/src/presentation/common/theme/colors.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: GetColors.orange,
      ),
    );
  }
}
