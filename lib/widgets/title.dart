import 'package:flutter/material.dart';

class PrimaryTitle extends StatelessWidget {
  final String title;
  const PrimaryTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 10),
      // margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}
