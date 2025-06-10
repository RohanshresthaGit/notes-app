import 'package:flutter/material.dart';

class AndroidButton extends StatelessWidget {
  const AndroidButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isHighlight = false,
  });
  final String title;
  final VoidCallback onPressed;
  final bool isHighlight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
        fixedSize: WidgetStateProperty.all(const Size(150, 50)),
        backgroundColor: WidgetStateProperty.all(
          isHighlight
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.secondaryContainer,
        ),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
      child: Text(title),
    );
  }
}
