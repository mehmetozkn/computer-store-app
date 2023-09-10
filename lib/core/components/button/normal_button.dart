import 'package:flutter/material.dart';

class NormalButton extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onPressed;

  const NormalButton({super.key, this.onPressed, this.child});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
