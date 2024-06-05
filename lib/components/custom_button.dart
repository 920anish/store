import 'package:flutter/material.dart';
import 'package:store/k.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Widget? icon;
  final Color? color; // Optional color parameter

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.color, // Optional color parameter
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: onPressed != null ? (color ?? kPrimaryColor) : Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) icon!,
          if (icon != null) const SizedBox(width: 8),
          Text(text, style: kButtonTextStyle),
        ],
      ),
    );
  }
}
