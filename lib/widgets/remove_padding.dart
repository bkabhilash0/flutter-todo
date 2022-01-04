import 'package:flutter/material.dart';

class RemovePadding extends StatelessWidget {
  final Widget child;
  const RemovePadding({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: child,
    );
  }
}
