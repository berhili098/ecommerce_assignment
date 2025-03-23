import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({super.key, required this.text, this.onPressed, this.loading = false});

  final String text;
  final VoidCallback? onPressed;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loading ? () {} : onPressed,
      child:
          loading
              ? CircularProgressIndicator(color: Theme.of(context).colorScheme.onPrimary)
              : Text(text),
    );
  }
}

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.underlined = false,
    this.color,
    this.loading = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool underlined;
  final Color? color;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: loading ? null : onPressed,
      child: Text(
        text,
        style: TextStyle(
          decoration: underlined ? TextDecoration.underline : TextDecoration.none,
          color: color,
        ),
      ),
    );
  }
}
