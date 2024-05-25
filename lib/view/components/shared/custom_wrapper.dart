import 'package:flutter/material.dart';

class CustomWrapper extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  const CustomWrapper({
    super.key,
    this.appBar,
    this.body,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: body,
        ),
      ),
    );
  }
}
