import 'package:flutter/material.dart';

class BottomNavigationItem extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final IconData icon;
  const BottomNavigationItem({super.key, this.onTap, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
