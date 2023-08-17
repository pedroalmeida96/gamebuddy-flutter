import 'package:flutter/material.dart';

class GamebuddyTextField extends StatelessWidget {
  final String labelText;
  final String? initialText;
  final bool isEnabled;
  final TextEditingController controller;

  const GamebuddyTextField({
    super.key,
    required this.labelText,
    this.initialText,
    this.isEnabled = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    controller.text = initialText == null ? controller.text : initialText!;

    return TextFormField(
      enabled: isEnabled,
      controller: controller,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        filled: true,
        fillColor: isEnabled ? Colors.white : Colors.grey[200],
        contentPadding: const EdgeInsets.all(12),
      ),
    );
  }
}
