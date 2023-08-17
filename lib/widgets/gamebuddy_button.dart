import 'package:flutter/material.dart';

class GamebuddyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Icon icon;

  const GamebuddyButton(
      {Key? key,
      required this.onPressed,
      required this.buttonText,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon,
        label: Text(buttonText),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
