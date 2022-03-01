import 'package:flutter/material.dart';

class LoadingDialog extends AlertDialog {
  const LoadingDialog({Key? key})
      : super(key: key,
          title: const Center(
              child: CircularProgressIndicator(
            color: Colors.black,
          )),
        );
}
