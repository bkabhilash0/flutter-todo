import 'package:flutter/material.dart';

class StatRow extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final String value;
  const StatRow({
    Key? key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: Colors.grey.withOpacity(0.3), width: 1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: iconColor,
          ),
          Text(
            title,
            style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                decoration: TextDecoration.none),
          ),
          Text(value,
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  decoration: TextDecoration.none))
        ],
      ),
    );
  }
}
