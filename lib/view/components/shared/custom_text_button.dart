import 'package:profile_mock/utilities/theme.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String child;
  final VoidCallback onTap;
  final Color? textColor;
  const CustomTextButton({
    super.key,
    required this.child,
    required this.onTap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        child,
        style: style5.copyWith(
          color: textColor ?? redAccent,
        ),
      ),
    );
  }
}
