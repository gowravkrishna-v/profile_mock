import 'package:profile_mock/utilities/theme.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final VoidCallback onTap;
  const CustomElevatedButton({
    super.key,
    required this.text,
    this.foregroundColor,
    this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        backgroundColor: MaterialStatePropertyAll(
          backgroundColor ?? redAccent,
        ),
        foregroundColor: MaterialStatePropertyAll(
          foregroundColor ?? white,
        ),
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: style5.copyWith(
          color: white,
        ),
      ),
    );
  }
}
