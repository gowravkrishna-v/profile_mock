import 'package:profile_mock/utilities/theme.dart';
import 'package:flutter/material.dart';

class StadiumButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final Color? backgroundColor;
  const StadiumButton({
    super.key,
    required this.onTap,
    required this.child,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          backgroundColor ?? redAccent,
        ),
        shape: const MaterialStatePropertyAll(
          StadiumBorder(),
        ),
      ),
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}
