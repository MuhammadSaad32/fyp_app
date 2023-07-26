import 'package:flutter/material.dart';
class ProgressBar extends StatelessWidget {
  ProgressBar();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
        strokeWidth: 4,
      ),
    );
  }
}
